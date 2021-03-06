//
//  CategoryDetailTVC.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/13/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryDetailTVC: UITableViewController {
    @IBOutlet weak var headerView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!


    var selectedSection:Int? {
        didSet {
            tableView.reloadData()
        }
    }
    var selectedButton:UIButton!
    var category:Category!
    
    var selectedCategory:Category? {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerReusableCell(CategoryCell.self)
        tableView.registerReusableHeaderFooterView(CategoryHeaderView.self)
        tableView.estimatedSectionHeaderHeight = 75.0
        tableView.rowHeight = 150.0
        tableView.tableFooterView = UIView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for  category in category.subCategories {
            let button = UIButton(type: .custom)
            button.setTitle("\(String(describing: category.name!))", for: .normal)
            
            button.backgroundColor = .lightGray
            button.setTitleColor(.white, for: .normal)
            button.tag = category.id
            button.addTarget(self, action:#selector(CategoryDetailTVC.onSubCategoryClickAction), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func onSubCategoryClickAction(sender:UIButton) {
        
        let cat = category.subCategories.first(where: {$0.id == sender.tag})
        if  selectedCategory == nil{
            selectedButton = sender

        } else {
            selectedButton.isSelected = false
            selectedButton.backgroundColor = .lightGray
            selectedButton = sender
            selectedSection = nil
        }
        selectedButton.isSelected = true
        selectedButton.backgroundColor = .systemGreen
        selectedCategory = cat
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (selectedCategory == nil) ? 0 : (selectedCategory?.products.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedSection == nil) ? 0 : (selectedSection == section ? 1 : 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let product = selectedCategory?.products[indexPath.section]
        cell.product = product
        //cell.nameLbl.text = product.name

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:CategoryHeaderView? = tableView.dequeueReusableHeaderFooterView()
        let product = selectedCategory?.products[section]
        headerView?.nameLbl.text = (product?.name)! + " (\(product?.variants.count ?? 0))"
        headerView?.section = section
        let bv = (UIView.init())
        bv.frame = headerView?.bounds ?? .zero
        bv.backgroundColor = .white
        headerView?.backgroundView = bv
         headerView?.chevronBtn.isSelected = (headerView?.section == selectedSection)
        headerView?.expandHandler = { section in
            if self.selectedSection == nil {
                self.selectedSection = section
                headerView?.chevronBtn.isSelected = true
            }
            else if self.selectedSection == section {
                self.selectedSection = nil
                headerView?.chevronBtn.isSelected = false
            }
            else {
                self.selectedSection = section
                headerView?.chevronBtn.isSelected = true
            }
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 75.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

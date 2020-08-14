//
//  ProductTVC.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/14/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class ProductTVC: UITableViewController {

    var rankings:[Rank]!
    @IBOutlet weak var stackView: UIStackView!


    var selectedSection:Int? {
        didSet {
            tableView.reloadData()
        }
    }
    var selectedButton:UIButton!
    var rank:Rank? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedProduct:Product? {
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
        for  (i,rank) in rankings.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle("\(String(describing: rank.rankType))", for: .normal)
            button.backgroundColor = .lightGray
            button.setTitleColor(.white, for: .normal)
            button.tag = i + 1
            button.addTarget(self, action:#selector(ProductTVC.onRankTypeClickAction), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc func onRankTypeClickAction(sender:UIButton) {
           
        let rank = rankings[sender.tag - 1]
        if  self.rank == nil{
               selectedButton = sender

           } else {
               selectedButton.isSelected = false
               selectedButton.backgroundColor = .lightGray
               selectedButton = sender
               selectedSection = nil
           }
           selectedButton.isSelected = true
           selectedButton.backgroundColor = .systemGreen
        self.rank = rank
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return rank?.prodcts.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedSection == nil) ? 0 : (selectedSection == section ? 1 : 0)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CategoryCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.product = rank?.prodcts[indexPath.section]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:CategoryHeaderView? = tableView.dequeueReusableHeaderFooterView()
        headerView?.nameLbl.text = (rank?.prodcts[section].name)! + " (\(rank?.products[section].count ?? 0))"
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

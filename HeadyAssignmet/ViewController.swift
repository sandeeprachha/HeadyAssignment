//
//  ViewController.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categoryRank:CategoryAndRank? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var selectedSection:Int? {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var popularButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.registerReusableHeaderFooterView(CategoryHeaderView.self)
        tableView.estimatedSectionHeaderHeight = 1.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()

        fetchCategories()
    }
    
    func fetchCategories() {
        ProgressHUD.show("Loading...")
        APIClient.sharedInstance.performAPIRequest(Contants.Url.categories, methodType: .GET, parameters: nil) { (response:Result<CategoryAndRank, Error>) in
            switch response {
            case .success (let value):
                DispatchQueue.main.async {
                    let realm = RealmStorage.sharedInstance.realm
                    do {
                        try realm.write {
                            realm.add(value.categories, update: .modified)
                            realm.delete(realm.objects(Rank.self))
                            realm.add(value.rankings)
                        }
                        self.categoryRank = value
                        self.popularButton.isEnabled = true
                    } catch let error {
                        print(error)
                        self.showError(error: error)
                    }
                    ProgressHUD.dismiss()
                }
                break
            case .failure (let error):
                DispatchQueue.main.async {
                    print(error)
                    ProgressHUD.dismiss()
                    self.showError(error: error)
                }
                break
            }
        }
    }
    @IBAction func popularAction(_ sender: Any) {
        
    }
    
    func showError(error:Error) {
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        let alert = UIAlertController.init(title: "Error!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryProductsSegue" {
            let vc = segue.destination as? CategoryDetailTVC
            guard let cell = sender as? UITableViewCell else { return  }
            let indexPath = tableView.indexPath(for: cell)
            vc?.category = categoryRank?.mainCategories[indexPath!.section].subCategories[indexPath!.row]
        } else {
            guard categoryRank != nil else {
                return
            }
            let vc = segue.destination as? ProductTVC
            vc?.rankings = categoryRank?.rankings
        }
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  categoryRank?.mainCategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedSection == nil {
            return 0
        }
        return (self.selectedSection == section) ? (categoryRank?.mainCategories[section].subCategories.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CategoryCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCategoryCell", for: indexPath)
        let category = categoryRank?.mainCategories[indexPath.section].subCategories[indexPath.row]
        cell.textLabel?.text = category?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:CategoryHeaderView? = tableView.dequeueReusableHeaderFooterView()
        let category = categoryRank?.mainCategories[section]
        headerView?.nameLbl.text = (category?.name)! + " (\(category?.childCategories.count ?? 0))"
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let category = categoryRank?.mainCategories[indexPath.section].subCategories[indexPath.row]
//        guard category?.childCategories.count == 0 else {
//          selectedSection = categoryRank?.mainCategories.firstIndex(of: category!)
//            return
//        }
          
//        self.performSegue(withIdentifier: "showProductSegue", sender: self)
    }
    
}

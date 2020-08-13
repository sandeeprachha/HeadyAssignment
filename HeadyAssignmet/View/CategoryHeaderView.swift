//
//  CategoryHeaderView.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/13/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class CategoryHeaderView: UITableViewHeaderFooterView, Reusable {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var chevronBtn: UIButton!
    var expandHandler: ((_ section:Int) -> Void)?
    var section:Int!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static var nib: UINib?
    {
        return UINib(nibName: String(describing:CategoryHeaderView.self), bundle: nil)
    }
    @IBAction func expandAction(_ sender: Any) {
        expandHandler!(self.section)
    }
    
}



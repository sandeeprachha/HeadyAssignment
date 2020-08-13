//
//  VariantCell.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/13/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit

class VariantCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var varientView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var nib: UINib?
    {
        return UINib(nibName: String(describing:VariantCell.self), bundle: nil)
    }
}

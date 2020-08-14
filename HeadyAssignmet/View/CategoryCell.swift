//
//  CategoryCell.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/13/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryCell: UITableViewCell, Reusable {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var variantsCollectionView: UICollectionView!

    var product:Product? {
        didSet {
            variantsCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        variantsCollectionView.registerReusableCell(VariantCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib?
    {
        return UINib(nibName: String(describing:CategoryCell.self), bundle: nil)
    }
    
}

extension CategoryCell:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (product == nil) ? 0 : (product?.variants.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:VariantCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let variant =  product?.variants[indexPath.row]
        cell.varientView.backgroundColor = .red
        cell.varientView.layer.cornerRadius = 25.0
        let size = (variant?.size.value == nil) ? "N/A" : "\(variant?.size.value! ?? 0)"
        cell.sizeLbl.text = "Size: \(size)"
        cell.priceLbl.text = "Price: \(variant?.price ?? 0.0)"
        return cell
    }
    
    
}

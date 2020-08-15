//
//  Product.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift
import Realm



@objcMembers class Product: Object, Decodable {
     dynamic var id = 0
     dynamic var name:String!
     dynamic var dateAdded = Date()
    let variants = List<Variant>()
     dynamic var tax: Tax!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateAdded = "date_added"
        case variants
        case tax
    }
    required init(from decoder: Decoder) throws
    {
        super.init()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let vari = try container.decode([Variant].self, forKey: .variants)
        variants.append(objectsIn: vari)
        tax = try container.decode(Tax.self, forKey: .tax)
    }
    
    required init() {
        super.init()
    }
    
    
}

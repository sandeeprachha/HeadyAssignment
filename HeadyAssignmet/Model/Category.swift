//
//  Category.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Category: Object, Decodable {
     dynamic var id = 0
     dynamic var name:String!
    let products = List<Product>()
    let childCategories = List<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case products
        case childCategories = "child_categories"
    }
    required init(from decoder: Decoder) throws
    {
        super.init()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let pros = try container.decode([Product].self, forKey: .products)
        products.append(objectsIn: pros)
        let chi = try container.decode([Int].self, forKey: .childCategories)
        childCategories.append(objectsIn: chi)

    }
    
    required init() {
        super.init()
    }
}

extension Category
{
    public var subCategories: [Category] {
       return RealmStorage.sharedInstance.realm.objects(Category.self).filter("id IN %@", childCategories).map{$0}
    }

}

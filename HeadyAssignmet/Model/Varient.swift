//
//  Varient.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Variant: Object, Decodable {

      dynamic var id = 0
      dynamic var color = ""
     let  size = RealmOptional<Int>()
     dynamic var  price = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    enum CodingKeys: String, CodingKey {
           case id
           case color
           case size
           case price
       }
    
    required init() {
        super.init()

    }
    required init(from decoder: Decoder) throws
       {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           
           id = try container.decode(Int.self, forKey: .id)
           color = try container.decode(String.self, forKey: .color)
           size.value = try container.decodeIfPresent(Int.self, forKey: .size)
           price = try container.decode(Double.self, forKey: .price)


           super.init()
       }
}

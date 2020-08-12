//
//  Tax.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Tax: Object, Decodable {
      dynamic var name = ""
     dynamic var value = 0.0
    
    enum CodingKeys: String, CodingKey {
           case name
           case value
       }
    
       required init(from decoder: Decoder) throws
       {
          let container = try decoder.container(keyedBy: CodingKeys.self)
          name = try container.decode(String.self, forKey: .name)
          value = try container.decode(Double.self, forKey: .value)
         super.init()
       }
       
       required init() {
           super.init()
       }

}

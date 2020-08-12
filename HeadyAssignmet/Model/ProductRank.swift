//
//  Rank.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class ProductRank: Object, Decodable {
     dynamic var id = 0
     dynamic var count = 0

    enum CodingKeys: String, CodingKey {
        case id
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares
    }
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        if let viewCount = try container.decodeIfPresent(Int.self, forKey: .viewCount) {
            count = viewCount
        }
        if let orderCount = try container.decodeIfPresent(Int.self, forKey: .orderCount) {
            count = orderCount
        }
        if let shares = try container.decodeIfPresent(Int.self, forKey: .shares) {
            count = shares
        }

        super.init()
    }
    
    required init() {
        super.init()
    }
}

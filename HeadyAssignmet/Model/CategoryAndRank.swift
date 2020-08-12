//
//  CategoryAndRank.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class CategoryAndRank: Object, Decodable {
    let categories = List<Category>()
    let rankings = List<Rank>()


    enum CodingKeys: String, CodingKey {
        case categories
        case rankings
    }
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let tempCategories = try container.decode([Category].self, forKey: .categories)
        categories.append(objectsIn: tempCategories)
        let temprankings = try container.decode([Rank].self, forKey: .rankings)
        rankings.append(objectsIn: temprankings)

        super.init()
    }
    
    required init() {
        super.init()

    }
}

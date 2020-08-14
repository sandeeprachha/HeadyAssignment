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
//
//class CategoryAndRank: Object, Decodable {
//    let categories = List<Category>()
//    let rankings = List<Rank>()
//
//
//    enum CodingKeys: String, CodingKey {
//        case categories
//        case rankings
//    }
//    required init(from decoder: Decoder) throws
//    {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        let tempCategories = try container.decode([Category].self, forKey: .categories)
//        categories.append(objectsIn: tempCategories)
//        let temprankings = try container.decode([Rank].self, forKey: .rankings)
//        rankings.append(objectsIn: temprankings)
//
//        super.init()
//    }
//
//    required init() {
//        super.init()
//
//    }
//}

struct CategoryAndRank: Decodable {
    let categories:[Category]
    let rankings:[Rank]

    var mainCategories:[Category] {
        let cat = categories.filter { $0.childCategories.count > 0}
        let fitered = cat
        var finalCategory = [Category]()
        for category in cat {
            for cat in fitered {
                if category.childCategories.contains(cat.id) {
                    if !finalCategory.contains(category){
                        finalCategory.append(category)
                    }
                }
            }
        }
        return finalCategory
    }
}

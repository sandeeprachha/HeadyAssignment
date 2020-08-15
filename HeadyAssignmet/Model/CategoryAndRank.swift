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

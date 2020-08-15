//
//  Rank.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

enum RankType: String {
  case MostViewed = "Most Viewed Products"
  case MostOrdered = "Most OrdeRed"
  case MostShared = "Most Shared"
}

@objcMembers class Rank: Object, Decodable, Mappable {
    
    
    var rankType = RankType.MostViewed.rawValue
    var products = List<ProductRank>()
    var rank: RankType {
      get {
        return RankType(rawValue: rankType)!
      }
      set {
        rankType = newValue.rawValue
      }
    }
    
    enum CodingKeys: String, CodingKey {
           case ranking
           case products
       }
    
    required convenience init?(map: Map) {
        self.init()

    }
    
    func mapping(map: Map) {
        products <- map["products"]
    }
    
       required init(from decoder: Decoder) throws
       {
        super.init()

          let container = try decoder.container(keyedBy: CodingKeys.self)
          rankType = try container.decode(String.self, forKey: .ranking)
          let prods = try container.decode([ProductRank].self, forKey: .products)
        products.removeAll()
          products.append(objectsIn: prods)

       }
       
       required init() {
           super.init()
       }
}

extension Rank {
    public var prodcts: [Product] {
        let productctsArr = Array(products)
        return RealmStorage.sharedInstance.realm.objects(Product.self).filter("id IN %@", productctsArr.map{$0.id}).map{$0}
    }
}

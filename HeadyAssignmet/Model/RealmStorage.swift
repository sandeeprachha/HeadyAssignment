//
//  RealmStorage.swift
//  HeadyAssignmet
//
//  Created by Sandeep on 8/12/20.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import RealmSwift

class RealmStorage: NSObject {
    static let sharedInstance = RealmStorage()
    var realm = try! Realm()

}

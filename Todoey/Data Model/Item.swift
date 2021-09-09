//
//  Item.swift
//  Todoey
//
//  Created by thinh on 12/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
//
//  Items.swift
//  Todoey
//
//  Created by thinh on 12/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: CategoryList.self, property:"items")
}

//
//  CategoryList.swift
//  Todoey
//
//  Created by thinh on 12/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class CategoryList: Object {
    @objc dynamic var name: String = ""
    let items: List<Item> = List<Item>()
}

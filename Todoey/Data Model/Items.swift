//
//  Items.swift
//  Todoey
//
//  Created by thinh on 12/8/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class Items: Object {
   @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
}

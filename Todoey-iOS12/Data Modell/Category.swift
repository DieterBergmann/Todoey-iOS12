//
//  Category.swift
//  Todoey-iOS12
//
//  Created by Dieter Bergmann on 02.11.18.
//  Copyright © 2018 Dieter Bergmann. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

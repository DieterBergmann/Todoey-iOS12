//
//  Item.swift
//  Todoey-iOS12
//
//  Created by Dieter Bergmann on 02.11.18.
//  Copyright © 2018 Dieter Bergmann. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    // Inversere Beziehung zur parent Category 
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

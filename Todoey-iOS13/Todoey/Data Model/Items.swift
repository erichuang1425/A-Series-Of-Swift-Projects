//
//  Items.swift
//  Todoey
//
//  Created by Eric Huang on 7/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Items: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var checked: Bool = false
    @objc dynamic var dateCreated:Date?
    var parentRelationship = LinkingObjects(fromType: Category.self, property: "items")
    
}

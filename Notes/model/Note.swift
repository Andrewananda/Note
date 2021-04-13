//
//  Note.swift
//  Notes
//
//  Created by Andrew Ananda on 09/04/2021.
//  Copyright © 2021 Andrew Ananda. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var data = Date()
    
    override static func primaryKey() -> String? {
        return "_id"
    }
    
}

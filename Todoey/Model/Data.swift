//
//  Data.swift
//  Todoey
//
//  Created by user on 09.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    
}

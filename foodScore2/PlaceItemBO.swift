//
//  PlaceItemBO.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/21.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import Foundation
import RealmSwift

class placeItemBO:Object{
    @objc dynamic var placeID:String = ""
    @objc dynamic var item:String = ""
    @objc dynamic var price = 0
    @objc dynamic var prize = 0
    @objc dynamic var createDate = Date()
    @objc dynamic var photo:String = ""
    @objc dynamic var serial = 0
    @objc dynamic var placeKey:String = ""
    override static func primaryKey() -> String? {
    return "placeKey"
    }
}

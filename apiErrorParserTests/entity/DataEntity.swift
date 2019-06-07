//
// Created by Дмитрий Михайлюк on 2019-06-06.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

class DataEntity: Mappable {

    private(set) var id: Int = 0
    private(set) var userName: String = ""
    private(set) var age: Int = 0

    init(id: Int = 0, userName: String = "", age: Int = 0) {
        self.id = id
        self.userName = userName
        self.age = age
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        userName <- map["userName"]
        age <- map["age"]
    }
}

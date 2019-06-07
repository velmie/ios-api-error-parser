//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorSourceEntity: Mappable {

    private(set) var field: String? = nil

    init(field: String? = nil) {
        self.field = field
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        field <- map["field"]
    }
}

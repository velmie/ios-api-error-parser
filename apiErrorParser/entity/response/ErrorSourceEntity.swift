//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

open class ErrorSourceEntity: Mappable {

    private(set) var field: String? = nil

    public init(field: String? = nil) {
        self.field = field
    }

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        field <- map["field"]
    }
}

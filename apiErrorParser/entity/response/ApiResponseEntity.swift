//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

open class ApiResponseEntity<T: Mappable>: Mappable {

    private(set) var data: T? = nil
    private(set) var errors: Array<ErrorMessageEntity> = []

    public init(data: T? = nil, errors: Array<ErrorMessageEntity> = []) {
        self.data = data
        self.errors = errors
    }

    required public init?(map: Map) {
    }

    public func mapping(map: Map) {
        data <- map["data"]
        errors <- map["errors"]
    }
}

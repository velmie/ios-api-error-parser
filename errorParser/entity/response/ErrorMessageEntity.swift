//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorMessageEntity: Mappable {

    private(set) var code: String = ""
    private(set) var target: String = ""
    private(set) var source: ErrorSourceEntity? = nil
    private(set) var message: String = ""

    init(code: String = "", target: String = "", source: ErrorSourceEntity? = nil, message: String = "") {
        self.code = code
        self.target = target
        self.source = source
        self.message = message
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        code <- map["code"]
        target <- map["target"]
        source <- map["source"]
        message <- map["message"]
    }
}

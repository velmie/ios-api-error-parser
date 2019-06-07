//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation

class ParserMessageEntity {

    let target: String
    let source: ErrorSourceEntity?
    let code: String
    let message: String

    init(target: String, source: ErrorSourceEntity?, code: String, message: String) {
        self.target = target
        self.source = source
        self.code = code
        self.message = message
    }
}

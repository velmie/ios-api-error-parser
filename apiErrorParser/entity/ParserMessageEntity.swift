//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation

public class ParserMessageEntity {

    public let target: String
    public let source: ErrorSourceEntity?
    public let code: String
    public let message: String

    init(target: String, source: ErrorSourceEntity?, code: String, message: String) {
        self.target = target
        self.source = source
        self.code = code
        self.message = message
    }
}

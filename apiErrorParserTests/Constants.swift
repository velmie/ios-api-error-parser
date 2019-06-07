//
// Created by Дмитрий Михайлюк on 2019-06-06.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation

struct Constants {

    struct Message {
        static let DEFAULT = "DEFAULT"
        static let EMPTY_BALANCE = "It seems that user has empty balance"
        static let PUNCTUATION_ERROR = "It seems that the password provided is missing a punctuation character"
        static let PASSWORD_DO_NOT_MATCH = "It seems that the password and password confirmation fields do not match"
    }

    struct ErrorCode {
        static let INSUFFICIENT_FUNDS = "insufficient_funds"
        static let INVALID_PUNCTUATION = "invalid_punctuation"
        static let INVALID_PASSWORD_CONFIRMATION = "invalid_password_confirmation"
        static let UNKNOWN = "unknown_code"
    }

    struct TARGET {
        static let FIELD = "field"
        static let COMMON = "common"
    }

    static let JSON = """
                                            {
                        "data":
                          {
                            "id": 1,
                            "userName": "Tom",
                            "age": 21
                          },
                      "errors": [
                          {
                            "code": "insufficient_funds",
                            "target": "common",
                            "source": {
                              "field": "userBalance",
                            },
                            "message": "Hi Nick, it seems that user has empty balance"
                          },
                          {
                            "code": "invalid_punctuation",
                            "target": "field",
                            "source": {
                              "field": "userPassword"
                            },
                            "message": "Hi Vova, it seems that the password provided is missing a punctuation character"
                          },
                          {
                            "code": "unknown_code",
                            "target": "common",
                            "source": {
                              "field": "serverError",
                            },
                            "message": "Oh no! Something went wrong"
                          }
                          {
                            "code": "invalid_password_confirmation",
                            "target": "field",
                            "source": {
                              "field": "userPassword",
                            },
                            "message": "Hi Lesha, it seems that the password and password confirmation fields do not match"
                          },
                        ]
                      }
                      """
}

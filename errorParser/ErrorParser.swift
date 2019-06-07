//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorParser {

    let errorMessages: Dictionary<String, String>
    let defaultErrorMessage: String

    init(errorMessages: Dictionary<String, String>, defaultErrorMessage: String) {
        self.errorMessages = errorMessages
        self.defaultErrorMessage = defaultErrorMessage
    }

    func parse<T: Mappable>(json: [String: Any]) -> ParserResponseEntity<T>? {
        if let response = ApiResponseEntity<T>(JSON: json) {
            return ParserResponseEntity(data: response.data, errors: getErrors(errors: response.errors))
        } else {
            return nil
        }
    }

    func parse<T>(response: ApiResponseEntity<T>) -> ParserResponseEntity<T> {
        return ParserResponseEntity(data: response.data, errors: getErrors(errors: response.errors))
    }

    func getErrors(errors: Array<ErrorMessageEntity>) -> Array<ParserMessageEntity> {
        return errors.map({
            ParserMessageEntity(target: $0.target, source: $0.source, code: $0.code,
                    message: getMessage(errorCode: $0.code))
        })
    }

    func getMessage(errorCode: String) -> String {
        if let error = errorMessages[errorCode] {
            return error
        } else {
            return defaultErrorMessage
        }
    }

    func getMessage(errorMessage: ErrorMessageEntity) -> String {
        if let error = errorMessages[errorMessage.code] {
            return error
        } else {
            return defaultErrorMessage
        }
    }

    func getFirstMessage(errors: Array<ErrorMessageEntity>) -> String {
        if let error = errors.first {
            return getMessage(errorMessage: error)
        } else {
            return defaultErrorMessage
        }
    }
}

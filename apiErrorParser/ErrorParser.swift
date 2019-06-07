//
// Created by Дмитрий Михайлюк on 2019-05-30.
// Copyright (c) 2019 velmie. All rights reserved.
//

import Foundation
import ObjectMapper

public class ErrorParser {

    private let errorMessages: Dictionary<String, String>
    private let defaultErrorMessage: String

    public init(errorMessages: Dictionary<String, String>, defaultErrorMessage: String) {
        self.errorMessages = errorMessages
        self.defaultErrorMessage = defaultErrorMessage
    }

    public func parse<T: Mappable>(json: [String: Any]) -> ParserResponseEntity<T>? {
        if let response = ApiResponseEntity<T>(JSON: json) {
            return ParserResponseEntity(data: response.data, errors: getErrors(errors: response.errors))
        } else {
            return nil
        }
    }

    public func parse<T>(response: ApiResponseEntity<T>) -> ParserResponseEntity<T> {
        return ParserResponseEntity(data: response.data, errors: getErrors(errors: response.errors))
    }

    public func getErrors(errors: Array<ErrorMessageEntity>) -> Array<ParserMessageEntity> {
        return errors.map({
            ParserMessageEntity(target: $0.target, source: $0.source, code: $0.code,
                    message: getMessage(errorCode: $0.code))
        })
    }

    public func getMessage(errorCode: String) -> String {
        if let error = errorMessages[errorCode] {
            return error
        } else {
            return defaultErrorMessage
        }
    }

    public func getMessage(errorMessage: ErrorMessageEntity) -> String {
        if let error = errorMessages[errorMessage.code] {
            return error
        } else {
            return defaultErrorMessage
        }
    }

    public func getFirstMessage(errors: Array<ErrorMessageEntity>) -> String {
        if let error = errors.first {
            return getMessage(errorMessage: error)
        } else {
            return defaultErrorMessage
        }
    }
}

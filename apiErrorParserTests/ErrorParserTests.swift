//
//  ErrorParserTests.swift
//  errorParserTests
//
//  Created by Дмитрий Михайлюк on 5/30/19.
//  Copyright © 2019 velmie. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import apiErrorParser

class ErrorParserTests: XCTestCase {

    private let parser: ErrorParser = ErrorParser(errorMessages:
    [Constants.ErrorCode.INSUFFICIENT_FUNDS: Constants.Message.EMPTY_BALANCE,
     Constants.ErrorCode.INVALID_PASSWORD_CONFIRMATION: Constants.Message.PASSWORD_DO_NOT_MATCH,
     Constants.ErrorCode.INVALID_PUNCTUATION: Constants.Message.PUNCTUATION_ERROR],
            defaultErrorMessage: Constants.Message.DEFAULT)

    private var responseFromObject: ApiResponseEntity<DataEntity>? = nil

    override func setUp() {
        responseFromObject = ApiResponseEntity<DataEntity>(JSON: getJson())
    }

    private func getJson() -> [String: Any] {
        var jsonResult: Any? = nil
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "test", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        } catch {
        }
        return jsonResult as! [String: Any]
    }

    func testMessageFromCode() {
        XCTAssertEqual(parser.getMessage(errorCode: Constants.ErrorCode.INVALID_PUNCTUATION), Constants.Message.PUNCTUATION_ERROR)
        XCTAssertEqual(parser.getMessage(errorCode: Constants.ErrorCode.UNKNOWN), Constants.Message.DEFAULT)
    }

    func testFirstErrorMessage() {
        XCTAssertEqual(parser.getFirstMessage(errors: responseFromObject!.errors), Constants.Message.EMPTY_BALANCE)
        var errors = responseFromObject!.errors
        errors.insert(responseFromObject!.errors[2], at: 0)
        XCTAssertEqual(parser.getFirstMessage(errors: errors), Constants.Message.DEFAULT)
    }

    func testMessage() {
        XCTAssertEqual(parser.getMessage(errorMessage: responseFromObject!.errors.last!), Constants.Message.PASSWORD_DO_NOT_MATCH)
        XCTAssertEqual(parser.getMessage(errorMessage: responseFromObject!.errors[2]), Constants.Message.DEFAULT)
    }

    func testListError() {
        checkErrorList(errors: responseFromObject!.errors, parserErrors: parser.getErrors(errors: responseFromObject!.errors))
    }

    func testParsing() {
        let parserResponse = parser.parse(response: responseFromObject!)

        checkData(responseData: responseFromObject!.data!, parserData: parserResponse.data!)
        checkErrorList(errors: responseFromObject!.errors, parserErrors: parserResponse.errors)
    }

    private func checkData(responseData: DataEntity, parserData: DataEntity) {
        XCTAssertEqual(responseData.age, parserData.age)
        XCTAssertEqual(responseData.userName, parserData.userName)
        XCTAssertEqual(responseData.id, parserData.id)
    }

    private func checkErrorList(errors: Array<ErrorMessageEntity>, parserErrors: Array<ParserMessageEntity>) {
        XCTAssertEqual(errors[0].code, parserErrors[0].code)
        XCTAssertEqual(errors[1].code, parserErrors[1].code)
        XCTAssertEqual(errors[2].code, parserErrors[2].code)
        XCTAssertEqual(errors[3].code, parserErrors[3].code)

        XCTAssertEqual(parserErrors[0].message, Constants.Message.EMPTY_BALANCE)
        XCTAssertEqual(parserErrors[1].message, Constants.Message.PUNCTUATION_ERROR)
        XCTAssertEqual(parserErrors[2].message, Constants.Message.DEFAULT)
        XCTAssertEqual(parserErrors[3].message, Constants.Message.PASSWORD_DO_NOT_MATCH)

        XCTAssertNotNil(parserErrors[0].source)
        XCTAssertNotNil(parserErrors[3].source)
    }

    func parseTest() {
        let parserResponseFromJson: ParserResponseEntity<DataEntity>? = parser.parse(json: getJson())
        checkData(responseData: responseFromObject!.data!, parserData: parserResponseFromJson!.data!)
        checkErrorList(errors: responseFromObject!.errors, parserErrors: parserResponseFromJson!.errors)
    }
}

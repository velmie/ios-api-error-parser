# API Error Parser

Library for handling errors in the application based on codes.

- [API response description](#api-response-description)
- [Version](#version)
- [How it works](#how-it-works)
- [Installation](#installation)
- [License](#license)

# API response description
**For processing, the errors must comply with the standard:**
Each error from server should be in next format:

- ***code***: a unique code of an error. Used to identify error from the dictionary.
- ***target***: some sort of error scope
- ***field*** - the error related to certain field
- ***common*** - the error related to whole request
- ***message (OPTIONAL)***: the error message for developers (use it only for debug purposes)
- ***source (OPTIONAL)***: a container for additional data. Arbitrary structure: ( field: resource object attribute name. Required if target set to field. )

Example:
```json
{
"data": [
     {
       "id": 1,
       "userName": "Tom",
       "age": 21
     },
     {
       "id": 2,
       "userName": "Bob",
       "age": 22
     }
   ],
  "errors": [
    {
      "code": "insufficient_funds",
      "target": "common",
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
      "code": "invalid_password_confirmation",
      "target": "field",
      "source": {
        "field": "userPassword",
        "someAdditionalData": "bla bla bla"
      },
      "message": "Hi Lesha, it seems that the password and password confirmation fields do not match"
    }
  ]
 }
```
# Version
0.0.3

# How it works
The library provides a set of source objects for parsing a server response. All presented objects 
implement the `Mappable` interface.

It is also possible to parse `JSON` by itself and return the already processed result.
For parsing using the library [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)

To initialize the ErrorParser, you must pass to the constructor:
- `errorMessages: Dictionary<String, String>` - the key is the error code and the value of the displayed message
- `defaultErrorMessage: String` - message of unknown errors


**Api parser description:**
- `parse(json: [String: Any])` - parses the `JSON` and returns the processed result
- `parse(response: ApiResponseEntity<T>)` - parses the server response object and returns the processed result
- `getErrors(errors: Array<ErrorMessageEntity>)` - returns a list of processed errors
- `getMessage(errorCode: String)` - returns the message associated with this error code
- `getMessage(errorMessage: ErrorMessageEntity)` - returns the processed error
- `getFirstMessage(errors: Array<ErrorMessageEntity>)` - returns the first processed error from the list

```swift

let parser = ErrorParser(errorMessages: ["no_reps_available": "too_many_repeats".localized,
                                                     "incorrect_sms_code": "incorrect_sms".localized],
                                 defaultErrorMessage: "error_something_wrong".localized)
                                 
let parserResponse: ParserResponseEntity<DataEntity>? = parser.parse(json: json)

```

# Installation

You want to add pod `'ApiErrorParser', '~> version'` similar to the following to your Podfile:

```ruby
target 'MyApp' do
  pod 'ApiErrorParser', '~> version'
end
```
Then run a `pod install` inside your terminal, or from `CocoaPods.app`.

# License

ApiErrorParser is released under the MIT license. See [LICENSE](https://github.com/velmie/ios-api-error-parser/blob/0.0.2/LICENSE) for details.
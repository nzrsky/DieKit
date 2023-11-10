//
//  Created by Alex Nazarov
//

import Foundation
import Darwin
import DieKit
import CoreGraphics

//print("error: it's the text in stdout")
//print(error: "error: it's the text in stderr")
//
//print("\033[31;1;4merror: it's the text ansi colors\n\033[0m")

func throwDecodingError() throws {
//    _ = try JSONDecoder().decode(Int.self, from: "foo".data(using: .utf8)!)
//    throw NSError(domain: "CGError", code: 1003)
    throw CocoaError(.coderValueNotFound)
}

func throwNSError() throws {
    let _ = try FileManager.default.attributesOfItem(atPath: "/path/to/nonexistent/file")
}



//
//var nserror: Error?
//do {
//    try throwDecodingError()
//} catch {
//    print(error)
//}

do {
    try printOnException({ try throwDecodingError() })
} catch {
    print(error)
}

//let testError = CGError.illegalArgument
//print(String(describing: CGError.invalidContext))
//
//The operation couldn’t be completed. (__C.CGError 1003)
//
////XCTAssertEqual(reader.readStderr(), "error: The operation couldn’t be completed. (CGError: Illegal Argument)\n")

//// Before
//
//import DieKit
//
//do {
//    try encode()
//} catch {
//    print(error)
//
//    /**
//        dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.",
//        underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Unexpected end of file during JSON parse. around line 1, column 0."
//        UserInfo={NSDebugDescription=Unexpected end of file during JSON parse. around line 1, column 0., NSJSONSerializationErrorIndex=0})))
//    */
//}
//
//// After
////import DieKit
//
////do {
////    try encode()
////} catch {
////    print(error)
////    /**
////     error: dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.",
////     underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "Unexpected end of file during JSON parse. around line 1, column 0."
////     UserInfo={NSDebugDescription=Unexpected end of file during JSON parse. around line 1, column 0., NSJSONSerializationErrorIndex=0})))
////     */
//}

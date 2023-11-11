//
//  Copyright (c) Alexey Nazarov, 2022
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import XCTest
@testable import DieKit

final class CatcherTests: XCTestCase {
    func testPrintOnExceptionNoError() throws {
        let reader = StderrReader()
        let result = try printOnException { return 42 }
        XCTAssertEqual(result, 42)
        print(error: "")
        XCTAssertEqual(reader.readStderr()!, "\n")
    }

    func testDieOnExceptionNoError() throws {
        let reader = StderrReader()
        let result = dieOnException { return 42 }
        XCTAssertEqual(result, 42)
        print(error: "")
        XCTAssertEqual(reader.readStderr()!, "\n")
    }

    func testPrintOnExceptionWithError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            struct TestError: Error {}
            throw TestError()
        })
        print(error: "")
        XCTAssertTrue(reader.readStderr()!.contains("TestError"))
    }

    func testPrintOnExceptionWithDecodingError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Test Error"))
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr()!, "error: dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: \"Test Error\", underlyingError: nil))\n\n")
    }

    func testPrintOnExceptionWithEncodingError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw EncodingError.invalidValue(0, .init(codingPath: [], debugDescription: "foo"))
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr()!, "error: invalidValue(0, Swift.EncodingError.Context(codingPath: [], debugDescription: \"foo\", underlyingError: nil))\n\n")
    }

#if canImport(Foundation)
    func testPrintOnExceptionWithNSError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw NSError(domain: "foo", code: 1, userInfo: [NSLocalizedRecoveryOptionsErrorKey: ["bip"]])
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: The operation couldn’t be completed. (foo error 1.)\noptions: \n– bip\n\n")
    }

    func testPrintOnExceptionWithLocalizedError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw CustomLocalizedError()
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: Test Reason\n Test Description\n Test Description\noptions:\n– Test Suggestion\n\n")
    }

    func testPrintOnExceptionWithCocoaError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw CocoaError(.coderInvalidValue)
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: CocoaError(_nsError: Error Domain=NSCocoaErrorDomain Code=4866 \"The data couldn’t be written because it isn’t in the correct format.\")\n\n")
    }

#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS) || (swift(>=5.9) && (swift(>=5.9) && os(visionOS))))
    func testPrintOnExceptionWithMachError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw MachError(.invalidAddress)
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: MachError(_nsError: Error Domain=NSMachErrorDomain Code=1 \"(os/kern) invalid address\")\n\n")
    }
#endif

    func testPrintOnExceptionWithPOSIXError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw POSIXError(.E2BIG)
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: POSIXError(_nsError: Error Domain=NSPOSIXErrorDomain Code=7 \"Argument list too long\")\n\n")
    }

    func testPrintOnExceptionWithURLError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw URLError(.cancelled)
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: URLError(_nsError: Error Domain=NSURLErrorDomain Code=-999 \"(null)\")\n\n")
    }
#endif

#if canImport(CoreFoundation) && (os(macOS) || os(iOS) || os(watchOS) || os(tvOS) || (swift(>=5.9) && (swift(>=5.9) && os(visionOS))))
    func testPrintOnExceptionWithCFSocketError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw CFSocketError.timeout
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: The operation couldn’t be completed. (CFSocketError: Timeout)\n\n")
    }

    func testPrintOnExceptionWithCFError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            func createCFError() -> CFError {
                let domain = "com.example.error" as CFString // Replace with your domain
                let errorCode = 1001 // Replace with your error code
                let userInfoKey = kCFErrorLocalizedDescriptionKey
                let userInfoValue = "An example error occurred." as CFString
                let userInfo = [userInfoKey: userInfoValue] as CFDictionary

                let error = CFErrorCreate(kCFAllocatorDefault, domain, errorCode, userInfo)
                return error!
            }

            throw createCFError()
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: An example error occurred.\n\n")
    }
#endif

#if canImport(CoreGraphics) && (os(macOS) || os(iOS) || os(watchOS) || os(tvOS) || (swift(>=5.9) && (swift(>=5.9) && os(visionOS))))
    func testPrintOnExceptionWithCGError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw CGError.illegalArgument
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: The operation couldn’t be completed. (CGError: Illegal Argument)\n\n")
    }
#endif

#if canImport(IOKit) && (os(macOS) || os(iOS) || os(watchOS) || os(tvOS) || (swift(>=5.9) && os(visionOS)))
    func testPrintOnExceptionWithIOURLError() {
        let reader = StderrReader()
        XCTAssertThrowsError(try printOnException {
            throw kIOURLUnknownError
        })
        print(error: "")
        XCTAssertEqual(reader.readStderr(), "error: The operation couldn’t be completed. (IOURLError: Unknown)\n\n")
    }
#endif
}

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

#if canImport(Foundation)
import Foundation

final class NSErrorInitTests: XCTestCase {
    func testInitializationWithDefaultParameters() {
        let message = "Test Error Message"
        let error = NSError(message: message)

        XCTAssertEqual(error.domain, Bundle.main.bundleIdentifier ?? "DieKit", "Error domain should be default")
        XCTAssertEqual(error.code, 0, "Error code should be default (0)")
        XCTAssertEqual(error.localizedDescription, message, "Localized description should match provided message")
    }

    func testInitializationWithCustomCode() {
        let message = "Test Error Message"
        let errorCode = 100
        let error = NSError(message: message, code: errorCode)

        XCTAssertEqual(error.code, errorCode, "Error code should match provided code")
        XCTAssertEqual(error.localizedDescription, message, "Localized description should match provided message")
    }

    func testInitializationWithCustomDomain() {
        let message = "Test Error Message"
        let domain = "com.example.customDomain"
        let error = NSError(message: message, domain: domain)

        XCTAssertEqual(error.domain, domain, "Error domain should match provided domain")
        XCTAssertEqual(error.localizedDescription, message, "Localized description should match provided message")
    }
}

#endif

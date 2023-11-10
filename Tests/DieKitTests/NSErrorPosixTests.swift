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

final class NSErrorPosixTests: XCTestCase {
    func testInitializationWithPosixError() {
        let posixErrorCode: Int32 = EFAULT
        let error = NSError(posixError: posixErrorCode)

        XCTAssertEqual(error.domain, NSPOSIXErrorDomain, "Error domain should be NSPOSIXErrorDomain")
        XCTAssertEqual(error.code, Int(posixErrorCode), "Error code should match the POSIX error code")
        XCTAssertEqual(error.localizedDescription, String(cString: strerror(posixErrorCode)), "Localized description should match the POSIX error message")
    }

    func testPosixLatest() {
        errno = EACCES
        let error = NSError.posixLatest

        XCTAssertEqual(error.domain, NSPOSIXErrorDomain, "Error domain should be NSPOSIXErrorDomain")
        XCTAssertEqual(error.code, Int(EACCES), "Error code should match the latest POSIX error code")
        XCTAssertEqual(error.localizedDescription, String(cString: strerror(EACCES)), "Localized description should match the POSIX error message for EACCES")
    }
}

#endif

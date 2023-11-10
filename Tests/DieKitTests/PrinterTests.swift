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

#if canImport(Rainbow)
import Rainbow
#endif

#if canImport(OSLog)
import OSLog
#endif

#if canImport(CoreFoundation)
import CoreFoundation
#endif

#if canImport(IOKit)
import IOKit
#endif

#if canImport(CoreGraphics)
import CoreGraphics
#endif

final class PrinterTests: XCTestCase {

    func testPrintWritesToStderr() {
        let reader = StderrReader()
        print(error: "foo")

        XCTAssertEqual(reader.readStderr(), "foo\n")
    }

    func testLocalizedErrorPrinting() {
        let reader = StderrReader()

        let testError = CustomLocalizedError()
        print(testError)

        XCTAssertEqual(reader.readStderr(), "error: Test Reason\n Test Description\n Test Description\noptions:\n– Test Suggestion\n")
    }

    func testURLErrorPrinting() {
        let reader = StderrReader()

        let testError = URLError(.badURL)
        print(testError)

        XCTAssertEqual(reader.readStderr(), "error: URLError(_nsError: Error Domain=NSURLErrorDomain Code=-1000 \"(null)\")\n")
    }

    func testNSErrorPrinting() {
        let reader = StderrReader()

        let testError = NSError(domain: "TestDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test NSError"])
        print(testError)

        XCTAssertEqual(reader.readStderr(), "error: Test NSError\n")
    }

    func testDecodingErrorPrinting() {
        let reader = StderrReader()

        let testError = DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Test Decoding Error"))
        print(testError)

        XCTAssertEqual(reader.readStderr(), "error: dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: \"Test Decoding Error\", underlyingError: nil))\n")
    }

    func testCGErrorPrinting() {
        let reader = StderrReader()

        let testError = CGError.illegalArgument
        print(testError)

        XCTAssertEqual(reader.readStderr(), "error: The operation couldn’t be completed. (CGError: Illegal Argument)\n")
    }
}

struct CustomLocalizedError: LocalizedError {
    var errorDescription: String? { return "Test Description" }
    var failureReason: String? { return "Test Reason" }
    var recoverySuggestion: String? { return "Test Suggestion" }
}

class StderrReader {
    private var stderrSave: Int32!
    private var pipeId: [Int32]!

    init() {
        stderrSave = dup(STDERR_FILENO)

        pipeId = [Int32](repeating: 0, count: 2)
        pipeId.withUnsafeMutableBufferPointer {
           guard pipe($0.baseAddress) == 0 else {
               XCTFail("Pipe creation failed")
               return
           }
       }

        dup2(pipeId[1], STDERR_FILENO)
        close(pipeId[1])
    }

    deinit {
        dup2(stderrSave, STDERR_FILENO)
        close(stderrSave)
        close(pipeId[0])
    }

    func readStderr() -> String? {
        let bufferSize = 256
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer {
            buffer.deallocate()
        }

        let bytesRead = read(pipeId[0], buffer, bufferSize)
        if bytesRead > 0 {
            let data = Data(bytes: buffer, count: bytesRead)
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }

}

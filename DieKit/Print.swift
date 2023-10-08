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

#if os(macOS)
import Rainbow
#endif

#if canImport(OSLog)
import OSLog
#endif

#if canImport(Foundation)
import Foundation

private var stderr = FileHandle.standardError

extension FileHandle: TextOutputStream {
    public func write(_ string: String) {
        guard let data = string.data(using: .utf8) else { return }
        self.write(data)
    }
}
#endif

public func print(error: String) {
#if os(macOS)
    let message = error.red
#else
    let message = error
#endif

#if canImport(Foundation)
    // todo: oslog?
    print(message, to: &stderr)
#else
    print(message)
#endif
}

public func print(_ error: LocalizedError) {
    let message = [error.failureReason, error.localizedDescription, error.errorDescription]
        .compactMap { $0 }
        .joined(separator: "\n ")
    print(error: "error: \(message)")

    if let suggestion = error.recoverySuggestion {
        print(error: "options:\n– \(suggestion)")
    }
}

public func print(_ error: DecodingError) {
    print(error: "error: \(error)")
}

public func print(_ error: EncodingError) {
    print(error: "error: \(error)")
}

public func print(_ error: Error) {
    print(error: "error: \(error)")
}

#if canImport(Foundation)
public func print(_ error: NSError) {
    let message = [error.localizedFailureReason, error.localizedDescription, error.localizedRecoverySuggestion]
        .compactMap { $0 }
        .joined(separator: "\n ")
    print(error: "error: \(message)")

    if let options = error.localizedRecoveryOptions?.map { "– \($0)" }.joined(separator: "\n") {
        print(error: "options: \n\(options)")
    }
}

public func print(_ error: CocoaError) {
    print(error: "error: \(error)")
}

public func print(_ error: MachError) {
    print(error: "error: \(error)")
}

public func print(_ error: POSIXError) {
    print(error: "error: \(error)")
}

public func print(_ error: URLError) {
    print(error: "error: \(error)")
}
#endif

#if canImport(CoreFoundation)
import CoreFoundation
public func print(_ error: CFError) {
    print(error: "error: \(error)")
}

public func print(_ error: CFSocketError) {
    print(error: "error: \(error)")
}
#endif

#if canImport(IOKit)
import IOKit
public func print(_ error: IOURLError) {
    print(error: "error: \(error)")
}
#endif

#if canImport(CoreGraphics)
import CoreGraphics
public func print(_ error: CGError) {
    print(error: "error: \(error)")
}
#endif

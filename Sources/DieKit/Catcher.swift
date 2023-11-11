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

#if canImport(Foundation)
import Foundation
#endif

#if canImport(CoreGraphics)
import CoreGraphics
extension CGError: Error {}
#endif

#if canImport(IOKit)
import IOKit
extension IOURLError: Error {}
#endif

#if canImport(CoreFoundation)
import CoreFoundation
extension CFSocketError: Error {}
#endif

public func printOnException<T>(_ body: () throws -> T) throws -> T {
    do {
        return try body()
    } catch let error as DecodingError {
        print(error); throw error
    } catch let error as EncodingError {
        print(error); throw error
    } catch {
        #if canImport(Foundation)
        switch error {
        case let error as LocalizedError:
            print(error); throw error
        case let error as CocoaError:
            print(error); throw error
        #if os(macOS)
        case let error as MachError:
            print(error); throw error
        #endif
        case let error as POSIXError:
            print(error); throw error
        case let error as URLError:
            print(error); throw error
        default: break
        }
        #endif

        #if canImport(CoreFoundation)
        switch error {
        case let error as CFSocketError:
            print(error); throw error
        default: break
        }
        #endif

        #if canImport(CoreGraphics)
        switch error {
        case let error as CGError:
            print(error); throw error
        default: break
        }
        #endif

        #if canImport(IOKit)
        switch error {
        case let error as IOURLError:
            print(error); throw error
        default: break
        }
        #endif

        #if canImport(Foundation)
        switch error {
        case let error as NSError:
            print(error as NSError); throw error
        default:
            print(error); throw error
        }
        #endif
    }
}

public func dieOnException<T>(_ body: () throws -> T) -> T {
    (try? printOnException(body)) ?? die()
}

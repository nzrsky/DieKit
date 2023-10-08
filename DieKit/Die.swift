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

#if canImport(CallStackParser)
import CallStackParser
#endif

public func die<T>(_ msg: String? = nil, lineNumber: Int = #line) -> T {
    print(error: msg?.appending("\n") ?? "")

#if canImport(CallStackParser)
//    print(error: Thread.callStackSymbols.dropFirst().enumerated()
//        .map { line in
//            CallStackParser.parse(stackSymbol: line.element).map { "\(line.offset)   \($0.classname).\($0.method)" + (line.offset == 0 ? " #\(lineNumber)" : "") } ?? line.element
//        }
//        .joined(separator: "\n"))
#endif

#if canImport(Foundation)
    exit(EXIT_FAILURE)
#else
    fatalError()
#endif
}

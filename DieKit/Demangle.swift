//
//  Copyright © Dangling Pointers. All rights reserved.
//

import Foundation


//private func demangle(_ string: String, lineNumber: Int? = nil) -> String {
////    try! parseMangledSwiftSymbol(string).description
//    CallStackParser.getCallingClassAndMethodInScope().
//
//    string
////    func matchRegex(_ matcher: String,  string : String) -> String? {
////        let regex = try! NSRegularExpression(pattern: matcher, options: [])
////        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
////        guard let textCheckingResult = regex.firstMatch(in: string, options: [], range: range) else {
////            return nil
////        }
////        return (string as NSString).substring(with:textCheckingResult.range(at:1)) as String
////    }
////
////    func singleMatchRegex(_ matcher: String,  string : String) -> String? {
////        let regex = try! NSRegularExpression(pattern: matcher, options: [])
////        let range = NSRange(string.startIndex ..< string.endIndex, in: string)
////        let matchRange = regex.rangeOfFirstMatch(in: string, range: range)
////        if matchRange == NSMakeRange(NSNotFound, 0) {
////            return nil
////        }
////        return (string as NSString).substring(with: matchRange) as String
////    }
////
////    var string = string
////    string = String(string.suffix(from:string.firstIndex(of: "$")!))
////
////    let appNameLenString = matchRegex(#"\$s(\d*)"#, string: string)!
////    let appNameLen = Int(appNameLenString)!
////
////    string = String(string.dropFirst(appNameLenString.count + 2))
////
////    let appName = singleMatchRegex(".{\(appNameLen)}", string: string)!
////
////    string = String(string.dropFirst(appNameLen))
////
////    let classNameLenString = singleMatchRegex(#"\d*"#, string: string)!
////    let classNameLen = Int(classNameLenString)!
////
////    string = String(string.dropFirst(classNameLenString.count))
////
////    let className = singleMatchRegex(".{\(classNameLen)}", string: string)!
////
////    string = String(string.dropFirst(classNameLen))
////
////    let methodNameLenString = matchRegex(#".(\d*)"#, string: string)!
////    let methodNameLen = Int(methodNameLenString)!
////
////    string = String(string.dropFirst(methodNameLenString.count + 1))
////
////    let methodName = singleMatchRegex(".{\(methodNameLen)}", string: string)!
////
////    let _ = appName
////    return "\(className).\(methodName)()" + (lineNumber.map { "\($0)" } ?? "")
//}

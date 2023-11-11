# 💀 Error Printer for Swift

[![CI](https://github.com/nzrsky/DieKit/actions/workflows/build-test.yml/badge.svg)](https://github.com/nzrsky/DieKit/actions/workflows/build-test.yml?query=branch%3Amain+)
[![codecov](https://codecov.io/gh/nzrsky/DieKit/branch/master/graph/badge.svg)](https://codecov.io/gh/nzrsky/DieKit)

[![Supports macOS, Ubuntu & Windows](https://img.shields.io/badge/platform-macOS%20%7C%20Ubuntu%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20visionOS-lightgray)]()
[![Swift 5.9](https://img.shields.io/badge/Swift-5.9-F05138?logo=swift&logoColor=white)]()
[![Latest release](https://img.shields.io/github/v/release/nzrsky/DieKit?sort=semver)]()

DieKit, a Swift package designed to streamline and enhance error handling in your Swift applications. It makes exception handling more robust and insightful.

## Key Features
- Enhanced Error Reporting: It catches, prints, and rethrows errors for comprehensive debugging.
- Wide Error Support: DieKit extends support to various Swift and Core Foundation error types, providing a versatile tool for a broad range of applications.
- Works everythere, including Vapor 💧

## Installation
Add DieKit to your Swift project by including it in your Package.swift dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/nzrsky/DieKit.git", from: "0.1.7")
]
```

## Usage

Print ANSI color (if supported) errors to stderr:
```swift
print(error: "message")
// or
print(error: CustomError())
```

Fatal error with proper message as a fallback:
```swift
import DieKit

// Not really informative sometimes
let x = env["SECRET_KEY"]!
// main.swift:28: Fatal error: Unexpectedly found nil while unwrapping an Optional value

// ❌ This code doesn't compile
let x = env["SECRET_KEY"] ?? fatalError()

// 🙈 Compiles but looks ugly
let x = env["SECRET_KEY"] ?? { fatalError("<Your message>") }()

// ✅ Almost perfect. You also can print stacktrace using `, trace: true`
let x = env["SECRET_KEY"] ?? die("Specify SECRET_KEY")
// Specify SECRET_KEY in env
// main.swift:28: Fatal error
```

Print error to stderr and proceed handling:
```swift
// Usage of printOnException
do {
    let result = try printOnException { try throwingOperation() }
    // prints error message to stderr according error's type
} catch error {
    // handle error
}

// Usage of dieOnException
let result = dieOnException { try throwingOperation() }
// prints error message to stderr and die
```

Posix errors:
```swift
throw NSError(posixError: EFAULT)

// or
some_system_code_which_writes_errno() 
let error = NSError.posixLatest /* error from errno with proper description */
```

Print formatted errors:
```swift
// Default behaviour
print(CGError.illegalArgument)
// The operation couldn’t be completed. (__C.CGError 1003)

// With DieKit
print(CGError.illegalArgument)
// error: The operation couldn’t be completed. (CGError: Illegal Argument)
```

## Contact

Follow and contact me on [Twitter](http://twitter.com/nzrsky). If you find an issue, 
just [open a ticket](https://github.com/nzrsky/DieKit/issues/new) on it. Pull 
requests are warmly welcome as well.

## Backers & Sponsors

Open-source projects cannot live long without your help. If you find Kingfisher is useful, please consider supporting this
project by becoming a sponsor. Your user icon or company logo shows up on my blog with a link to your home page.

Become a sponsor through [GitHub Sponsors](https://github.com/sponsors/nzrsky). :heart:

## Contributing
Contributions make the open-source community an amazing place to learn, inspire, and create. Any contributions you make to DieKit are greatly appreciated.

## License
Distributed under the MIT License. See LICENSE for more information.

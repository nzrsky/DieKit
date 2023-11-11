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

## Installation
Add DieKit to your Swift project by including it in your Package.swift dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/nzrsky/DieKit.git", from: "0.1.2")
]
```

## Usage
Here's how simple it is to use DieKit:

```swift
import DieKit

// ❌ This code doesn't compile
let x = env["SECRET_KEY"] ?? fatalError()

// ❌ Also compilation error here
let x = env["SECRET_KEY"] ?? { fatalError() }

// ✅ But this is OK
let x = env["SECRET_KEY"] ?? die("Specify SECRET_KEY")
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

## Contributing
Contributions make the open-source community an amazing place to learn, inspire, and create. Any contributions you make to DieKit are greatly appreciated.

## License
Distributed under the MIT License. See LICENSE for more information.

![DieKit](https://github.com/nzrsky/DieKit/blob/0.1.0/Resources/logo.png)

# Error Printer for Swift

[![Danger Swift](https://github.com/nzrsky/DieKit/actions/workflows/danger.yml/badge.svg)](https://github.com/nzrsky/DieKit/actions/workflows/danger.yml)
[![Codecov](https://codecov.io/gh/nzrsky/DieKit/branch/main/graph/badge.svg)](https://codecov.io/gh/nzrsky/DieKit)

<div align="center">
<!-- 	<a href="https://github.com/nzrsky/DieKit/actions">
		<img src="https://github.com/nzrsky/DieKit
    /workflows/Build,%20Lint%20&%20Test/badge.svg" alt="GitHub Actions">
	</a>
	<a href="https://nzrsky.github.io/DieKit
/">
		<img src="https://raw.githubusercontent.com/nzrsky/DieKit
    /gh-pages/badge.svg"/>
	</a> -->
</div>

DieKit, a Swift package designed to streamline and enhance error handling in your Swift applications. It makes exception handling more robust and insightful.

## Key Features
- Enhanced Error Reporting: It catches, prints, and rethrows errors for comprehensive debugging.
- Wide Error Support: DieKit extends support to various Swift and Core Foundation error types, providing a versatile tool for a broad range of applications.

## Installation
Add DieKit to your Swift project by including it in your Package.swift dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/nzrsky/DieKit.git", from: "0.1.1")
]
```

## Usage
Here's how simple it is to use DieKit:

Colorfull print to stderr:
```swift
print(error: "message")
```

Optional fatal error 
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

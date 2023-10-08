//
//  Copyright © Dangling Pointers. All rights reserved.
//

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
        case let error as MachError:
            print(error); throw error
        case let error as POSIXError:
            print(error); throw error
        case let error as URLError:
            print(error); throw error
        case let error as NSError:
            print(error); throw error
        default: break
        }
        #endif

        #if canImport(CoreFoundation)
        switch error {
        case let error as CFError:
            print(error); throw error
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

        print(error)
        throw error
    }
}

public func dieOnException<T>(_ body: () throws -> T) -> T {
    (try? printOnException(body)) ?? die()
}

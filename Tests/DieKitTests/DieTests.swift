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
import Foundation

final class DieTests: XCTestCase {

    func testDie() throws {
        _ = URL(string: "foo") ?? die("Boom")
        XCTAssertTrue(true)
    }
}

/**
    NSObject().perform(NSSelectorFromString("badf00d"))
    ----------------------------------------------
    2023-11-10 20:54:55.252381+0200 xctest[47034:24889467] -[NSObject badf00d]: unrecognized selector sent to instance 0x6000000083b0
    <unknown>:0: error: DieTests : -[NSObject badf00d]: unrecognized selector sent to instance 0x6000000083b0
    (
        0   CoreFoundation                      0x0000000196a7f154 __exceptionPreprocess + 176
        1   libobjc.A.dylib                     0x000000019659e4d4 objc_exception_throw + 60
        2   CoreFoundation                      0x0000000196b26110 -[NSObject(NSObject) __retain_OA] + 0
        3   CoreFoundation                      0x00000001969e70a0 ___forwarding___ + 1600
        4   CoreFoundation                      0x00000001969e69a0 _CF_forwarding_prep_0 + 96
        5   DieKitTests                         0x0000000101330758 $s11DieKitTests0aC0C5setUpyyFZ + 164
        6   DieKitTests                         0x0000000101330828 $s11DieKitTests0aC0C5setUpyyFZTo + 40
        7   XCTestCore                          0x0000000100b991e4 -[XCTContext _runActivityNamed:type:block:] + 264
        8   XCTestCore                          0x0000000100b97ca8 -[XCTContext runInternalActivityNamed:block:] + 152
        9   XCTestCore                          0x0000000100b97b58 +[XCTContext runInternalActivityNamed:block:] + 100
        10  XCTestCore                          0x0000000100b9a244 -[XCTestCaseSuite setUp] + 176
        11  XCTestCore                          0x0000000100b9c938 __27-[XCTestSuite performTest:]_block_invoke + 56
        12  XCTestCore                          0x0000000100b9c408 __59-[XCTestSuite _performProtectedSectionForTest:testSection:]_block_invoke + 48
        13  XCTestCore                          0x0000000100b99844 +[XCTContext _runInChildOfContext:forTestCase:markAsReportingBase:block:] + 180
        14  XCTestCore                          0x0000000100b9972c +[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 104
        15  XCTestCore                          0x0000000100b9c378 -[XCTestSuite _performProtectedSectionForTest:testSection:] + 180
        16  XCTestCore                          0x0000000100b9c658 -[XCTestSuite performTest:] + 220
        17  XCTestCore                          0x0000000100b600f0 -[XCTest runTest] + 48
        18  XCTestCore                          0x0000000100b9cadc -[XCTestSuite runTestBasedOnRepetitionPolicy:testRun:] + 68
        19  XCTestCore                          0x0000000100b9c9a4 __27-[XCTestSuite performTest:]_block_invoke + 164
        20  XCTestCore                          0x0000000100b9c408 __59-[XCTestSuite _performProtectedSectionForTest:testSection:]_block_invoke + 48
        21  XCTestCore                          0x0000000100b99844 +[XCTContext _runInChildOfContext:forTestCase:markAsReportingBase:block:] + 180
        22  XCTestCore                          0x0000000100b9972c +[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 104
        23  XCTestCore                          0x0000000100b9c378 -[XCTestSuite _performProtectedSectionForTest:testSection:] + 180
        24  XCTestCore                          0x0000000100b9c658 -[XCTestSuite performTest:] + 220
        25  XCTestCore                          0x0000000100b600f0 -[XCTest runTest] + 48
        26  XCTestCore                          0x0000000100b9cadc -[XCTestSuite runTestBasedOnRepetitionPolicy:testRun:] + 68
        27  XCTestCore                          0x0000000100b9c9a4 __27-[XCTestSuite performTest:]_block_invoke + 164
        28  XCTestCore                          0x0000000100b9c408 __59-[XCTestSuite _performProtectedSectionForTest:testSection:]_block_invoke + 48
        29  XCTestCore                          0x0000000100b99844 +[XCTContext _runInChildOfContext:forTestCase:markAsReportingBase:block:] + 180
        30  XCTestCore                          0x0000000100b9972c +[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 104
        31  XCTestCore                          0x0000000100b9c378 -[XCTestSuite _performProtectedSectionForTest:testSection:] + 180
        32  XCTestCore                          0x0000000100b9c658 -[XCTestSuite performTest:] + 220
        33  XCTestCore                          0x0000000100b600f0 -[XCTest runTest] + 48
        34  XCTestCore                          0x0000000100b62538 __89-[XCTTestRunSession executeTestsWithIdentifiers:skippingTestsWithIdentifiers:completion:]_block_invoke + 104
        35  XCTestCore                          0x0000000100b99844 +[XCTContext _runInChildOfContext:forTestCase:markAsReportingBase:block:] + 180
        36  XCTestCore                          0x0000000100b9972c +[XCTContext runInContextForTestCase:markAsReportingBase:block:] + 104
        37  XCTestCore                          0x0000000100b623f8 -[XCTTestRunSession executeTestsWithIdentifiers:skippingTestsWithIdentifiers:completion:] + 296
        38  XCTestCore                          0x0000000100bda12c __72-[XCTExecutionWorker enqueueTestIdentifiersToRun:testIdentifiersToSkip:]_block_invoke_2 + 136
        39  XCTestCore                          0x0000000100bda2c0 -[XCTExecutionWorker runWithError:] + 132
        40  XCTestCore                          0x0000000100b96000 __25-[XCTestDriver _runTests]_block_invoke.264 + 56
        41  XCTestCore                          0x0000000100b6d39c -[XCTestObservationCenter _observeTestExecutionForTestBundle:inBlock:] + 212
        42  XCTestCore                          0x0000000100b95a54 -[XCTestDriver _runTests] + 1100
        43  XCTestCore                          0x0000000100b607d4 _XCTestMain + 92
        44  xctest                              0x000000010000577c main + 156
        45  dyld                                0x00000001965cff28 start + 2236
    )
*/

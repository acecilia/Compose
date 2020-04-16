#if !canImport(ObjectiveC)
import XCTest

extension ComposeMultipleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ComposeMultipleTests = [
        ("testCodable", testCodable),
        ("testGetSet", testGetSet),
    ]
}

extension ComposeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ComposeTests = [
        ("testCodable", testCodable),
        ("testEquatable", testEquatable),
        ("testGetSet", testGetSet),
        ("testHashable", testHashable),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ComposeMultipleTests.__allTests__ComposeMultipleTests),
        testCase(ComposeTests.__allTests__ComposeTests),
    ]
}
#endif

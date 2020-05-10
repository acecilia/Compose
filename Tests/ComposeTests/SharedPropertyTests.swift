import XCTest
import Foundation
import Compose

final class SharedPropertyTests: XCTestCase {
    func testGet() {
        XCTAssertEqual(differentTypeSharedProperty.sharedProperty, 26)
        XCTAssertEqual(differentTypeSharedProperty.sharedProperty, "Gonzalo")
    }

    func testSet() {
        let expectedInt = 25
        let expectedString = "Denmark"

        var mutable = differentTypeSharedProperty
        mutable.sharedProperty = expectedInt
        mutable.sharedProperty = expectedString

        XCTAssertEqual(mutable.sharedProperty, expectedInt)
        XCTAssertEqual(mutable.sharedProperty, expectedString)
    }

    func testCodableSameType() throws {
        guard #available(OSX 10.13, *) else {
            XCTFail()
            return
        }

        let json = """
        {
          "sharedProperty" : "Gonzalo"
        }
        """

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(SameTypeSharedProperty.self, from: Data(json.utf8))
        XCTAssertEqual(decoded, SameTypeSharedProperty(.init(sharedProperty: "Gonzalo"), .init(sharedProperty: "Gonzalo")))
    }

    func testEncodeSameType() throws {
        guard #available(OSX 10.13, *) else {
            XCTFail()
            return
        }
        let struct1 = StructWithSharedPropertyB(sharedProperty: "Andres")
        let struct2 = StructWithSharedPropertyC(sharedProperty: "Kike")

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            typealias SharedProperty = Compose<StructWithSharedPropertyB, StructWithSharedPropertyC>
            let input = SharedProperty(struct1, struct2)
            let json = """
            {
              "sharedProperty" : "\(struct1.sharedProperty)"
            }
            """

            let data = try encoder.encode(input)
            XCTAssertEqual(json, String(data: data, encoding: .utf8))
        }

        do {
            typealias SharedProperty = Compose<StructWithSharedPropertyC, StructWithSharedPropertyB>
            let input = SharedProperty(struct2, struct1)
            let json = """
            {
              "sharedProperty" : "\(struct2.sharedProperty)"
            }
            """

            let data = try encoder.encode(input)
            XCTAssertEqual(json, String(data: data, encoding: .utf8))
        }
    }

    func testDecodeDifferentType() throws {
        let json = """
        {
          "sharedProperty" : "Gonzalo",
          "sharedProperty" : "26"
        }
        """

        let decoder = JSONDecoder()
        let expression = { try decoder.decode(DifferentTypeSharedProperty.self, from: Data(json.utf8)) }
        XCTAssertThrowsError(try expression())
    }

    func testEncodeDifferentType() throws {
        guard #available(OSX 10.13, *) else {
            XCTFail()
            return
        }
        let struct1 = StructWithSharedPropertyA(sharedProperty: 26)
        let struct2 = StructWithSharedPropertyB(sharedProperty: "Kike")

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        do {
            typealias SharedProperty = Compose<StructWithSharedPropertyA, StructWithSharedPropertyB>
            let input = SharedProperty(struct1, struct2)
            let json = """
            {
              "sharedProperty" : \(struct1.sharedProperty)
            }
            """

            let data = try encoder.encode(input)
            XCTAssertEqual(json, String(data: data, encoding: .utf8))
        }

        do {
            typealias SharedProperty = Compose<StructWithSharedPropertyB, StructWithSharedPropertyA>
            let input = SharedProperty(struct2, struct1)
            let json = """
            {
              "sharedProperty" : "\(struct2.sharedProperty)"
            }
            """

            let data = try encoder.encode(input)
            XCTAssertEqual(json, String(data: data, encoding: .utf8))
        }
    }
}

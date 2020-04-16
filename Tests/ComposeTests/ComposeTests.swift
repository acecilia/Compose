import XCTest
import Foundation
import Compose

final class ComposeTests: XCTestCase {
    func testGetSet() {
        let expectedName = "Kike"
        let expectedCity = "Segovia"

        var mutable = remoteDeveloper
        mutable.name = expectedName
        mutable.city = expectedCity

        XCTAssertEqual(mutable.name, expectedName)
        XCTAssertEqual(mutable.city, expectedCity)
    }

    func testHashable() {
        let dict = [remoteDeveloper: "Handsome dude"]
        XCTAssertEqual(remoteDeveloper, dict.keys.first)
    }

    func testEquatable() {
        let remoteDeveloperCopy = remoteDeveloper
        XCTAssertEqual(remoteDeveloper, remoteDeveloperCopy)
    }

    func testLocalizedError() {
        let expected = """
        noInternet
        elementNotFound
        """

        XCTAssertEqual(appError.localizedDescription, expected)
        XCTAssertEqual(appError.failureReason, expected)
        XCTAssertEqual(appError.recoverySuggestion, expected)
        XCTAssertEqual(appError.helpAnchor, expected)
    }

    func testCodable() throws {
        guard #available(OSX 10.13, *) else {
            XCTFail()
            return
        }

        let remoteDeveloperJson = """
        {
          "age" : 26,
          "city" : "Madrid",
          "country" : "Spain",
          "name" : "Andres"
        }
        """

        let decoder = JSONDecoder()
        let remoteDeveloper = try decoder.decode(RemoteDeveloper.self, from: Data(remoteDeveloperJson.utf8))

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(remoteDeveloper)

        XCTAssertEqual(remoteDeveloperJson, String(data: data, encoding: .utf8))
    }
}

import XCTest
import Foundation
import Compose

final class ComposeMultipleTests: XCTestCase {
    func testGetSet() {
        let expectedName = "Kike"
        let expectedCity = "Segovia"
        let expectedTeam = "Android"

        var mutable = remoteTeamLead
        mutable.name = expectedName
        mutable.city = expectedCity
        mutable.team = expectedTeam

        XCTAssertEqual(mutable.name, expectedName)
        XCTAssertEqual(mutable.city, expectedCity)
        XCTAssertEqual(mutable.team, expectedTeam)
    }

    func testCodable() throws {
        guard #available(OSX 10.13, *) else {
            XCTFail()
            return
        }

        let remoteTeamLeadJson = """
        {
          "age" : 26,
          "city" : "Madrid",
          "country" : "Spain",
          "name" : "Andres",
          "salary" : 1000000,
          "team" : "iOS"
        }
        """

        let decoder = JSONDecoder()
        let remoteDeveloper = try decoder.decode(RemoteTeamLead.self, from: Data(remoteTeamLeadJson.utf8))

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(remoteDeveloper)

        XCTAssertEqual(remoteTeamLeadJson, String(data: data, encoding: .utf8))
    }
}

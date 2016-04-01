import VerVerVer
import XCTest

class SemanticVersionTests: XCTestCase {
  func testSimpleEquality() {
    let first = SemanticVersion(1, 0, 0)
    let second = SemanticVersion(1, 0, 0)
    let third = SemanticVersion(1, 0, 1)


    XCTAssertTrue(first == second)
    XCTAssertFalse(first == third)
  }

  func testPrereleaseEquality() {
    let first = SemanticVersion(1, 0, 0)
    let second = SemanticVersion(1, 0, 0, release: .RC(2))
    let third = SemanticVersion(1, 0, 0, release: .RC(1))
    let fourth = SemanticVersion(1, 0, 0, release: .Beta(2))
    let fifth = SemanticVersion(1, 0, 0, release: .Beta(1))
    let sixth = SemanticVersion(1, 0, 0, release: .Alpha(2))
    let seventh = SemanticVersion(1, 0, 0, release: .Alpha(1))

    XCTAssertTrue(second < first)
    XCTAssertTrue(third < second)
    XCTAssertTrue(fourth < third)
    XCTAssertTrue(fifth < fourth)
    XCTAssertTrue(sixth < fifth)
    XCTAssertTrue(seventh < sixth)
  }

  func testStringOutput() {
    XCTAssertTrue(SemanticVersion(1, 0, 0).stringValue == "1.0.0")
    XCTAssertTrue(SemanticVersion(7, 33, 1).stringValue == "7.33.1")
    XCTAssertTrue(SemanticVersion(2, 12, 0, release: .Alpha(1)).stringValue == "2.12.0-alpha.1")
    XCTAssertTrue(SemanticVersion(1, 1, 0, release: .RC(4)).stringValue == "1.1.0-rc.4")
    XCTAssertTrue(SemanticVersion(1, 0, 0, release: .Alpha(1), build: "9a8dfsd7df").stringValue == "1.0.0-alpha.1+9a8dfsd7df")
  }
}

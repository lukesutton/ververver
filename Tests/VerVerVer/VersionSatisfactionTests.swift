import VerVerVer
import XCTest

class VersionSatisfactionTests: XCTestCase {
  func testExact() {
    let requirement = VersionRequirement<SemanticVersion>.exactly(SemanticVersion(1, 0, 0))
    let matching = SemanticVersion(1, 0, 0)
    let failing = SemanticVersion(1, 1, 0)

    XCTAssertTrue(requirement.versionSatisfies(matching))
    XCTAssertFalse(requirement.versionSatisfies(failing))
  }

  func testLessThan() {
    let requirement = VersionRequirement<SemanticVersion>.lessThan(SemanticVersion(1, 0, 0))
    let matching = SemanticVersion(0, 19, 0)
    let failing = SemanticVersion(1, 1, 0)

    XCTAssertTrue(requirement.versionSatisfies(matching))
    XCTAssertFalse(requirement.versionSatisfies(failing))
  }

  func testLessThanOrEqual() {
    let requirement = VersionRequirement<SemanticVersion>.lessThanOrEqual(SemanticVersion(2, 1, 0))
    let matchingExact = SemanticVersion(2, 1, 0)
    let matchingLess = SemanticVersion(2, 0, 0)
    let failing = SemanticVersion(2, 2, 0)

    XCTAssertTrue(requirement.versionSatisfies(matchingExact))
    XCTAssertTrue(requirement.versionSatisfies(matchingLess))
    XCTAssertFalse(requirement.versionSatisfies(failing))
  }

  func testGreaterThan() {
    let requirement = VersionRequirement<SemanticVersion>.greaterThan(SemanticVersion(1, 0, 0))
    let matching = SemanticVersion(2, 0, 0)
    let failing = SemanticVersion(0, 9, 12)

    XCTAssertTrue(requirement.versionSatisfies(matching))
    XCTAssertFalse(requirement.versionSatisfies(failing))
  }

  func testGreaterOrEqual() {
    let requirement = VersionRequirement<SemanticVersion>.greaterThanOrEqual(SemanticVersion(9, 8, 1))
    let matchingExact = SemanticVersion(9, 8, 1)
    let matchingGreater = SemanticVersion(10, 0, 0)
    let failing = SemanticVersion(7, 2, 0)

    XCTAssertTrue(requirement.versionSatisfies(matchingExact))
    XCTAssertTrue(requirement.versionSatisfies(matchingGreater))
    XCTAssertFalse(requirement.versionSatisfies(failing))
  }

  func testBetween() {
    let requirement = VersionRequirement<SemanticVersion>.between(SemanticVersion(1, 0, 0), SemanticVersion(2, 0, 0))
    let matchStart = SemanticVersion(1, 0, 0)
    let matchEnd = SemanticVersion(2, 0, 0)
    let matchWithin = SemanticVersion(1, 2, 0)
    let failingBefore = SemanticVersion(0, 9, 0)
    let failingAfter = SemanticVersion(2, 0, 1)

    XCTAssertTrue(requirement.versionSatisfies(matchStart))
    XCTAssertTrue(requirement.versionSatisfies(matchEnd))
    XCTAssertTrue(requirement.versionSatisfies(matchWithin))
    XCTAssertFalse(requirement.versionSatisfies(failingBefore))
    XCTAssertFalse(requirement.versionSatisfies(failingAfter))
  }
}

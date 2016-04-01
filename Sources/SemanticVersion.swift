public struct SemanticVersion: VersionType {
  public let major: Int
  public let minor: Int
  public let patch: Int

  public init(_ major: Int, _ minor: Int = 0, _ patch: Int = 0) {
    self.major = major
    self.minor = minor
    self.patch = patch
  }

  public var hashValue: Int {
    return "\(major)\(minor)\(patch)".hashValue
  }

  public var stringValue: String {
    return "\(major).\(minor).\(patch)"
  }

  var tupleValue: (Int, Int, Int) {
    return (major, minor, patch)
  }
}

public func ==(lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
  let equalMajor = lhs.major == rhs.major
  let equalMinor = lhs.minor == rhs.minor
  let equalPatch = lhs.patch == rhs.patch
  return equalMajor && equalMinor && equalPatch
}

public func <(lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
  return lhs.tupleValue < rhs.tupleValue
}

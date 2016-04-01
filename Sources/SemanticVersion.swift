public struct SemanticVersion: VersionType {
  public enum Release: Comparable, Equatable {
    case Final
    case RC(Int?)
    case Beta(Int?)
    case Alpha(Int?)


    var index: (Int, Int) {
      switch self {
        case .Final: return (4, 0)
        case let .RC(n): return (3, n ?? 0)
        case let .Beta(n): return (2, n ?? 0)
        case let .Alpha(n): return (1, n ?? 0)
      }
    }

    var stringValue: String? {
      switch self {
        case .Final: return nil
        case let .RC(n): return appendVersion(n, to: "-rc")
        case let .Beta(n): return  appendVersion(n, to: "-beta")
        case let .Alpha(n): return appendVersion(n, to: "-alpha")
      }
    }

    private func appendVersion(version: Int?, to head: String) -> String {
      if let version = version {
        return "\(head).\(version)"
      }
      else {
        return head
      }
    }
  }

  public let major: Int
  public let minor: Int
  public let patch: Int
  public let release: Release
  public let build: String?

  public init(_ major: Int, _ minor: Int = 0, _ patch: Int = 0, release: Release = .Final, build: String? = nil) {
    self.major = major
    self.minor = minor
    self.patch = patch
    self.release = release
    self.build = build
  }

  public var hashValue: Int {
    return "\(major)\(minor)\(patch)\(release)\(build)".hashValue
  }

  public var stringValue: String {
    // I hate having to use a var here, rather than immutable values, but
    // swift makes it hard sometimes.
    var output = "\(major).\(minor).\(patch)"
    if let prerelease = release.stringValue {
      output += prerelease
    }
    if let build = build {
      output += "+\(build)"
    }
    
    return output
  }

  var index: (Int, Int, Int, Int, Int) {
    let (x, y) = release.index
    return (major, minor, patch, x, y)
  }
}

public func ==(lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
  let equalMajor = lhs.major == rhs.major
  let equalMinor = lhs.minor == rhs.minor
  let equalPatch = lhs.patch == rhs.patch
  let equalRelease = lhs.release == rhs.release
  return equalMajor && equalMinor && equalPatch && equalRelease
}

public func <(lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
  return lhs.index < rhs.index
}

public func ==(lhs: SemanticVersion.Release, rhs: SemanticVersion.Release) -> Bool {
  switch (lhs, rhs) {
    case (.Final, .Final): return true
    case let (.Alpha(x), .Alpha(y)): return x == y
    case let (.Beta(x), .Beta(y)): return x == y
    case let (.RC(x), .RC(y)): return x == y
    default: return false
  }
}

public func <(lhs: SemanticVersion.Release, rhs: SemanticVersion.Release) -> Bool {
  return lhs.index < rhs.index
}

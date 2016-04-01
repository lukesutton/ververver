public struct VersionRequirement<V: VersionType> {
  let startVersion: V
  let endVersion: V?
  let mode: VersionRequirementMode

  private init(start: V, end: V? = nil, mode: VersionRequirementMode) {
    self.startVersion = start
    self.endVersion = end
    self.mode = mode
  }

  public static func lessThan(version: V) -> VersionRequirement {
    return VersionRequirement(start: version, mode: .LessThan)
  }

  public static func lessThanOrEqual(version: V) -> VersionRequirement {
    return VersionRequirement(start: version, mode: .LessThanOrEqual)
  }

  public static func greaterThan(version: V) -> VersionRequirement {
    return VersionRequirement(start: version, mode: .GreaterThan)
  }

  public static func greaterThanOrEqual(version: V) -> VersionRequirement {
    return VersionRequirement(start: version, mode: .GreaterThanOrEqual)
  }

  public static func exactly(version: V) -> VersionRequirement {
    return VersionRequirement(start: version, mode: .Exactly)
  }

  public static func between(start: V, _ end: V) -> VersionRequirement {
    return VersionRequirement(start: start, end: end, mode: .Between)
  }

  public func versionSatisfies(version: V) -> Bool {
    switch mode {
      case .LessThan:
        return version < startVersion
      case .LessThanOrEqual:
        return version <= startVersion
      case .GreaterThan:
        return version > startVersion
      case .GreaterThanOrEqual:
        return version >= startVersion
      case .Exactly:
        return version == startVersion
      case .Between:
        return (version >= startVersion && version < endVersion!) || (version > startVersion && version <= endVersion!)
    }
  }

  public func versionsCouldSatisfy(requirement: VersionRequirement<V>) -> Bool {
    if self == requirement {
      return true
    }
    else if requirement.mode == .Between {
      return versionSatisfies(requirement.startVersion) || versionSatisfies(requirement.endVersion!)
    }
    else {
      return versionSatisfies(requirement.startVersion)
    }
  }
}

extension VersionRequirement: Hashable {
  public var hashValue: Int {
    return startVersion.hashValue + (endVersion?.hashValue ?? 0) + mode.hashValue
  }
}

extension VersionRequirement: Equatable {}

public func ==<V>(lhs: VersionRequirement<V>, rhs: VersionRequirement<V>) -> Bool {
  if let leftEnd = lhs.endVersion, let rightEnd = rhs.endVersion {
    return leftEnd == rightEnd && lhs.startVersion == rhs.startVersion && lhs.mode == rhs.mode
  }
  else {
    return lhs.startVersion == rhs.startVersion && lhs.mode == rhs.mode
  }
}

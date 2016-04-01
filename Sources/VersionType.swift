public protocol VersionType: Comparable, Equatable, Hashable {
  var stringValue: String { get }
}

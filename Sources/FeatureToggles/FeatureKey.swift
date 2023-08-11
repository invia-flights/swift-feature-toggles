import Foundation

public protocol FeatureKey: Sendable {
  static var defaultValue: Bool { get }
  static var debugValue: Bool { get }
  static var id: String { get }
}

extension FeatureKey {
  public static var id: String { String(reflecting: self) }
  public static var debugValue: Bool { defaultValue }
}

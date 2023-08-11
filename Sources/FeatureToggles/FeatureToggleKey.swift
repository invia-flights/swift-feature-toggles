import Foundation

public protocol FeatureToggleKey: Sendable {
  static var releaseValue: Bool { get }
  static var debugValue: Bool { get }
  static var id: String { get }
}

extension FeatureToggleKey {
  public static var id: String { String(reflecting: self) }
}

public protocol ReleaseDisabled {}
extension ReleaseDisabled where Self: FeatureToggleKey {
  public static var releaseValue: Bool { false }
}

public protocol DebugDisabled where Self: FeatureToggleKey {}
extension DebugDisabled {
  public static var debugValue: Bool { false }
}

public protocol ReleaseEnabled {}
extension ReleaseEnabled where Self: FeatureToggleKey {
  public static var releaseValue: Bool { true }
}

public protocol DebugEnabled where Self: FeatureToggleKey {}
extension DebugEnabled {
  public static var debugValue: Bool { true }
}

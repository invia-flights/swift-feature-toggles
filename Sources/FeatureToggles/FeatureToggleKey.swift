import Foundation

/// A key for accessing toggles.
///
/// Types conform to this protocol to extend ``FeatureToggleValues`` with custom toggles.
public protocol FeatureToggleKey: Sendable {
  static var releaseValue: Bool { get }
  static var debugValue: Bool { get }
  static var featureToggleIdentifier: String { get }
}

extension FeatureToggleKey {
  public static var featureToggleIdentifier: String { String(reflecting: self) }
}

/// A feature toggle that is disabled in `RELEASE` builds.
///
/// Conform to this type to disable the feature in a `RELEASE`build.
public protocol ReleaseDisabled {}
extension ReleaseDisabled where Self: FeatureToggleKey {
  public static var releaseValue: Bool { false }
}

/// A feature toggle that is disabled in `DEBUG` builds.
///
/// Conform to this type to disable the feature in a `DEBUG`build.
public protocol DebugDisabled where Self: FeatureToggleKey {}
extension DebugDisabled {
  public static var debugValue: Bool { false }
}

/// A feature toggle that is enabled in `RELEASE` builds.
///
/// Conform to this type to enable the feature in a `RELEASE`build.
public protocol ReleaseEnabled {}
extension ReleaseEnabled where Self: FeatureToggleKey {
  public static var releaseValue: Bool { true }
}

/// A feature toggle that is enabled in `DEBUG` builds.
///
/// Conform to this type to enable the feature in a `DEBUG`build.
public protocol DebugEnabled where Self: FeatureToggleKey {}
extension DebugEnabled {
  public static var debugValue: Bool { true }
}

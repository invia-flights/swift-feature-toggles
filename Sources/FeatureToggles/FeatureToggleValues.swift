import Foundation

/// Provides access to the current state of feature toggles.
public struct FeatureToggleValues: Sendable {

  /// A shared instance.
  public static var shared = FeatureToggleValues()

  internal let userDefaults: UserDefaults

  /// Creates an instance backed by the provided user defaults.
  /// - Parameter userDefaults: An instance of `UserDefaults`.
  public init(
    userDefaults: UserDefaults = .standard
  ) {
    self.userDefaults = userDefaults
  }

  /// Overrides the compile-time settings via a specially-formatted URL.
  ///
  /// The URL must have `toggle` as a hostname and two query items:
  /// - `feature`: The feature’s identifier, declared by a `FeatureToggleKey` as
  ///   its `featureToggleIdentifier` static property.
  /// - `enabled`: `true` or `false.`
  ///
  /// For example, this URL would be valid: `yourscheme://toggle?id=teleport&value=true`.
  ///
  /// The overrides are persisted in the standard `UserDefaults`.
  ///
  /// - Parameter url: A specially-formatted URL (see above.)
  /// - Returns: `true` if the override was successful, otherwise `false`.
  public static func override(withValuesFrom url: URL) -> Bool {
    shared.override(withValuesFrom: url)
  }

  internal subscript(key: (some FeatureToggleKey).Type) -> Bool {
    if let value = userDefaults.object(forKey: key.featureToggleIdentifier),
      let bool = value as? Bool
    {
      return bool
    }

    #if DEBUG
      return key.debugValue
    #else
      return key.releaseValue
    #endif
  }

  private func parse(url: URL) -> (String, Bool)? {
    guard let comps = URLComponents(url: url, resolvingAgainstBaseURL: false),
      comps.host == "toggle",
      let items = comps.queryItems,

      let featureItem = items.first(where: { $0.name == "feature" }),
      let feature = featureItem.value,

      let isEnabledItem = items.first(where: { $0.name == "enabled" }),
      let isEnabledString = isEnabledItem.value,
      let isEnabled = Bool(isEnabledString)
    else {
      return nil
    }
    return (feature, isEnabled)
  }

  private func process(url: URL) -> Bool {
    guard let (k, v) = parse(url: url) else { return false }
    userDefaults.set(v, forKey: k)
    return true
  }

  internal func override(withValuesFrom url: URL) -> Bool {
    process(url: url)
  }
}

extension UserDefaults: @unchecked Sendable {}

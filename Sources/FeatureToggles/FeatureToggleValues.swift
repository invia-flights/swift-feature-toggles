import Foundation

public struct FeatureToggleValues: Sendable {
  public static var shared = FeatureToggleValues()

  internal let userDefaults: UserDefaults

  public init(
    userDefaults: UserDefaults = .standard
  ) {
    self.userDefaults = userDefaults
  }

  public static func override(withValuesFrom url: URL) -> Bool {
    shared.override(withValuesFrom: url)
  }

  public subscript(key: (some FeatureToggleKey).Type) -> Bool {
    if let value = userDefaults.object(forKey: key.id), let bool = value as? Bool {
      return bool
    }

    #if DEBUG
      return key.debugValue
    #else
      return key.releaseValue
    #endif
  }

  private func bool(for string: String) -> Bool? {
    if string == "true" {
      return true
    }
    if string == "false" {
      return false
    }
    return nil
  }

  private func parse(url: URL) -> (String, Bool)? {
    guard let comps = URLComponents(url: url, resolvingAgainstBaseURL: false),
      comps.host == "toggle",
      let items = comps.queryItems,

      let featureItem = items.first(where: { $0.name == "feature" }),
      let feature = featureItem.value,

      let isEnabledItem = items.first(where: { $0.name == "enabled" }),
      let isEnabledString = isEnabledItem.value,
      let isEnabled = bool(for: isEnabledString)
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

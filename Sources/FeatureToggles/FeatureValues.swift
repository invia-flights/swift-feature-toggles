import Foundation

public struct FeatureValues: Sendable {
  public init(
    userDefaults: UserDefaults = .standard,
    notificationCenter: NotificationCenter = .default
  ) {
    self.userDefaults = userDefaults
    self.notificationCenter = notificationCenter
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
      let idItem = items.first(where: { $0.name == "id" }),
      let id = idItem.value,
      let valueItem = items.first(where: { $0.name == "value" }),
      let stringValue = valueItem.value,
      let value = bool(for: stringValue)
    else {
      return nil
    }
    return (id, value)
  }

  private func process(url: URL) -> Bool {
    guard let (k, v) = parse(url: url) else { return false }
    userDefaults.set(v, forKey: k)
    return true
  }

  internal func handle(url: URL) -> Bool {
    process(url: url)
  }

  public static func handle(url: URL) -> Bool {
    shared.handle(url: url)
  }

  public static var shared = FeatureValues()

  internal let userDefaults: UserDefaults
  internal let notificationCenter: NotificationCenter

  public subscript(key: (some FeatureKey).Type) -> Bool {
    if let id = key.id, let value = userDefaults.object(forKey: id), let bool = value as? Bool {
      return bool
    }

    #if DEBUG
      return key.debugValue
    #else
      return key.defaultValue
    #endif
  }
}

extension UserDefaults: @unchecked Sendable {}

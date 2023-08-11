import Foundation

/// Lets you access the current value of an existing feature toggle by means of its key path.
@propertyWrapper public struct FeatureToggle {

  /// Creates a new `FeatureToggle` property wrapper.
  /// - Parameters:
  ///   - keyPath: A key path to the desired toggle.
  ///   - featureValues: The `FeatureToggleValues` that acts as storage.
  public init(
    _ keyPath: KeyPath<FeatureToggleValues, Bool>, featureValues: FeatureToggleValues = .shared
  ) {
    self.keyPath = keyPath
    self.featureValues = featureValues
  }

  private let keyPath: KeyPath<FeatureToggleValues, Bool>
  private var featureValues: FeatureToggleValues

  /// The current value of the toggle.
  public var wrappedValue: Bool {
    featureValues[keyPath: keyPath]
  }
}

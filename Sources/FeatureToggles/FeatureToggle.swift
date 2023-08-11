import Foundation

@propertyWrapper public struct FeatureToggle {
  public init(
    _ keyPath: KeyPath<FeatureToggleValues, Bool>, featureValues: FeatureToggleValues = .shared
  ) {
    self.keyPath = keyPath
    self.featureValues = featureValues
  }

  private let keyPath: KeyPath<FeatureToggleValues, Bool>
  var featureValues: FeatureToggleValues

  public var wrappedValue: Bool {
    featureValues[keyPath: keyPath]
  }
}

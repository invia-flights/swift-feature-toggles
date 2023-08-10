import Foundation

@propertyWrapper public struct FeatureToggle {
  public init(_ keyPath: KeyPath<FeatureValues, Bool>, featureValues: FeatureValues = .shared) {
    self.keyPath = keyPath
    self.featureValues = featureValues
  }

  private let keyPath: KeyPath<FeatureValues, Bool>
  var featureValues: FeatureValues

  public var wrappedValue: Bool {
    featureValues[keyPath: keyPath]
  }
}

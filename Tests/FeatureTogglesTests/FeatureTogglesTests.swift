import XCTest

@testable import FeatureToggles

enum MyFeature: FeatureToggleKey, ReleaseEnabled, DebugEnabled {
  static var id: String = "MY_FEATURE"
}

extension FeatureToggleValues {
  var myFeature: Bool { self[MyFeature.self] }
}

@MainActor
final class FeaturingTests: XCTestCase {
  var notificationCenter: NotificationCenter!
  var userDefaults: UserDefaults!
  var sut: FeatureToggleValues!

  override func setUp() async throws {
    userDefaults = .init()
    notificationCenter = .init()
    sut = .init(userDefaults: userDefaults)
  }

  override func tearDown() async throws {
    let dictionary = userDefaults.dictionaryRepresentation()
    for key in dictionary.keys {
      userDefaults.removeObject(forKey: key)
    }
    sut = nil
  }

  func testItHasTheDefaultValue() throws {
    @FeatureToggle(\.myFeature, featureValues: sut) var myFeature
    XCTAssertEqual(myFeature, true)
    XCTAssertNil(userDefaults.object(forKey: "MY_FEATURE"))
  }

  func testItCanOverrideViaURLs() async throws {
    let handled = sut.override(
      withValuesFrom: URL(string: #"myapp://toggle?feature=MY_FEATURE&enabled=false"#)!)
    @FeatureToggle(\.myFeature, featureValues: sut) var myFeature
    XCTAssert(handled)
    XCTAssertEqual(myFeature, false)
  }
}

import XCTest
@testable import FeatureToggles

enum MyFeature: FeatureKey {
	static var id: String = "MY_FEATURE"
	static var defaultValue: Bool = true
}

extension FeatureValues {
	var myFeature: Bool { self[MyFeature.self] }
}

@MainActor
final class FeaturingTests: XCTestCase {
	var notificationCenter: NotificationCenter!
	var userDefaults: UserDefaults!
	var sut: FeatureValues!

	override func setUp() async throws {
		userDefaults = .init()
		notificationCenter = .init()
		sut = .init(userDefaults: userDefaults, notificationCenter: notificationCenter)
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
		let handled = sut.handle(url: URL(string: #"myapp://toggle?id=MY_FEATURE&value=false"#)!)
		@FeatureToggle(\.myFeature, featureValues: sut) var myFeature
		XCTAssert(handled)
		XCTAssertEqual(myFeature, false)
	}
}

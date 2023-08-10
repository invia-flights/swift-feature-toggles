import Foundation

public protocol FeatureKey: Sendable {
	static var defaultValue: Bool { get }
	static var debugValue: Bool { get }
	static var id: String? { get }
}

public extension FeatureKey {
	static var id: String? { nil }
	static var debugValue: Bool { defaultValue }
}

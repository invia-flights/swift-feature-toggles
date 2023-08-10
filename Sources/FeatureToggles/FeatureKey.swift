import Foundation

public protocol FeatureKey: Hashable, Sendable {
	static var defaultValue: Bool { get }
	static var debugValue: Bool { get }
	static var id: String { get }
}

public extension FeatureKey {
	static var debugValue: Bool { defaultValue }
}

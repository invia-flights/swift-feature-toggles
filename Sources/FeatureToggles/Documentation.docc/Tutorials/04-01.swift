import SwiftUI
import FeatureToggles

struct TeleportView: View {
	var body: some View {
		Button("Teleport!") {
			print("This doesn’t work yet!")
		}
	}
}

extension TeleportView: FeatureKey {
	static let id = "teleport"
	static let defaultValue = false
	static let debugValue = true
}

extension FeatureValues {
	var teleport: Bool { self[TeleportView.self] }
}

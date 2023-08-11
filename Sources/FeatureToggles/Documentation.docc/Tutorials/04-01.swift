import FeatureToggles
import SwiftUI

struct TeleportView: View {
  var body: some View {
    Button("Teleport!") {
      print("This doesn’t work yet!")
    }
  }
}

extension TeleportView: FeatureToggleKey, ReleaseDisabled, DebugEnabled {
  static let featureToggleIdentifier = "teleport"
}

extension FeatureToggleValues {
  var teleport: Bool { self[TeleportView.self] }
}

import SwiftUI
import FeatureToggles

struct ContentView: View {
	@FeatureToggle(\.teleport) var isTeleportButtonEnabled
	
	var body: some View {
		VStack {
			Text("Welcome to our app")
				.font(.title)
			
			TeleportView()
		}
	}
}

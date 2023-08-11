# ``FeatureToggles``

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finvia-flights%2Fswift-feature-toggles%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/invia-flights/swift-feature-toggles)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Finvia-flights%2Fswift-feature-toggles%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/invia-flights/swift-feature-toggles)

A novel approach to feature toggles for Swift programmers.

## Overview

[Feature toggles](https://martinfowler.com/bliki/FeatureFlag.html), also known
as “feature flags,” are a tool to keep a team of developers contributing to
the mainline without revealing half-implemented features on your releases. 

The `FeatureToggles` package provides a mechanism for declaring toggles
in a decentralized manner. Those toggles can stay turned off in `RELEASE` builds, 
keeping the main branch deployable. However, you can turn them on in other 
environments so developers and testers can access them.

## Advantages

Compared to other solutions for managing toggles, `FeatureToggles` 
presents several advantages. 

* **It’s distributed.** Different modules can provide new toggles to their clients. That’s great for modular projects.
* **It’s ergonomic.** Inspired by SwiftUI’s `environment`, it lets you access any toggle with a simple `@FeatureToggle`-annotated property.
* **It’s versatile.** Turn features on or off depending on whether it’s a `DEBUG` or `RELEASE` build, or override the default via a specially-formatted URL.
* **It’s strongly typed.** Leveraging the power of Swift’s type system, it reduces errors and enhances code readability and maintainability.
* **It’s lightweight.** Just a few lines of code, zero dependencies.

## Usage

First, declare a `FeatureToggleKey`. You can extend an existing data structure:

```swift
extension TeleportView: FeatureToggleKey, ReleaseDisabled, DebugEnabled {}
```

Or create a brand new entity:

```swift
enum TeleportFeatureToggle: FeatureToggleKey, ReleaseDisabled, DebugEnabled {}
```

> [!NOTE]
> The `ReleaseEnabled`, `ReleaseDisabled`, `DebugEnabled`, and `DebugDisabled`
> indicate the default toggle behavior. Four combinations are possible:
> 1. `ReleaseDisabled`, `DebugDisabled`
> 2. `ReleaseDisabled`, `DebugEnabled`
> 3. `ReleaseEnabled`, `DebugDisabled`
> 4. `ReleaseEnabled`, `DebugEnabled`

Then, add a getter for your new key.

```swift
extension FeatureToggleValues {
  var teleport: Bool { self[TeleportView.self] }
}
```
 
Finally, use the `@FeatureToggle` property wrapper whenever
you wish to access the current state of the toggle.

```swift
struct ContentView: View {
  @FeatureToggle(\.teleport) var isTeleportButtonEnabled

  var body: some View {
    VStack {
      Text("Welcome to our app")
        .font(.title)

      if isTeleportButtonEnabled {
        TeleportView()
      }
    }
  }
}
```

## Overriding compile-time defaults via URL

Your app can override compile-time defaults with a specially-formatted URL.

First, add a `featureToggleIdentifier` to your key:

```swift
extension TeleportView: FeatureToggleKey, ReleaseDisabled, DebugEnabled {
  static let featureToggleIdentifier = "teleport"
}
``` 

Then, call `FeatureToggleValues.override(withValuesFrom:)` when the app delegate opens a URL.
In an iOS application, it would look something like this:

```swift
public func application(
  _: UIApplication,
  open url: URL,
  options _: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
  FeatureToggleValues.override(withValuesFrom: url)
}
```

If your app’s custom URL is `myapp`, this link would enable the feature
even in `RELEASE` builds with a disabled compile-time toggle.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.

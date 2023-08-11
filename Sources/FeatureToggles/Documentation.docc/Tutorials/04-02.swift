public func application(
  _: UIApplication,
  open url: URL,
  options _: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
  FeatureToggleValues.override(withValuesFrom: url)
}

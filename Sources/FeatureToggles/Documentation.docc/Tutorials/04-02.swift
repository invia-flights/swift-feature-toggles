public func application(
	_: UIApplication,
	open url: URL,
	options _: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
	FeatureValues.handle(url: url)
}

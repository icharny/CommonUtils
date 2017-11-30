public extension RawRepresentable {
    init?(rawValue: Self.RawValue?) {
        guard let rawValue = rawValue else { return nil }

        self.init(rawValue: rawValue)
    }
}

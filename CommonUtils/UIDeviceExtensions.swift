public extension UIDevice {
    static func isIpad() -> Bool {
        return UI_USER_INTERFACE_IDIOM() == .pad
    }

    func isLandscape() -> Bool {
        return [.landscapeLeft, .landscapeRight].contains(orientation)
    }
}

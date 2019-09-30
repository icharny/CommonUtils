public extension UIFont {
    static func preferredFont(forTextStyle textStyle: UIFont.TextStyle, withSymbolicTraits traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let baseFont = UIFont.preferredFont(forTextStyle: textStyle)
        return UIFont(descriptor: baseFont.fontDescriptor.withSymbolicTraits(traits)!,
                      size: baseFont.pointSize)
    }
}

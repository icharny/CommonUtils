public extension UIFont {
    static func preferredFont(forTextStyle textStyle: UIFontTextStyle, withSymbolicTraits traits: UIFontDescriptorSymbolicTraits) -> UIFont {
        let baseFont = UIFont.preferredFont(forTextStyle: textStyle)
        return UIFont(descriptor: baseFont.fontDescriptor.withSymbolicTraits(traits)!,
                      size: baseFont.pointSize)
    }
}

// credit: https://github.com/marinbenc/UIView-Styling

/// An abstraction if `UIView` styling.
public struct UIViewStyle<T: UIView> {

    /// Explicit constructor that takes in a styling function
    ///
    /// - Parameter styling: A styling function that takes a `UIView`
    ///                      instance and performs side-effects on it.
    /// - Returns: A new `UIViewStyle`
    public init(styling: @escaping (T) -> Void) {
        self.styling = styling
    }

    /// The styling function that takes a `UIView` instance
    /// and performs side-effects on it.
    public let styling: (T) -> Void

    /// A factory method that composes multiple styles.
    ///
    /// - Parameter styles: The styles to compose.
    /// - Returns: A new `UIViewStyle` that will call the input styles'
    ///            `styling` method in succession.
    public static func compose(_ styles: UIViewStyle<T>...) -> UIViewStyle<T> {
        return UIViewStyle { view in styles.forEach { $0.styling(view) } }
    }

    /// Compose this style with another.
    ///
    /// - Parameter other: Other style to compose this style with.
    /// - Returns: A new `UIViewStyle` which will call this style's `styling`,
    ///            and then the `other` style's `styling`.
    public func composing(with other: UIViewStyle<T>) -> UIViewStyle<T> {
        return UIViewStyle { view in
            self.styling(view)
            other.styling(view)
        }
    }

    /// Compose this style with another styling function.
    ///
    /// - Parameter otherStyling: The function to compose this style with.
    /// - Returns: A new `UIViewStyle` which will call this style's `styling`,
    ///            and then the input `styling`.
    public func composing(with otherStyling: @escaping (T) -> Void) -> UIViewStyle<T> {
        return composing(with: UIViewStyle(styling: otherStyling))
    }

    /// Apply this style to a UIView.
    ///
    /// - Parameter view: the view to style
    public func apply(to view: T) {
        styling(view)
    }

    /// Apply this style to multiple views.
    ///
    /// - Parameter views: the views to style
    public func apply(to views: T...) {
        views.forEach { styling($0) }
    }

    /// Apply this style to multiple views.
    ///
    /// - Parameter views: the views to style
    public func apply(to views: [T]) {
        views.forEach { styling($0) }
    }
}

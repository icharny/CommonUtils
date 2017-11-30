open class UIStyle: UIView {
    open override func draw(_: CGRect) {
        isHidden = true
    }

    /*
     Example:
     @IBOutlet public var roundedCornerViews: [UIView]? {
     didSet {
     roundedCornerViews?.forEach {
     $0.layer.cornerRadius = 4.0
     }
     }
     }
     */
}

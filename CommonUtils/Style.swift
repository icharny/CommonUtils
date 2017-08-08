open class UIStyle: UIView {
    override open func draw(_ rect: CGRect) {
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

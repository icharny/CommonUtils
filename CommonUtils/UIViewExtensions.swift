public struct InnerShadowDirection: OptionSet {
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public let rawValue: Int
    
    public static let north  = InnerShadowDirection(rawValue: 1 << 0)
    public static let east = InnerShadowDirection(rawValue: 1 << 1)
    public static let south  = InnerShadowDirection(rawValue: 1 << 2)
    public static let west  = InnerShadowDirection(rawValue: 1 << 3)
}

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let shadowColor = layer.shadowColor {
                return UIColor(cgColor: shadowColor)
            } else {
                return nil
            }
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = max(0, min(1, newValue)) // bound within [0, 1]
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    private static let innerShadowViewTag = 4663774
    
    func removeInnerShadow() {
        subviews.filter { $0.tag == UIView.innerShadowViewTag }
            .first?
            .removeFromSuperview()
    }
    
    func addInnerShadow(radius: CGFloat,
                        color: UIColor,
                        fade: Bool = true,
                        directions: InnerShadowDirection) {
        removeInnerShadow()
        addSubview(createShadowView(radius: radius,
                                    color: color,
                                    fade: fade,
                                    directions: directions))
    }
    
    private func createShadowView(radius: CGFloat,
                                  color: UIColor,
                                  fade: Bool,
                                  directions: InnerShadowDirection) -> UIView {
        let shadowView = PassThroughView(frame: bounds)
        shadowView.backgroundColor = UIColor.clear
        shadowView.tag = UIView.innerShadowViewTag
        
        var shadow: CAGradientLayer
        let colors = [color.cgColor, fade ? UIColor.clear.cgColor : color.cgColor]
        
        if directions.contains(.north) {
            shadow = CAGradientLayer()
            shadow.colors = colors
            shadow.startPoint = CGPoint(x: 0.5, y: 0.0)
            shadow.endPoint = CGPoint(x: 0.5, y: 1.0)
            shadow.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: radius)
            shadowView.layer.addSublayer(shadow)
        }
        
        if directions.contains(.east) {
            shadow = CAGradientLayer()
            shadow.colors = colors
            shadow.startPoint = CGPoint(x: 1.0, y: 0.5)
            shadow.endPoint = CGPoint(x: 0.0, y: 0.5)
            shadow.frame = CGRect(x: bounds.size.width - radius, y: 0, width: radius, height: bounds.size.height)
            shadowView.layer.addSublayer(shadow)
        }
        
        if directions.contains(.south) {
            shadow = CAGradientLayer()
            shadow.colors = colors
            shadow.startPoint = CGPoint(x: 0.5, y: 1.0)
            shadow.endPoint = CGPoint(x: 0.5, y: 0.0)
            shadow.frame = CGRect(x: 0, y: bounds.size.height - radius, width: bounds.size.width, height: radius)
            shadowView.layer.addSublayer(shadow)
        }
        
        if directions.contains(.west) {
            shadow = CAGradientLayer()
            shadow.colors = colors
            shadow.startPoint = CGPoint(x: 0.0, y: 0.5)
            shadow.endPoint = CGPoint(x: 1.0, y: 0.5)
            shadow.frame = CGRect(x: 0, y: 0, width: radius, height: bounds.size.height)
            shadowView.layer.addSublayer(shadow)
        }
        
        return shadowView
    }
    
    var isShown: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
    
    func loadViewFromNib() -> UIView? {
        return loadViewFromNib(type: type(of: self))
    }
    
    func loadViewFromNib(type: AnyClass) -> UIView? {
        let nib = UINib(nibName: String(describing: type), bundle: Bundle(for: type))
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
}

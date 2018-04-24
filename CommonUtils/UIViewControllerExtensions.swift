public protocol Intantiatable {}

extension UIViewController: Intantiatable {}

public extension Intantiatable where Self: UIViewController {
    public static func instance() -> Self {
        return instance(name: String(describing: self))
    }

    public static func instance(name: String) -> Self {
        let nameStrippedOfGenerics = name.components(separatedBy: "<").first!
        let nameAppendingDevice = "\(name)~\(UIDevice.isIpad() ? "ipad" : "iphone")"

        var storyboard: UIStoryboard
        if Bundle.main.path(forResource: nameAppendingDevice, ofType: "storyboardc") != nil {
            storyboard = UIStoryboard(name: nameAppendingDevice, bundle: nil)
        } else {
            storyboard = UIStoryboard(name: nameStrippedOfGenerics, bundle: nil)
        }

        return storyboard.initialViewController()
    }

    public static func instance(_ setup: ((Self) -> Void)) -> Self {
        let newInstance = instance()
        setup(newInstance)
        return newInstance
    }

    public static func instance(name: String, _ setup: ((Self) -> Void)) -> Self {
        let newInstance = instance(name: name)
        setup(newInstance)
        return newInstance
    }
}

public extension UIViewController {
    public var topViewController: UIViewController? {
        if let tbc = self as? UITabBarController {
            return tbc.selectedViewController?.topViewController
        } else if let nc = self as? UINavigationController {
            return nc.visibleViewController?.topViewController
        } else if let presentingVC = presentingViewController,
            presentingViewController as? UINavigationController == nil {
            return presentingVC.topViewController
        } else {
            return self
        }
    }
}

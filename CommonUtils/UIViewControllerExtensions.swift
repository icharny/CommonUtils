public extension UIViewController {
    class func instance() -> Self {
        return instance(name: String(describing: self))
    }
    
    class func instance(name: String) -> Self {
        let nameStrippedOfGenerics = name.components(separatedBy: "<").first!
        let storyboard = UIStoryboard(name: nameStrippedOfGenerics, bundle: nil)
        return storyboard.initialViewController()
    }
    
    var topViewController: UIViewController? {
        if let `self` = self as? UITabBarController {
            return self.selectedViewController?.topViewController
        } else if let `self` = self as? UINavigationController {
            return self.visibleViewController?.topViewController
        } else if let presentingVC = presentingViewController,
            presentingViewController as? UINavigationController == nil {
            return presentingVC.topViewController
        } else {
            return self
        }
    }
}

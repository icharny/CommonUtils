public extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        return instantiateInitialViewController() as! T
    }
}

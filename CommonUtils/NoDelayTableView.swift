public class NoDelayTableView: UITableView {
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        delaysContentTouches = false
        
        // This solves the iOS8 delayed-tap issue.
        // http://stackoverflow.com/questions/19256996/uibutton-not-showing-highlight-on-tap-in-ios7
        subviews.forEach { ($0 as? UIScrollView)?.delaysContentTouches = false }
    }
    
    override public func touchesShouldCancel(in view: UIView) -> Bool {
        // So that if you tap and drag, it cancels the tap.
        return true
    }
}

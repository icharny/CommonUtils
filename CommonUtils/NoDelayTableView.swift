public class NoDelayTableView: UITableView {
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!

        delaysContentTouches = false

        // This solves the iOS8 delayed-tap issue.
        // http://stackoverflow.com/questions/19256996/uibutton-not-showing-highlight-on-tap-in-ios7
        subviews.forEach { ($0 as? UIScrollView)?.delaysContentTouches = false }
    }

    public override func touchesShouldCancel(in _: UIView) -> Bool {
        // So that if you tap and drag, it cancels the tap.
        return true
    }
}

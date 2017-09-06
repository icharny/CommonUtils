public class PassThroughView: UIView {
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return subviews.reduce(false) { acc, next in
            acc || (!next.isHidden && next.alpha > 0 && next.isUserInteractionEnabled && next.point(inside: convert(point, to: next), with: event))
        }
    }
}

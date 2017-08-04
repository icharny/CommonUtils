public class PassThroughView: UIView {
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return subviews.reduce(false) { acc, next in
            return acc || (!next.isHidden && next.alpha > 0 && next.isUserInteractionEnabled && next.point(inside: convert(point, to: next), with: event))
        }
    }
}

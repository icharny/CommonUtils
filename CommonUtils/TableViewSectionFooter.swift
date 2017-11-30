public protocol TableViewSectionFooterIdentifier {
    var filename: String { get }
}

open class TableViewSectionFooter: UIView {
    /* example:
     public enum Footer: String {
     case `default`

     fileprivate var filename: String {
     return "\(String(rawValue.characters.prefix(1)).capitalized)\(String(rawValue.characters.dropFirst()))TableSectionFooterView"
     }
     }
     */

    public static func loadViewFromNib(forTable tableFooter: TableViewSectionFooterIdentifier) -> UIView? {
        let nib = UINib(nibName: tableFooter.filename, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
}

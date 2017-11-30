public protocol TableViewSectionHeaderIdentifier {
    var filename: String { get }
}

open class TableViewSectionHeader: UIView {
    /* example:
     public enum Header: String {
     case `default`

     fileprivate var filename: String {
     return "\(String(rawValue.characters.prefix(1)).capitalized)\(String(rawValue.characters.dropFirst()))TableSectionHeaderView"
     }
     }
     */

    public static func loadViewFromNib(forTable tableHeader: TableViewSectionHeaderIdentifier) -> UIView? {
        let nib = UINib(nibName: tableHeader.filename, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
}

public class TableViewSectionFooter: UIView {
    public enum Header: String {
        case `default`
        
        fileprivate var filename: String {
            return "\(String(rawValue.characters.prefix(1)).capitalized)\(String(rawValue.characters.dropFirst()))TableSectionFooterView"
        }
    }
    
    public static func loadViewFromNib(forTable tableHeader: Header) -> UIView? {
        let nib = UINib(nibName: tableHeader.filename, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
}

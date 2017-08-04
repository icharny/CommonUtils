public extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        register(UINib(nibName: cell.cellId, bundle: nil),
                 forCellReuseIdentifier: cell.cellId)
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.cellId, for: indexPath) as! T
    }
    
    func reloadVisible(_ animation: UITableViewRowAnimation = .none) {
        DispatchQueue.main.async {
            self.indexPathsForVisibleRows.then { self.reloadRows(at: $0, with: animation) }
        }
    }
}

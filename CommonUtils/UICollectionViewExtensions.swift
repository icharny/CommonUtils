public extension UICollectionView {
    func register<T: UICollectionViewCell>(cell _: T.Type) {
        register(UINib(nibName: T.cellId, bundle: nil),
                 forCellWithReuseIdentifier: T.cellId)
    }

    func dequeue<T: UICollectionViewCell>(cell _: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.cellId,
                                   for: indexPath) as! T
    }

    func register<T: UICollectionReusableView>(view _: T.Type, kind: String) {
        register(UINib(nibName: T.reuseId, bundle: nil),
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: T.reuseId)
    }

    func dequeue<T: UICollectionReusableView>(view _: T.Type, kind: String, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.reuseId,
                                                for: indexPath) as! T
    }
}

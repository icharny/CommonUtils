public extension Optional {
    func then(_ closure: (Wrapped) -> Void) {
        if let unwrapped = self {
            closure(unwrapped)
        }
    }

    func then(_ thenClosure: (Wrapped) -> Void, else elseClosure: () -> Void) {
        if let unwrapped = self {
            thenClosure(unwrapped)
        } else {
            elseClosure()
        }
    }
}

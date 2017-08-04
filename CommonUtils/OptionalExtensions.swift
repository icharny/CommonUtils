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
    
    func then<T>(_ map: (Wrapped) -> T, else elseValue: T?) -> T? {
        if let unwrapped = self {
            return map(unwrapped)
        } else {
            return elseValue
        }
    }
}

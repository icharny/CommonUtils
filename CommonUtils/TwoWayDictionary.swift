struct TwoWayDictionary<T1: Hashable, T2: Hashable>: ExpressibleByDictionaryLiteral {
    private var leftToRight: [T1: T2]!
    private var rightToLeft: [T2: T1]!
    
    init() {
        leftToRight = [:]
        rightToLeft = [:]
    }
    
    init(dictionaryLiteral elements: (T1, T2)...) {
        leftToRight = [:]
        rightToLeft = [:]
        elements.forEach { leftToRight[$0.0] = $0.1; rightToLeft[$0.1] = $0.0 }
    }
    
    subscript(key: T1) -> T2? {
        get {
            return leftToRight[key]
        }
        set(newValue) {
            if let currentValue = leftToRight[key] {
                rightToLeft.removeValue(forKey: currentValue)
            }
            
            if let newValue = newValue {
                leftToRight[key] = newValue
                rightToLeft[newValue] = key
            } else {
                leftToRight.removeValue(forKey: key)
            }
        }
    }
    
    subscript(key: T2) -> T1? {
        get {
            return rightToLeft[key]
        }
        set(newValue) {
            if let currentValue = rightToLeft[key] {
                leftToRight.removeValue(forKey: currentValue)
            }
            
            if let newValue = newValue {
                rightToLeft[key] = newValue
                leftToRight[newValue] = key
            } else {
                rightToLeft.removeValue(forKey: key)
            }
        }
    }
}

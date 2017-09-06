public extension Dictionary {
    func deepMap<nK: Hashable, nV>(keyMap: ((Key) -> nK)? = nil, valueMap: ((Value) -> nV)? = nil) -> [nK: nV] {
        var newDict = [nK: nV]()
        forEach { k, v in
            let newKey: nK = keyMap?(k) ?? (k as! nK)
            let newValue: nV = valueMap?(v) ?? (v as! nV)
            
            newDict[newKey] = newValue
        }
        
        return newDict
    }
    
    func appending(newDict: [Key: Value]) -> [Key: Value] {
        var combinedDict = self
        newDict.forEach { k, v in
            combinedDict[k] = v
        }
        
        return combinedDict
    }
    
    func filterToDictionary(includeElement: (Dictionary.Iterator.Element) throws -> Bool) rethrows -> [Key: Value] {
        var ret = [Key: Value]()
        if let tuples = try? filter(includeElement) {
            tuples.forEach { k, v in
                ret[k] = v
            }
        }
        return ret
    }
    
    // NOTE: NOT COMMUTATIVE
    // i.e. dict1 + dict2 != dict2 + dict1
    // specifically, for common keys, rhs will overwrite lhs
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        var newDict: [Key: Value] = [:]
        lhs.forEach { newDict[$0.key] = $0.value }
        rhs.forEach { newDict[$0.key] = $0.value }
        return newDict
    }
    
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        rhs.forEach { lhs[$0.key] = $0.value }
    }
}

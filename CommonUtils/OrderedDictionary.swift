public struct OrderedDictionary<Tk: Hashable, Tv: Hashable>: Sequence, ExpressibleByDictionaryLiteral {
    fileprivate var keys: [Tk] = []
    fileprivate var values: [Tk: Tv] = [:]

    public func makeIterator() -> OrderedDictionaryGenerator<Tv> {
        return OrderedDictionaryGenerator(values: allValues)
    }

    public var count: Int {
        assert(keys.count == values.count, "Keys and values array out of sync")
        return keys.count
    }

    // Explicitly define an empty initializer to prevent the default memberwise initializer from being generated
    public init() {}

    public init(dictionaryLiteral: (Tk, Tv)...) {
        keys = dictionaryLiteral.map { $0.0 }
        dictionaryLiteral.forEach {
            values[$0.0] = $0.1
        }
    }

    public func indexOf(value: Tv) -> Int {
        let arr = values.filter { $1 == value }

        if let firstPair = arr.first,
            let index = keys.firstIndex(of: firstPair.key) {
            return index
        } else {
            return -1
        }
    }

    public subscript(index: Int) -> Tv? {
        get {
            switch index {
            case 0 ..< keys.count:
                let key = keys[index]
                return values[key]
            default:
                return nil
            }
        }
        set(newValue) {
            let key = keys[index]
            if newValue != nil {
                values[key] = newValue
            } else {
                values.removeValue(forKey: key)
                keys.remove(at: index)
            }
        }
    }

    public subscript(key: Tk) -> Tv? {
        get {
            return values[key]
        }
        set(newValue) {
            if newValue == nil {
                values.removeValue(forKey: key)
                keys = keys.filter { $0 != key }
            }

            let oldValue = values.updateValue(newValue!, forKey: key)
            if oldValue == nil {
                keys.append(key)
            }
        }
    }

    public var allKeys: [Tk] {
        return keys
    }

    public var allValues: [Tv] {
        return keys.map { values[$0]! }
    }

    public var description: String {
        var result = "{\n"
        (0 ..< count).forEach { i in
            result += "[\(i)]: \(keys[i]) => \(self[i]!)\n"
        }
        result += "}"
        return result
    }

    public mutating func remove(value: Tv) {
        for i in 0 ..< count {
            let key = keys[i]
            if values[key]! == value {
                values.removeValue(forKey: key)
                keys.remove(at: i)
                return
            }
        }
    }

    public mutating func remove(key: Tk) {
        for i in 0 ..< count {
            let testKey = keys[i]
            if testKey == key {
                values.removeValue(forKey: key)
                keys.remove(at: i)
                return
            }
        }
    }

    public mutating func removeAll() {
        values.removeAll()
        keys.removeAll()
    }

    public func filter(includeElement: (OrderedDictionary.Iterator.Element) throws -> Bool) rethrows -> OrderedDictionary<Tk, Tv> {
        var filteredOrderedDictionary = OrderedDictionary()
        values
            .filter { try! includeElement($0.1) }
            .forEach { filteredOrderedDictionary[$0.0] = $0.1 }
        return filteredOrderedDictionary
    }

    public mutating func randomizeOrder() {
        var orderedDict = OrderedDictionary<Tk, Tv>()
        var keys = self.keys
        while !keys.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(keys.count)))
            let key = keys[randomIndex]
            let val = self[key]
            orderedDict[key] = val
            keys.remove(at: randomIndex)
        }
        self = orderedDict
    }

    public var isEmpty: Bool {
        return count == 0
    }

    public mutating func sortKeys(by: (Tk, Tk) -> Bool) {
        keys.sort(by: by)
    }

    public mutating func insert(key: Tk, value: Tv, at: Int) {
        keys.firstIndex(of: key).then {
            keys.remove(at: $0)
        }
        keys.insert(key, at: at)
        values[key] = value
    }
}

public struct OrderedDictionaryGenerator<Tv>: IteratorProtocol {
    fileprivate var nextIndex: Int
    fileprivate var values: [Tv]?

    init(values: [Tv]) {
        self.values = values
        nextIndex = 0
    }

    public mutating func next() -> Tv? {
        if nextIndex >= values!.count {
            return nil
        }

        nextIndex += 1
        return values![nextIndex - 1]
    }
}

public extension Array {
    func tryGet(_ index: Int) -> Element? {
        switch index {
        case 0..<count: return self[index]
        default: return nil
        }
    }

    func appending(_ newElement: Element) -> [Element] {
        var newArray = self
        newArray.append(newElement)
        return newArray
    }
}

public extension Array where Element: Hashable {
    func unique() -> [Element] {
        return Array(Set(self))
    }
}

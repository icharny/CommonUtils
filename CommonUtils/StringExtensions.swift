infix operator =~

public extension String {
    init(fromData data: Data?) {
        if let data = data {
            self = data.map { String(format: "%02x", $0) }.joined()
        } else {
            self = ""
        }
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        let boundingBox = (self as NSString).boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }

    func trimWhitespace() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, arguments: args)
    }

    func substring(to: Int) -> String {
        switch to {
        case 0 ... count:
            return String(self[startIndex ..< index(startIndex, offsetBy: to)])
        default:
            return self
        }
    }

    func substring(from: Int) -> String {
        switch from {
        case 0 ... count:
            return String(self[index(startIndex, offsetBy: from) ..< endIndex])
        default:
            return ""
        }
    }

    func substring(with range: Range<Int>) -> String {
        switch (range.lowerBound, range.upperBound) {
        case (0 ... count, range.lowerBound ... Int.max):
            let start = index(startIndex, offsetBy: range.lowerBound)
            let end = index(startIndex, offsetBy: min(range.upperBound, count))

            return String(self[start ..< end])
        default:
            return ""
        }
    }

    func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()

        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }

        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: count))

        guard let match = matches.first else { return results }

        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }

        for i in 1 ... lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }

        return results
    }

    func replacingCharacters(in range: NSRange, with string: String) -> String {
        return (self as NSString).replacingCharacters(in: range, with: string)
    }

    static func isNilOrEmptyString(_ object: Any?) -> Bool {
        return object == nil || ((object as? String)?.isEmpty ?? false)
    }

    func preferredWidth(forFont font: UIFont) -> CGFloat {
        return (self as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                               options: .usesLineFragmentOrigin,
                                               attributes: [NSAttributedStringKey.font: font],
                                               context: nil)
            .width
    }
}

public extension String {
    static func =~ (testString: String, regExString: String) -> Bool {
        if let regEx = try? NSRegularExpression(pattern: regExString, options: []) {
            return regEx.matches(in: testString, options: [], range: NSRange(location: 0, length: testString.count)).count > 0
        } else {
            return false
        }
    }

    static func * (lhs: String, rhs: Int) -> String {
        return (0 ..< rhs).map { _ in lhs }.joined()
    }

    static func * (lhs: Int, rhs: String) -> String {
        return rhs * lhs
    }

    static func toReadable(_ obj: Any?, indent: Int = 0) -> String {
        guard let obj = obj else { return "" }

        if let obj = obj as? [AnyHashable: Any] {
            return "\(indent > 0 ? "\n" : "")\("  " * indent){\n\(obj.map { "\("  " * (indent + 1))\(String.toReadable($0.key, indent: indent + 1)): \(String.toReadable($0.value, indent: indent + 1))" }.joined(separator: ",\n"))\n\("  " * indent)}"
        } else if let obj = obj as? [Any] {
            return "[\n\(obj.map { ("  " * (indent + 1)) + String.toReadable($0, indent: indent + 1) }.joined(separator: ",\n"))\n\("  " * indent)]"
        } else {
            return "\(obj)"
        }
    }
}

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
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
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
        return substring(to: index(startIndex, offsetBy: to))
    }
    
    func substring(from: Int) -> String {
        return substring(from: index(startIndex, offsetBy: from))
    }
    
    func substring(with range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(endIndex, offsetBy: range.upperBound)
        let indexRange = start..<end
        
        return substring(with: indexRange)
    }
    
    func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: characters.count))
        
        guard let match = matches.first else { return results }
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.rangeAt(i)
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
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        
        return from..<to
    }
    
    func preferredWidth(forFont font: UIFont) -> CGFloat {
        return self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                 options: .usesLineFragmentOrigin,
                                 attributes: [NSFontAttributeName: font],
                                 context: nil)
            .width
    }
}

public extension String {
    static func =~ (testString: String, regExString: String) -> Bool {
        if let regEx = try? NSRegularExpression(pattern: regExString, options: []) {
            return regEx.matches(in: testString, options: [], range: NSRange(location: 0, length: testString.characters.count)).count > 0
        } else {
            return false
        }
    }
    
    static func * (lhs: String, rhs: Int) -> String {
        return (0..<rhs).map { _ in lhs }.joined()
    }
    
    static func toReadable(_ obj: Any?, indent: Int = 0) -> String {
        guard let obj = obj else { return "" }
        
        if let obj = obj as? [AnyHashable: Any] {
            return "\(indent > 0 ? "\n" : "")\("  " * indent){\n\(obj.map { "\("  " * (indent + 1))\(String.toReadable($0.key, indent: indent + 1)): \(String.toReadable($0.value, indent: indent + 1))" }.joined(separator: ",\n"))\n\("  " * indent)}"
        } else if let obj = obj as? [Any] {
            return "[\n\(obj.map { ("  " * (indent + 1)) + String.toReadable($0, indent: indent + 1)}.joined(separator: ",\n"))\n\("  " * indent)]"
        } else {
            return "\(obj)"
        }
    }
}

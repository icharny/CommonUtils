public struct DateFormatter {
    public static let shared = DateFormatter()

    fileprivate let dateFormatter = Foundation.DateFormatter()

    public func date<T: RawRepresentable>(fromString dateString: String?, format: T) -> Date? where T.RawValue == String {
        return date(fromString: dateString, format: format.rawValue)
    }

    public func string<T: RawRepresentable>(fromDate date: Date?, format: T) -> String? where T.RawValue == String {
        return string(fromDate: date, format: format.rawValue)
    }

    public func date(fromString dateString: String?, format: String) -> Date? {
        dateFormatter.dateFormat = format
        if let dateString = dateString {
            return dateFormatter.date(from: dateString)
        } else {
            return Date()
        }
    }

    public func string(fromDate date: Date?, format: String) -> String? {
        dateFormatter.dateFormat = format
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}

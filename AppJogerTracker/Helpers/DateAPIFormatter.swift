import Foundation

public class DateAPIFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"

        return formatter
    }()

    class func shortString(fromDate date: Date) -> String {
        return formatter.string(from: date)
    }

    class func date(fromShortString string: String) -> Date? {
        return formatter.date(from: string)
    }
}

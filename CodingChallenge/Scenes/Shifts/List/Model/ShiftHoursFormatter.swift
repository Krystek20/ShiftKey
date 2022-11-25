import Foundation

struct ShiftHoursFormatter {
    
    // MARK: - Properties
    private let hourFormatter = DateFormatter(dateFormat: "HH:ss")
   
    // MARK: - Formatter
    func hours(from startDate: Date, endDate: Date) -> String {
        let startHour = hourFormatter.string(from: startDate)
        let endHour = hourFormatter.string(from: endDate)
        return startHour + " - " + endHour
    }
}

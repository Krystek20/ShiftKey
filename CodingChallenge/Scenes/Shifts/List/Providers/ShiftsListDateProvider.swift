import Foundation

protocol ShiftsListDateProviderType {
    var startDate: String { get }
    var endDate: String { get }
    func setFirstDayOfNextWeek()
}

final class ShiftsListDateProvider: ShiftsListDateProviderType {
    
    // MARK: - Properties
    private var dayOfWeek: Date
    private let calendar: Calendar
    private let dateFormatter: DateFormatter
    
    var startDate: String {
        dateFormatter.string(from: dayOfWeek)
    }
    
    var endDate: String {
        let daysToAdd = daysToNextWeek - 1
        let date = calendar.date(byAdding: .day, value: daysToAdd, to: dayOfWeek)
        return dateFormatter.string(from: date ?? dayOfWeek)
    }
    
    private var daysToNextWeek: Int {
        let currentWeekday = calendar.dateComponents([.weekday], from: dayOfWeek).weekday ?? .zero
        let daysOfWeek = 7
        return daysOfWeek - currentWeekday + calendar.firstWeekday
    }
    
    // MARK: - Initialization
    init(initialDate: Date = Date(),
         calender: Calendar = Calendar(identifier: .gregorian),
         dateFormatter: DateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd")) {
        self.dayOfWeek = initialDate
        self.calendar = calender
        self.dateFormatter = dateFormatter
    }
    
    // MARK: - Helpers
    func setFirstDayOfNextWeek() {
        dayOfWeek = calendar.date(byAdding: .day, value: daysToNextWeek, to: dayOfWeek) ?? dayOfWeek
    }
}

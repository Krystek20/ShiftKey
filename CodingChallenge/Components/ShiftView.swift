import SwiftUI

struct ShiftView: View {

    // MARK: - Properties
    let shiftItem: ShiftItem
    let isDividerVisible: Bool

    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            hoursView
            facilityView
            skillView
            specialtyView
            dividerIfNeeded
        }
        .padding(.horizontal, 10.0)
    }
    
    private var hoursView: some View {
        ShiftKeyValueView(key: "HOURS:", value: shiftItem.hoursRange)
    }
    
    private var facilityView: some View {
        ShiftKeyValueView(key: "FACILITY:", value: shiftItem.facilityName)
    }
    
    private var skillView: some View {
        ShiftKeyValueView(key: "SKILL:", value: shiftItem.skillName)
    }
    
    private var specialtyView: some View {
        ShiftKeyValueView(key: "SPECIALTY:", value: shiftItem.specialtyName)
    }
    
    private var dividerIfNeeded: some View {
        guard isDividerVisible else { return AnyView(EmptyView()) }
        return AnyView(Divider())
    }
}

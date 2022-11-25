import SwiftUI

struct ShiftListHeaderView: View {

    // MARK: - Properties
    let dayItem: DayItem

    // MARK: - Views
    var body: some View {
        VStack(spacing: .zero) {
            Text(dayItem.date)
                .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14.0, weight: .bold))
                .padding(.vertical, 5.0)
                .padding(.horizontal, 10.0)
            Divider()
        }
        .background(Color.white)
    }
}

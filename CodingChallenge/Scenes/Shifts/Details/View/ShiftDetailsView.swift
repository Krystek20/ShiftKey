import SwiftUI

struct ShiftDetailsView<ViewModel: ShiftDetailsViewModelType>: View {

    // MARK: - Properties
    @ObservedObject private(set) var viewModel: ViewModel

    // MARK: - Views
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ShiftView(shiftItem: viewModel.shiftItem, isDividerVisible: false)
            addionalInformation
            Spacer()
        }
        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
    }
    
    private var addionalInformation: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("More information about details")
                .font(.system(size: 16.0, weight: .regular))
            ShiftKeyValueView(key: "DISTANCE:", value: viewModel.shiftItem.distance)
        }
        .padding(.top, 10.0)
        .padding(.horizontal, 10.0)
    }
}

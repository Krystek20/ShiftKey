import SwiftUI

struct ShiftsListView<ViewModel: ShiftsListViewModelType>: View {

    // MARK: - Properties
    @ObservedObject private(set) var viewModel: ViewModel

    // MARK: - Views
    var body: some View {
        content
    }
    
    private var content: some View {
        listView
            .onAppear(perform: viewModel.inputs.viewAppeard)
    }
    
    private var listView: some View {
        ScrollView {
            LazyVStack(spacing: 10.0, pinnedViews: [.sectionHeaders]) {
                sections
                loadingViewIfNeeded
                loadMoreButtonIfNeeded
            }
        }
    }
    
    private var sections: some View {
        ForEach(viewModel.items) { dayItem in
            Section(header: ShiftListHeaderView(dayItem: dayItem)) {
                itemsList(in: dayItem)
            }
        }
    }

    private func itemsList(in dayItem: DayItem) -> some View {
        ForEach(dayItem.shifts) { shiftItem in
            ShiftView(shiftItem: shiftItem, isDividerVisible: true)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.inputs.itemTapped(shiftItem)
                }
                .onAppear(perform: {
                    viewModel.inputs.shiftAppeared(shiftItem)
                })
        }
    }
    
    private var loadingViewIfNeeded: some View {
        guard viewModel.isLoading else { return AnyView(EmptyView()) }
        return AnyView(ProgressView())
    }
    
    private var loadMoreButtonIfNeeded: some View {
        guard viewModel.isManualLoadingButtonVisible else { return AnyView(EmptyView()) }
        return AnyView(moreButton)
    }
    
    private var moreButton: some View {
        Button("Load next week", action: viewModel.inputs.loadMorePressed)
    }
}

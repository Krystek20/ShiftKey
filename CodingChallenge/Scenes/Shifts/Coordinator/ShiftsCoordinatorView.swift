import SwiftUI

struct ShiftsCoordinatorView<Coordinator: ShiftsCoordinatorType>: View {
    
    // MARK: - Properties
    @ObservedObject private(set) var coordinator: Coordinator
    
    // MARK: - Views
    var body: some View {
        listView
    }
    
    // MARK: - List
    private var listView: some View {
        NavigationView {
            ShiftsListView(viewModel: coordinator.viewModel)
                .present(item: $coordinator.detailsViewModel, destination: { viewModel in
                    detailsView(viewModel: viewModel)
                })
                .navigationTitle("Shifts")
        }
    }
    
    // MARK: - Details
    private func detailsView(viewModel: some ShiftDetailsViewModelType) -> some View {
        NavigationView {
            ShiftDetailsView(viewModel: viewModel)
                .navigationTitle("Details")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

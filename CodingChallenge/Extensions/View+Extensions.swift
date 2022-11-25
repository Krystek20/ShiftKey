import SwiftUI

extension View {
    func present<Item: Identifiable, Destination: View>(item: Binding<Item?>, @ViewBuilder destination: @escaping (Item) -> Destination) -> some View {
        let isPresented = Binding(
            get: { item.wrappedValue != nil },
            set: { value in
                guard !value else { return }
                item.wrappedValue = nil
            }
        )
        return sheet(
            isPresented: isPresented,
            content: {
                item.wrappedValue.map(destination)?.mediumPresentationDetents()
            }
        )
    }
    
    private func mediumPresentationDetents() -> some View {
        Group {
            if #available(iOS 16, *) {
                presentationDetents([.medium])
            } else {
                EmptyView()
            }
        }
    }
}

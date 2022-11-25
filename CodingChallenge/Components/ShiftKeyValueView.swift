import SwiftUI

struct ShiftKeyValueView: View {
    
    // MARK: - Properties
    let key: String
    let value: String

    // MARK: - Views
    var body: some View {
        HStack(spacing: 5.0) {
            Text(key)
                .font(.system(size: 12.0, weight: .bold))
            Text(value)
                .font(.system(size: 16.0, weight: .regular))
        }
    }
}

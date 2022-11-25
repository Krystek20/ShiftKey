import SwiftUI

@main
struct CodingChallengeApp: App {
    
    // MARK: - Properties
    @StateObject var coordinator = ShiftsCoordinator(
        dependencyContainer: DependencyContainer(),
        subjects: ShiftCoordinatorSubjects(),
        scheduler: DispatchQueue.main
    )
    
    var body: some Scene {
        WindowGroup {
            ShiftsCoordinatorView(coordinator: coordinator)
        }
    }
}

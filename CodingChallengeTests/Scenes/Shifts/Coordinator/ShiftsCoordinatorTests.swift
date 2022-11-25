import XCTest
import Combine
@testable import CodingChallenge

final class ShiftsCoordinatorTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: ShiftsCoordinator<ImmediateScheduler>!
    private var subjects: ShiftCoordinatorSubjects!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        subjects = ShiftCoordinatorSubjects()
        sut = ShiftsCoordinator(
            dependencyContainer: DependencyContainer(),
            subjects: subjects,
            scheduler: .shared
        )
    }
    
    override func tearDown() {
        subjects = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testDetailsViewModelCalledWhenConnectedAndItemTappedPublisherCalled() throws {
        // given
        let spy = SpyValue(sut.$detailsViewModel)
        
        // when
        subjects.listSubjects.outputs.itemTappedSubject.send(.fixture())
        
        // then
        let first = try XCTUnwrap(spy.values.first)
        let second = try XCTUnwrap(spy.values.last)
        XCTAssertEqual(spy.values.count, 2)
        XCTAssertNil(first)
        XCTAssertNotNil(second)
    }
}

import XCTest
import Combine
@testable import CodingChallenge

final class ShiftsListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var shiftsRepository: ShiftsRepositoryMock!
    private var sut: ShiftsListViewModel<ImmediateScheduler>!
    private var shiftsListDateProvider: ShiftsListDateProviderStub!
    private let defaultDayItems: [DayItem] = [
        .fixture(
            date: "2022-11-25",
            shifts: [
                .fixture(id: "1")
            ]
        ),
        .fixture(
            date: "2022-11-26",
            shifts: [
                .fixture(id: "1"),
                .fixture(id: "2")
            ]
        )
    ]
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        shiftsRepository = ShiftsRepositoryMock()
        shiftsListDateProvider = ShiftsListDateProviderStub()
        sut = ShiftsListViewModel(
            shiftsRepository: shiftsRepository,
            shiftsListDateProvider: shiftsListDateProvider,
            subjects: ShiftsListSubjects(),
            scheduler: .shared
        )
    }
    
    override func tearDown() {
        shiftsRepository = nil
        shiftsListDateProvider = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testShiftsRepositoryCalledWhenViewAppeared() {
        // when
        sut.inputs.viewAppeard()
        
        // then
        XCTAssertEqual(shiftsRepository.shiftsCounter, 1)
    }
    
    func testItemsCalledWhenViewAppearedAndShiftRepositoryReturnResult() {
        // given
        let spyValue = SpyValue(sut.$items)
        
        // when
        callShiftsOnStart()
        
        // then
        XCTAssertEqual(spyValue.values, [[], defaultDayItems])
    }
    
    func testIsLoadingCalledWhenViewAppearedAndShiftRepositoryReturnResult() {
        // given
        let spyValue = SpyValue(sut.$isLoading)

        // when
        callShiftsOnStart()

        // then
        XCTAssertEqual(spyValue.values, [false, true, false])
    }
    
    func testIsLoadingCalledWhenViewAppearedAndShiftRepositoryReturnError() {
        // given
        let spyValue = SpyValue(sut.$isLoading)
        
        // when
        callShiftsOnStart(with: ErrorStub())
        
        // then
        XCTAssertEqual(spyValue.values, [false, true, false])
    }
    
    func testErrorCalledWhenViewAppearedAndShiftRepositoryReturnError() {
        // given
        let spyValue = SpyValue(sut.outputs.errorPublisher)
        
        // when
        callShiftsOnStart(with: ErrorStub())
        
        // then
        XCTAssertEqual(spyValue.values.count, 1)
    }
    
    func testShiftsRespositoryCalledSecondTimeWhenLastShiftAppeared() {
        // when
        callShiftsOnStart()
        sut.inputs.shiftAppeared(.fixture(id: "2"))

        // then
        XCTAssertEqual(shiftsRepository.shiftsCounter, 2)
    }
    
    func testShiftsRespositoryNotCalledSecondTimeWhenNotLastShiftAppeared() {
        // when
        callShiftsOnStart()
        sut.inputs.shiftAppeared(.fixture(id: "1"))

        // then
        XCTAssertEqual(shiftsRepository.shiftsCounter, 1)
    }
    
    func testShiftsRespositoryNotCalledSecondTimeWhenIsLoading() {
        // when
        sut.inputs.viewAppeard()
        sut.inputs.shiftAppeared(.fixture(id: "2"))

        // then
        XCTAssertEqual(shiftsRepository.shiftsCounter, 1)
    }
    
    func testShiftsRespositoryCalledWhenLoadMorePressed() {
        // when
        sut.inputs.loadMorePressed()

        // then
        XCTAssertEqual(shiftsRepository.shiftsCounter, 1)
    }
    
    func testSetFirstDayOfNextWeekWhenShiftsSet() {
        // when
        callShiftsOnStart()

        // then
        XCTAssertEqual(shiftsListDateProvider.setFirstDayOfNextWeekCounter, 1)
    }
    
    func testIsManualLoadingButtonVisibleWhenNewItemsAreEmptyAndIsNotLoading() {
        // given
        let spyValue = SpyValue(sut.$isManualLoadingButtonVisible)
        
        // when
        sut.inputs.viewAppeard()
        shiftsRepository.callShifts([])

        // then
        XCTAssertTrue(spyValue.values.last ?? false)
    }
    
    // MARK: - Helpers
    private func callShiftsOnStart(with error: Error? = nil) {
        sut.inputs.viewAppeard()
        if let error {
            shiftsRepository.callShifts(with: error)
        } else {
            shiftsRepository.callShifts(defaultDayItems)
        }
    }
}

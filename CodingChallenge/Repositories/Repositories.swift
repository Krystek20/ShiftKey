import Foundation

protocol RepositoriesType {
    var shiftsRepository: ShiftsRepositoryType { get }
}

struct Repositories: RepositoriesType {
    let shiftsRepository: ShiftsRepositoryType
}

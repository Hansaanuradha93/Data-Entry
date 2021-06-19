import Foundation

final class UserListViewModel {
    
    // MARK: Types
    enum SectionType {
        case header
        case detail
    }
    
    struct Section {
        var sectionType: SectionType
        var index: Int
    }
    
    // MARK: Properties
    var sections: [Section] = [
        Section(sectionType: .header, index: 0),
        Section(sectionType: .detail, index: 1)
    ]
    
    var users: [User] = []
}

// MARK: - Methods
extension UserListViewModel {
    
    func getUsers(completion: @escaping (Bool) -> ()) {
        PersistenceManager.retrieveUsers { result in
            switch result {
            case .success(let users):
                self.users = users
                completion(true)
            case .failure(_):
                self.users = []
                completion(false)
            }
        }
    }
    
    func deleteUsers(user: User, completion: @escaping (Bool, String) -> ()) {
        PersistenceManager.updateWith(user: user, actionType: .remove) { error in
            if let error = error {
                completion(false, error.rawValue)
                return
            }
            completion(true, Strings.userRecordDeletedSuccessfully)
        }
    }
}

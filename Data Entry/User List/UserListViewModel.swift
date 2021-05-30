import Foundation

final class UserListViewModel {
    
    var users: [User] = []
    
    func getUsers(completion: @escaping (Bool) -> ()) {
        PersistenceManager.retrieveUsers { result in
            switch result {
            case .success(let users):
                self.users = users
                completion(true)
            case .failure(let error):
                self.users = []
                completion(false)
            }
        }
    }
}

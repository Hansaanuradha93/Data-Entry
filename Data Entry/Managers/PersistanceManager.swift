import Foundation

// MARK: PersistenceActionType
enum PersistenceActionType {
    case add
}


// MARK: - PersistenceManager
enum PersistenceManager {
    
    // MARK: Properties
    static private let defaults = UserDefaults.standard
    
    // MARK: Enums
    enum Keys {
        static let users = "users"
    }
}


// MARK: - Private Methods
extension PersistenceManager {
    
    static func updateWith(user: User, actionType: PersistenceActionType, completed: @escaping (DEError?) -> Void) {
        retrieveUsers { result in
            switch result {
            case .success(var users):
                switch actionType {
                case .add:
                    guard !users.contains(user) else {
                        completed(.alreadyRegistered)
                        return
                    }
                    users.append(user)
                }
                completed(save(users: users))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveUsers(completed: @escaping (Result<[User], DEError>) -> Void) {
        guard let usersData = defaults.object(forKey: Keys.users) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: usersData)
            completed(.success(users))
        } catch {
            completed(.failure(.unableToRegister))
        }
    }
    
    
    static func save(users: [User]) -> DEError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(users)
            defaults.set(encodedFavourites, forKey: Keys.users)
            return nil
        } catch {
            return .unableToRegister
        }
    }
}

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
    
    func extractUsers(completion: @escaping (Bool, String) -> ()) {
        if users.isEmpty {
            completion(false, "You don't have any records to export. Please add some records and retry!")
        } else {
            exportToCSV(completion: completion)
        }
    }
    
    func exportToCSV(completion: @escaping (Bool, String) -> ()) {
        let fileName = "registered_users.csv"
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let documentUrl = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent(fileName)
        
        let output = OutputStream.toMemory()
        
        let csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
        csvWriter?.writeField("Email")
        csvWriter?.writeField("Full Name")
        csvWriter?.writeField("Phone Number")
        csvWriter?.finishLine()
                
        for user in users.enumerated() {
            csvWriter?.writeField(user.element.email ?? "")
            csvWriter?.writeField("\(user.element.firstName ?? "") \(user.element.lastName ?? "")")
            csvWriter?.writeField(user.element.phoneNumber ?? "")

            csvWriter?.finishLine()
        }

        csvWriter?.closeStream()
        
        guard let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey) as? Data) else { return }
        
        do {
            try buffer.write(to: documentUrl)
        } catch(let error) {
            completion(false, error.localizedDescription)
        }
        
        completion(true, "User records successfully saved!\nCheck \(fileName) in your Files app.")
    }
}

import UIKit

struct Strings {
   
    // Titles
    static let users = "Users"
    
    // Buttons
    static let extract = "Extract"
    static let ok = "OK"
    
    // Placeholders
    static let email = "Email"
    static let fullName = "Full Name"
    static let phoneNumber = "Phone Number"

    // Alerts
    static let youHaveSuccessfullyAddedTheUser = "You have successfully added this user"
    static let userRecordDeletedSuccessfully = "User record deleted successfully"
    static let somethingWentWrong = "Somthing went wrong!"
    static let unableToCompleteRequest = "Unable to complete request"
    static let noRegisteredUsersYet = "No Registered Users Yet.\nAdd New One 😀"
    static let noRecordsYet = "You don't have any records to export. Please add some records and retry!"
    static let userRecordsSavedSuccessfullyInApp = "User records successfully saved!\nCheck \(Path.registeredUserCSV) in your Files app."
    static let successful = "Successful"
    static let noRecords = "No Records"
}

struct Path {
    static let registeredUserCSV = "registered_users.csv"
}

// MARK: - Fonts
struct Fonts {
    static let avenirNext = "Avenir Next"
}

// MARK: - Asserts
struct Asserts {
    static let docFill = UIImage(systemName: "doc.text.fill")!
}

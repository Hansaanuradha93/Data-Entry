import Foundation

enum DEError: String, Error {
    case unableToRegister = "There was an error registering"
    case alreadyRegistered = "This user is already registered"
}

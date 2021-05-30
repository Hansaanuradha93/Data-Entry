import Foundation

final class RegisterViewModel {
    
    // MARK: Properties
    var email: String? { didSet { checkFormValidity() } }
    var fistName: String? { didSet { checkFormValidity() } }
    var lastName: String? { didSet { checkFormValidity() } }
    var phoneNumber: String? { didSet { checkFormValidity() } }

    // MARK: Bindlable
    var bindalbeIsFormValid = Bindable<Bool>()
}

// MARK: - Methods
extension RegisterViewModel {
    
    private func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && fistName?.isEmpty == false && lastName?.isEmpty == false && phoneNumber?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}

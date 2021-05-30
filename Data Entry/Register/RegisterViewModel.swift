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
        let emailValue = email ?? ""
        let phoneNumberValue = phoneNumber ?? ""
        let isEmailValid = emailValue.isBlank == false && emailValue.isEmail
        let isPhoneNumberValid = phoneNumberValue.isPhoneNumber
                
        let isFormValid = isEmailValid && fistName?.isBlank == false && lastName?.isBlank == false && isPhoneNumberValid
        bindalbeIsFormValid.value = isFormValid
    }
}

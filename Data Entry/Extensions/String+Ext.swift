import Foundation

extension String {
    
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options:.caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isPhoneNumber: Bool {
        let regularExpressionForPhone = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
}

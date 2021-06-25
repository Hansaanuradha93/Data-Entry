import UIKit

class DetailCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    // MARK: Cell
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Methods
extension DetailCell {
    
    func set(user: User) {
        nameLabel.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        emailLabel.text = "\(user.email ?? "")"
        phoneNumberLabel.text = "\(user.phoneNumber ?? "")"
    }
}

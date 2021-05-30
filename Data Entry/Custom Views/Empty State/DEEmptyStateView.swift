import UIKit

class DEEmptyStateView: UIView {

    // MARK: Properties
    private let messageLabel = DELabel(textColor: .lightGray, fontSize: 25, numberOfLines: 2)
    private let logoImageView = DEImageView(contentMode: .scaleAspectFill)
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Private Methods
private extension DEEmptyStateView {
    
    func setupUI() {
        let padding: CGFloat = 24
        let dimension: CGFloat = 100
        
        addSubviews(logoImageView, messageLabel)
        logoImageView.centerInSuperview(size: .init(width: dimension, height: dimension))
        messageLabel.anchor(top: logoImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: padding / 2, left: padding, bottom: 0, right: padding))
        
        logoImageView.image = Asserts.docFill
        logoImageView.image = logoImageView.image?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = .lightGray
        messageLabel.text = "No Registered Users Yet.\nAdd New One 😀"
    }
}

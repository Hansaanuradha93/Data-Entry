import UIKit

class DEImageView: UIImageView {
    
    // MARK: Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }

    
    convenience init(image: UIImage = Asserts.docFill, borderWidth: CGFloat = 0, borderColor: UIColor = .clear, contentMode: ContentMode = .scaleAspectFill) {
        self.init(frame: .zero)
        self.image = image
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.contentMode = contentMode
        self.clipsToBounds = true
    }
}

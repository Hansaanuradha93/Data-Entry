import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: Properties
    public class var storyboardName: String {
        return "Main"
    }
    
    static func create(viewModel: RegisterViewModel) -> RegisterViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: RegisterViewController.self)) as? RegisterViewController
        viewController!.viewModel = viewModel
        return viewController!
    }
    
    private var viewModel: RegisterViewModel!
    
    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModelObservers()
    }
    
    // MARK: IBActions
    @IBAction func submitButtonTapped(_ sender: Any) {
        print("submit")
    }
}

// MARK: - Objc Methods
private extension RegisterViewController {
    
    @objc func handleTextChange(textField: UITextField) {
        viewModel.email = emailTextField.text
        viewModel.fistName = firstNameTextField.text
        viewModel.lastName = lastNameTextField.text
        viewModel.phoneNumber = phoneNumberTextField.text
    }
}

// MARK: - Private Methods
private extension RegisterViewController {
    
    func setupViewModelObservers() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.submitButton.backgroundColor = .black
                self.submitButton.setTitleColor(.white, for: .normal)
            } else {
                self.submitButton.backgroundColor = .lightGray
                self.submitButton.setTitleColor(.white, for: .normal)
            }
            self.submitButton.isEnabled = isFormValid
        }
    }
    
    func setupViews() {
        navigationController?.isNavigationBarHidden = true
        
        let radius = CGFloat(10)
        containerView.layer.cornerRadius = radius
        emailTextField.layer.cornerRadius = radius
        firstNameTextField.layer.cornerRadius = radius
        lastNameTextField.layer.cornerRadius = radius
        phoneNumberTextField.layer.cornerRadius = radius
        submitButton.layer.cornerRadius = radius
        
        emailTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        firstNameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    }
}

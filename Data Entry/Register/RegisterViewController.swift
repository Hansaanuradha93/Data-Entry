import UIKit

protocol RegisterViewControllerDelegate {
    func tappedSubmitButton()
}

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
    private let visibleAlpha: CGFloat = 0.7
    var delegate: RegisterViewControllerDelegate?
    
    // MARK: IBOutlets
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModelObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.alphaView.alpha = self.visibleAlpha
        }
    }
    
    // MARK: IBActions
    @IBAction func submitButtonTapped(_ sender: Any) {
        let user = User(email: viewModel.email, firstName: viewModel.fistName, lastName: viewModel.lastName, phoneNumber: viewModel.phoneNumber)
        viewModel.saveUser(user: user) { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.resetUI()
                self.errorMessageLabel.text = ""
                self.dismiss(animated: false) { self.delegate?.tappedSubmitButton() }
            } else {
                self.errorMessageLabel.text = message
            }
        }
    }
}

// MARK: - Objc Methods
private extension RegisterViewController {
    
    @objc func handleTextChange(textField: UITextField) {
        viewModel.email = emailTextField.text
        viewModel.fistName = firstNameTextField.text
        viewModel.lastName = lastNameTextField.text
        viewModel.phoneNumber = phoneNumberTextField.text
        errorMessageLabel.text = ""
    }
    
    @objc func handleTap() {
        dismiss(animated: false)
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
    
    func resetUI() {
        viewModel.email = ""
        viewModel.fistName = ""
        viewModel.lastName = ""
        viewModel.phoneNumber = ""
        
        emailTextField.text = ""
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneNumberTextField.text = ""
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
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(handleTap))
        alphaView.addGestureRecognizer(gesture)
    }
}

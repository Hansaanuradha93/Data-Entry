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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

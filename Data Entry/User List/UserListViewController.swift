import UIKit

class UserListViewController: UIViewController {
    
    // MARK: Properties
    public class var storyboardName: String {
        return "Main"
    }
    
    static func create(viewModel: UserListViewModel) -> UserListViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: UserListViewController.self)) as? UserListViewController
        viewController!.viewModel = viewModel
        return viewController!
    }
    
    private var viewModel: UserListViewModel!
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getUsers()
    }
}


// MARK: - UITableView
extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        
        switch section.sectionType {
        case .header:
            return viewModel.users.count > 0 ? 1 : 0
        case .detail:
            return viewModel.users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = viewModel.sections[indexPath.section]
        
        switch section.sectionType {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailCell.self), for: indexPath) as! DetailCell
            cell.set(user: viewModel.users[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = viewModel.sections[indexPath.section]
        
        switch section.sectionType {
        case .header:
            return 70
        case .detail:
            return 90
        }
    }
}

// MARK: - Private Methods
private extension UserListViewController {
    
    @objc func addButtonTapped() {
        let controller = RegisterViewController.create(viewModel: RegisterViewModel())
        controller.modalPresentationStyle = .overCurrentContext
        controller.delegate = self
        self.present(controller, animated: false)
    }
    
    @objc func extractButtonTapped() {
        exportToCSV()
    }
}

// MARK: - Private Methods
private extension UserListViewController {
    
    func exportToCSV() {
        let fileName = "registered_users.csv"
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let documentUrl = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent(fileName)
        
        let output = OutputStream.toMemory()
        
        let csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
        csvWriter?.writeField("Email")
        csvWriter?.writeField("Full Name")
        csvWriter?.writeField("Phone Number")
        csvWriter?.finishLine()
        
        guard !viewModel.users.isEmpty else { return }
        
        for user in viewModel.users.enumerated() {
            csvWriter?.writeField(user.element.email ?? "")
            csvWriter?.writeField("\(user.element.firstName ?? "") \(user.element.lastName ?? "")")
            csvWriter?.writeField(user.element.phoneNumber ?? "")

            csvWriter?.finishLine()
        }

        csvWriter?.closeStream()
        
        guard let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey) as? Data) else { return }
        
        do {
            try buffer.write(to: documentUrl)
        } catch(let error) {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func updateUI() {
        if self.viewModel.users.isEmpty {
            DispatchQueue.main.async { self.tableView.backgroundView = DEEmptyStateView() }
        } else {
            DispatchQueue.main.async { self.tableView.backgroundView = nil }
        }
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func getUsers() {
        viewModel.getUsers { [weak self] status in
            guard let self = self else { return }
            if status {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorStyle = .none
        tableView.register(HeaderCell.self)
        tableView.register(DetailCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        let extractButton = UIBarButtonItem(title: "Extract", style: .plain, target: self, action: #selector(extractButtonTapped))
        navigationItem.leftBarButtonItem = extractButton
    }
}

// MARK: - RegisterViewControllerDelegate
extension UserListViewController: RegisterViewControllerDelegate {
    
    func tappedSubmitButton() {
        getUsers()
    }
}

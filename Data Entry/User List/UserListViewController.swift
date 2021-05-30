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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserCell.self), for: indexPath) as! UserCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - Private Methods
private extension UserListViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorStyle = .none
//        tableView.removeExcessCells()
        tableView.register(UserCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
//    func updateUI(withFavourites favourites: [Follower]) {
//        if favourites.isEmpty {
//            let message = Strings.noFavouritesGoFollowSome
//            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
//            return
//        }
//        self.favourites = favourites
//        self.setDataSourceAndDelegate(with: favourites)
//        DispatchQueue.main.async {
//            self.view.bringSubviewToFront(self.tableView)
//            self.tableView.reloadData()
//        }
//    }
    
    func getUsers() {
        viewModel.getUsers { [weak self] status in
            guard let self = self else { return }
            if status {
                print(self.viewModel.users)
            }
        }
    }
}

import UIKit
import RealmSwift

class ListingsViewController: UITableViewController {
    
    // MARK: - Instance Properties
    var viewModels: [ContactViewModel] {
        rContacts.map { ContactViewModel($0) }
    }
    
    lazy var rContacts: Results<RContact> = { RealmManager.shared.readContacts() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        refreshData()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let results = RealmManager.shared.readContacts()
        results.forEach { contact in
            print(contact.firstName)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func configureUI() {
        self.title = "Contacts"
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
    }
    
    // MARK: - Refresh
    @objc func refreshData() {
        
        ApiClient.shared.getContacts { (contacts, error) in
            guard error == nil else {
                let alertController = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true) {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
                return
            }
            
            RealmManager.shared.updateContacts(contacts!)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        let profileViewController = ProfileViewController(viewModel)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

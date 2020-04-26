import UIKit
import CoreData

class ListingsViewController: UITableViewController {
    
    var viewModels: [ContactViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        refreshData()
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
            
            self.viewModels = contacts!.map { ContactViewModel($0) }
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
        
    }
}

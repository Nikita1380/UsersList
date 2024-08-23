import UIKit

class UsersTableViewController: UITableViewController {
    
    let networkManager = NetworkManager.shared
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        fetchUsers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = user.firstName
        content.secondaryText = user.lastName
        content.image = UIImage(systemName: "face.smiling")
        
        cell.contentConfiguration = content
        
        networkManager.fetchAvatar(from: user.avatar) { imageData in
            content.image = UIImage(data: imageData)
            content.imageProperties.cornerRadius = tableView.rowHeight / 2
            
            cell.contentConfiguration = content
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

}

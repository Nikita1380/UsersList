import UIKit

extension UsersTableViewController {
    func fetchUsers() {
        networkManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print("Error in fetchUsers: \(error.localizedDescription)")
            }
            self?.tableView.reloadData()
        }
//      users = [User.example]
    }
}

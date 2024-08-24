import UIKit

extension UsersTableViewController {
    func fetchUsers() {
        networkManager.fetchUsers { [weak self] result in
            self?.spinnerView.stopAnimating()
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                print("Error in fetchUsers: \(error.localizedDescription)")
                self.showAlert(withError: error)
            }
            self?.tableView.reloadData()
        }
//      users = [User.example]
    }
}

import UIKit

class UsersTableViewController: UITableViewController {
    
    let networkManager = NetworkManager.shared
    
    var users = [User]()
    var spinnerView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        fetchUsers()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: users[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    //MARK: - Navigation on VC
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let user = users[indexPath.row]
        let userVC = segue.destination as? UserViewController
        userVC?.user = user
    }
    
    //MARK: - Alert
    
    func showAlert(withError networkError: NetworkErrors) {
        let alert = UIAlertController(
            title: networkError.title,
            message: nil,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    private func showSpinner(in view: UIView) {
        spinnerView.style = .large
        spinnerView.startAnimating()
        spinnerView.hidesWhenStopped = true
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinnerView)
        
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

}

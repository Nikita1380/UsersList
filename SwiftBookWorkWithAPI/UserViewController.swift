import UIKit
import Kingfisher

final class UserViewController: UIViewController {
    
    var user: User!
    private let networkManager = NetworkManager.shared
    
    // MARK: - Создание UI
    
    private let userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConst()
        composeUser(user)
    }
    
    // MARK: - Настройка UI
    private func setConst() {
        view.addSubview(userImageView)
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 300),
            userImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor)
        ])
    }
    
    private func composeUser(_ user: User) {
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        
//        networkManager.fetchAvatar(from: user.avatar) { [weak self] imageData in
//            self?.userImageView.image = UIImage(data: imageData)
//        }
        
        userImageView.kf.setImage(with: user.avatar)
    }
}

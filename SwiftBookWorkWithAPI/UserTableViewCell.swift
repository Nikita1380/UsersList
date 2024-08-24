import UIKit
import Kingfisher

final class UserTableViewCell: UITableViewCell {
    
    private let cell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.contentConfiguration = .none
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    private let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = imageView.frame.width / 5
        return imageView
    }()
    
    private let nameLabelCell: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    func configure(with user: User) {
        nameLabelCell.text = "\(user.firstName) \(user.lastName)"
        
        // Кэшируем изображение!
        imageCell.kf.setImage(with: user.avatar)
    }
    
    func setConstCell() {
        cell.addSubview(nameLabelCell)
        cell.addSubview(imageCell)
    }
}

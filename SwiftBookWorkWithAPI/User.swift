import UIKit

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: URL
    
    static let example = User(id: 1, firstName: "Jane", lastName: "Flower", avatar: URL(staticString: "https://reqres.in/img/faces/7-image.jpg"))
}

struct UsersQuery: Decodable {
    let data: [User]
}

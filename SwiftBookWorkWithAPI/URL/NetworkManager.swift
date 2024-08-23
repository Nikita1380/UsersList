import UIKit

final class NetworkManager {
    private init() {}
    
    static let shared = NetworkManager()
    
    func fetchAvatar(from url: URL, completion: @escaping (Data) -> Void) {
        let queue = DispatchQueue.global()
        queue.async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkErrors>) -> Void) {
        URLSession.shared.dataTask(with: Link.allUsers.url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print("response status code: \(response.statusCode)")
            }
            
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                sendFailure(with: .noData)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let usersQuery = try decoder.decode(UsersQuery.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(usersQuery.data))
                }
            } catch {
                sendFailure(with: .decodingError)
            }
            
            func sendFailure(with error: NetworkErrors) {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - Link

extension NetworkManager {
    enum Link {
        case allUsers
        
        var url: URL {
            switch self {
            case .allUsers:
                return URL(staticString: "")
            }
        }
    }
}

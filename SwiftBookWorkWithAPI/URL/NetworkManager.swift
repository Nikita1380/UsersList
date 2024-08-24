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
            guard let data, let response = response as? HTTPURLResponse else {
                print(error?.localizedDescription ?? "No error description")
                sendFailure(with: .noData)
                return
            }
            
            if (200...299).contains(response.statusCode) {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let usersQuery = try decoder.decode(UsersQuery.self, from: data)
                    DispatchQueue.main.async {
                        if usersQuery.data.count == 0 {
                            sendFailure(with: .noUsers)
                            return
                        }
                        completion(.success(usersQuery.data))
                    }
                } catch {
                    sendFailure(with: .decodingError)
                }
                
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
        case withNoData
        case withDecodingError
        case withNoUsers
        
        var url: URL {
            switch self {
            case .allUsers:
                return URL(staticString: "https://reqres.in/api/users")
            case .withNoData:
                return URL(staticString: "https://reqr!!es.in/api/users/3")
            case .withDecodingError:
                return URL(staticString: "https://reqr!!es.in/api/users/3")
            case .withNoUsers:
                return URL(staticString: "https://reqr!!es.in/api/users/page=3")
            }
        }
    }
}

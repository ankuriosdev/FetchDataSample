import Foundation

enum NetworkError: Error {
    case badURL
    case invalidResponse
    case decodingError
    case systemError(description: String)
    case userError(description: String)
}

protocol NetworkService {
    func fetchData<T: Decodable>(url: URL) async throws -> T
}

class URLSessionNetworkService: NetworkService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 500...599:
                    throw NetworkError.systemError(description: "Internal Server Error. Please try again later.")
                case 400...499:
                    throw NetworkError.userError(description: "Invalid request. Please check your input.")
                default:
                    throw NetworkError.userError(description: "Unexpected response from the server.")
                }
            }
            throw NetworkError.invalidResponse
        }

        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}

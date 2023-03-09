import Foundation

public struct PodcastSearchResult: Decodable {
    public let uuid: String
    public let title: String
    public let author: String
}

public class PodcastSearchTask {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }
    public func search(term: String) async throws -> [PodcastSearchResult] {
        let searchURL = URL(string: "\(ServerConstants.Urls.cache())discover/search")!
        var request = URLRequest(url: searchURL)
        request.httpMethod = "POST"

        let json: [String: Any] = ["term": term]

        let jsonData = try JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData

        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode([PodcastSearchResult].self, from: data)
    }
}
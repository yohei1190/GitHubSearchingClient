//
//  WebService.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
}

protocol WebServiceProtocol {
    func searchRepositories(for query: String) async throws -> [Repository]
}

struct WebService: WebServiceProtocol {
    private let baseURL = URL(string: "https://api.github.com")!

    func searchRepositories(for query: String) async throws -> [Repository] {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent("/search/repositories"), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: query),
        ]

        guard let url = urlComponents?.url else {
            throw NetworkError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let searchResult = try decoder.decode(SearchResult.self, from: data)

        return searchResult.repositories
    }
}

//
//  RepositoryStore.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import Foundation

@MainActor
final class RepositoryStore: ObservableObject {
    @Published private(set) var repositories: [Repository] = []
    private let webService: any WebServiceProtocol

    init(webService: any WebServiceProtocol = WebService()) {
        self.webService = webService
    }

    func searchRepositories(for name: String) async throws {
        repositories = try await webService.searchRepositories(for: name)
    }
}

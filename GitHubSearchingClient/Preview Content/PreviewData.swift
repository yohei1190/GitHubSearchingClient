//
//  PreviewData.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/24.
//

import Foundation

enum PreviewData {
    static let owner: Owner = .init(
        login: "apple",
        avatarUrl: "https://avatars.githubusercontent.com/u/10639145?v=4"
    )

    static let repository: Repository = .init(
        id: .init(value: 1),
        name: "swift",
        owner: owner,
        htmlUrl: "https://github.com/apple/swift",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip",
        stargazersCount: 64344
    )

    static let repositories: [Repository] = (1 ... 5).map { createRepository(id: $0) }

    static func createRepository(id: Int) -> Repository {
        Repository(
            id: .init(value: id),
            name: "swift",
            owner: owner,
            htmlUrl: "https://github.com/apple/swift",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip",
            stargazersCount: 64344
        )
    }
}

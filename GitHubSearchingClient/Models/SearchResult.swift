//
//  SearchResult.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import Foundation

struct SearchResult: Decodable {
    var repositories: [Repository]

    private enum CodingKeys: String, CodingKey {
        case repositories = "items"
    }
}

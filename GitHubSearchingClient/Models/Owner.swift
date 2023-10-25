//
//  Owner.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import Foundation

struct Owner: Decodable, Identifiable {
    let id: ID
    let avatarUrl: String

    struct ID: Decodable, Hashable {
        let value: Int

        init(value: Int) {
            self.value = value
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            value = try container.decode(Int.self)
        }
    }
}

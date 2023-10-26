//
//  RepositorySearchListView.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/26.
//

import SwiftUI

struct RepositorySearchListView: View {
    let repositories: [Repository]
    let onTap: (Repository) -> Void

    var body: some View {
        List(repositories) { repository in
            Button {
                onTap(repository)
            } label: {
                RepositoryCardView(repository: repository)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct RepositorySearchListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorySearchListView(repositories: PreviewData.repositories, onTap: { _ in })
    }
}

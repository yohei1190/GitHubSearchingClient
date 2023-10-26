//
//  RepositoryListView.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import SwiftUI

struct RepositoryListView: View {
    @EnvironmentObject private var repositoryStore: RepositoryStore

    @State private var searchText = ""
    @State private var selectedRepository: Repository?
    @State private var isLoading = false

    var repositories: [Repository] {
        repositoryStore.repositories
    }

    func search() {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces)
        guard !trimmedSearchText.isEmpty else { return }

        Task {
            isLoading = true
            defer { isLoading = false }

            do {
                try await repositoryStore.searchRepositories(for: searchText)
            } catch {
                print(error)
            }
        }
    }

    private func handleTap(repository: Repository) {
        selectedRepository = repository
    }

    var body: some View {
        VStack {
            Text("GitHub検索")
                .font(.title)
                .bold()
                .padding(.top)

            TextField("リポジトリ名", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .onSubmit(search)
                .padding()

            if isLoading {
                ProgressView()
            } else if repositories.isEmpty {
                Text("検索結果はありません")
            } else {
                RepositorySearchListView(repositories: repositories, onTap: handleTap)
            }

            Spacer()
        }
        .sheet(item: $selectedRepository) { repository in
            SafariView(url: URL(string: repository.htmlUrl)!)
        }
    }
}

// 検索結果が存在する場合
struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
            .environmentObject(RepositoryStore(webService: PreviewWebService(repositories: PreviewData.repositories)))
    }
}

// 検索結果が存在しない場合
struct RepositoryList_Previews_Empty_Data: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
            .environmentObject(RepositoryStore(webService: PreviewWebService(repositories: [])))
    }
}

struct PreviewWebService: WebServiceProtocol {
    let repositories: [Repository]

    func searchRepositories(for _: String) async throws -> [Repository] {
        try await Task.sleep(for: .seconds(2))
        return repositories
    }
}

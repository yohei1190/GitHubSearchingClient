//
//  RepositoryListView.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import SwiftUI

struct RepositoryListView: View {
    @EnvironmentObject private var repositoryStore: RepositoryStore
    @EnvironmentObject private var sharedError: SharedError

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
                sharedError.set(error: error)
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
        .alert("通信エラー", isPresented: sharedError.isPresenting, actions: {}) {
            Text("インターネットの接続状況を確認して再度お試しください。")
        }
    }
}

// 検索結果が存在する場合
struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
            .environmentObject(RepositoryStore(webService: PreviewWebService(repositories: PreviewData.repositories)))
            .environmentObject(SharedError())
    }
}

// 検索結果が存在しない場合
struct RepositoryList_Previews_Empty_Data: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
            .environmentObject(RepositoryStore(webService: PreviewWebService(repositories: [])))
            .environmentObject(SharedError())
    }
}

struct PreviewWebService: WebServiceProtocol {
    let repositories: [Repository]

    func searchRepositories(for _: String) async throws -> [Repository] {
        try await Task.sleep(for: .seconds(2))
        return repositories
    }
}

// 検索後にエラーを返す場合
struct RepositoryList_Previews_Error: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
            .environmentObject(RepositoryStore(webService: PreviewErrorWebService()))
            .environmentObject(SharedError())
    }
}

struct PreviewErrorWebService: WebServiceProtocol {
    func searchRepositories(for _: String) async throws -> [Repository] {
        throw NetworkError.badRequest
    }
}

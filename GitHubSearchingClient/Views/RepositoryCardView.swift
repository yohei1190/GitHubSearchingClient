//
//  RepositoryCardView.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/23.
//

import SwiftUI

struct RepositoryCardView: View {
    let repository: Repository

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: repository.owner.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(repository.name)
                        .lineLimit(1)
                        .font(.title3)
                        .bold()
                    Text(repository.owner.login)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Label("\(repository.stargazersCount)", systemImage: "star")
                Text(repository.description ?? "")
                    .lineLimit(2)
                    .font(.caption)
            }

            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct RepositoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCardView(repository: PreviewData.repository)
    }
}

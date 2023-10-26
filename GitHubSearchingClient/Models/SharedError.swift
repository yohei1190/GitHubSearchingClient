//
//  SharedError.swift
//  GitHubSV
//
//  Created by yohei shimizu on 2023/10/24.
//

import Foundation
import SwiftUI

final class SharedError: ObservableObject {
    @Published private(set) var error: Error?

    var isPresenting: Binding<Bool> {
        Binding(
            get: { self.error != nil },
            set: { if !$0 { self.error = nil } }
        )
    }

    func set(error: Error) {
        self.error = error
    }
}

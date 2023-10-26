//
//  WebServiceTests.swift
//  GitHubSVTests
//
//  Created by yohei shimizu on 2023/10/25.
//

@testable import GitHubSearchingClient
import OHHTTPStubs
import XCTest

final class WebServiceTests: XCTestCase {
    private var webService: WebService!

    override func setUp() {
        super.setUp()
        webService = WebService()
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        webService = nil
        super.tearDown()
    }

    func testSearchRepositories() async throws {
        guard let jsonObject = getData() else { return }

        stub(condition: isPath("/search/repositories")) { _ in
            HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: ["Content-Type": "application/json"])
        }

        let repository = try await webService.searchRepositories(for: "")

        XCTAssertEqual(repository.count, 30)
        XCTAssertEqual(repository[0].name, "SwiftFormat")
        XCTAssertEqual(repository[1].name, "swift-format")
        XCTAssertEqual(repository[0].owner.login, "nicklockwood")
    }

    func testSearchRepositoriesBadRequest() async throws {
        let errorObject: [String: Any] = ["error": "Bad Request"]

        stub(condition: isPath("/search/repositories")) { _ in
            HTTPStubsResponse(jsonObject: errorObject, statusCode: 400, headers: nil)
        }

        do {
            _ = try await webService.searchRepositories(for: "")
            XCTFail("NetworkError.badRequestがスローされませんでした")
        } catch NetworkError.badRequest {
            // success
        } catch NetworkError.badURL {
            XCTFail("NetworkError.badRequestではなく、NetworkError.badURLがスローされました")
        } catch {
            XCTFail("NetworkError.badRequestではなく、その他のErrorがスローされました")
        }
    }
}

extension WebServiceTests {
    func getData() -> [String: Any]? {
        guard let url = Bundle(for: type(of: self)).url(forResource: "search_repositories_apple", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let body = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            XCTFail("search_repositories_apple.jsonの読み込みに失敗しました")
            return nil
        }
        return body
    }
}

# GitHubリポジトリ検索アプリ
GitHub のリポジトリーを検索するアプリです。
## 目次

- [概要](#概要)
- [スクリーンショット](#スクリーンショット)
- [開発](#開発)

## 概要
### このアプリを作った目的
私が以前開発した「Cycle Snap」という個人アプリでは、データの管理にRealmを中心に使用していました。

しかし、今回はAPI通信の実践経験を増やすことを目的とし、外部APIと連携するアプリケーションの開発を選択しました。

このプロジェクトを通じて、非同期処理やテストの実装、DIの導入、SVアーキテクチャの適用といった、学習技術の具体的なアウトプットを目指しています。



### 動作
1. テキストフィールドにキーワードを入力
1. GitHub API（search/repositories）でリポジトリーを検索し、結果一覧を表示
1. 特定のリポジトリをタップすると、該当リポジトリのGitHubページをSafariViewで表示

## スクリーンショット


|検索前|検索結果（成功）|検索結果（エラー）|詳細シート（SafariView）|
|:--:|:--:|:--:|:--:|
|<img src="./Docs/ScreenShots/検索前.png" width="207">|<img src="./Docs/ScreenShots/検索結果（成功）.png" width="207">|<img src="./Docs/ScreenShots/検索結果（エラー）.png" width="207">|<img src="./Docs/ScreenShots/詳細シート（SafariView）.png" width="207">|


## 開発

### 環境

- macOS Ventura 13.6 
- Xcode 14.3 (Swift 5.8)

### 構成

- UIの実装: SwiftUI
- アーキテクチャ: SV(Store View)
- ブランチモデル: GitHub flow

### こだわった点
- SV（Store View）アーキテクチャ
    - Swift Zoomin' #16(2023/10/21)で紹介されていた、SVアーキテクチャで開発を行いました。
    - 参考
        - [Connpass Swift Zoomin' #16](https://swift-tweets.connpass.com/event/290613/)
        - [Udemy MV Design Pattern in iOS - Build SwiftUI Apps Apple's Way](https://www.udemy.com/course/mv-design-pattern-in-ios-for-swiftui/)
- DI（Dependency Injection）
    - WebServiceProtocolを定義して、「検索成功（結果あり）」、「検索成功（結果なし）」、「検索エラー」の3パターンをプレビューで確認できるようにしました。
- WebServiceのUIテスト
    - HTTP通信のモックとして、OHHTTPStubs/Swiftライブラリを導入しました。



import Foundation

// MARK: - SearchDTO
struct SearchDTO: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let originallink: String
    let link: String
    let description, pubDate: String
}

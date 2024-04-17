import Foundation

// MARK: - Welcome
struct MemeModel: Codable {
    let success: Bool
    let data: DataClass
}

//// MARK: - DataClass
struct DataClass: Codable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Codable {
    var id : String
    let name: String
    let url: String
    let width, height, boxCount, captions: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height
        case boxCount = "box_count"
        case captions
    }
}

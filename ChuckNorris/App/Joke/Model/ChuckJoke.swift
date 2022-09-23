//
//  ChuckJoke.swift
//  ChuckNorris
//
//  Created by Byron Mejia on 9/20/22.
//

import Foundation

struct ChuckJoke: Codable {
    let categories: [String]?
    let iconUrl: String?
    let id: String?
    let url: String?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case categories = "categories"
        case iconUrl = "icon_url"
        case id = "id"
        case url = "url"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        iconUrl = try values.decodeIfPresent(String.self, forKey: .iconUrl)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

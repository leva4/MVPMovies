//
//  Media.swift
//  MVPMovies
//
//  Created by Kresimir Levarda on 24.01.2022..
//

import Foundation

struct Media: Codable {
    let id: Int
    let type: MediaType?
    private let title: String?
    private let name: String?
    let overview: String?
    private let rate: Double?
    private let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, title, overview
        case rate = "vote_average"
        case type = "media_type"
        case posterPath = "poster_path"
    }

    func getTitle() -> String? {
        return name ?? title
    }

    func getPosterUrl() -> URL? {
        guard let posterPath = posterPath,
              let baseUrl = ApiConfigurationService.shared.configuration?.imagesConfiguration.secureBaseUrl
        else { return nil }

        return URL(string: "\(baseUrl)original\(posterPath)")
    }

    func getRateText() -> String {
        if let rate = rate {
            return "Rate: \(rate)/10"
        } else {
            return "No rate yet"
        }
    }
}

extension Media: Equatable, Hashable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: Sort
extension Media {
    static func sort() -> (Media, Media) -> Bool {
        return { (lhs, rhs) -> Bool in
             return lhs.getTitle() ?? "" < rhs.getTitle() ?? ""
        }
    }
}

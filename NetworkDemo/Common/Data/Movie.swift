//
//  Movie.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import Foundation

struct DataModel {
    struct Movies: Decodable {
        let page: Int
        let results: [Movie]
    }

    struct Movie: Decodable, Identifiable {
        let id: Int
        let title: String
        let releaseDate: String
        let originalLanguage: String
        let voteAverage: Double
        let posterPath: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case releaseDate = "release_date"
            case originalLanguage = "original_language"
            case voteAverage = "vote_average"
            case posterPath = "poster_path"
        }
    }
}

extension DataModel.Movie {
    struct Details {
        let id: Int
        let title: String
        let overview: String
        let releaseDate: String
        let originalLanguage: String
        let voteAverage: Double
        let posterPath: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case overview
            case releaseDate = "release_date"
            case originalLanguage = "original_language"
            case voteAverage = "vote_average"
            case posterPath = "poster_path"
        }
    }
}

extension DataModel.Movie {
    var smallPosterUrl: URL? {
        var url = URL(string: ApiConstants.smallImageBaseUrl)
        url?.appendPathComponent(posterPath)
        return url
    }
}

extension DataModel.Movie.Details {
    var largePosterUrl: URL? {
        var url = URL(string: ApiConstants.largeImageBaseUrl)
        url?.appendPathComponent(posterPath)
        return url
    }
}

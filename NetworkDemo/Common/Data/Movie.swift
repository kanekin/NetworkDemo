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
    struct Details: Decodable {
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
    
    struct Credits: Decodable, Identifiable {
        let id: Int
        let casts: [Cast]
        let crews: [Crew]
        
        enum CodingKeys: String, CodingKey {
            case id
            case casts = "cast"
            case crews = "crew"
        }
    }
}

extension DataModel.Movie.Credits {
    struct Cast: Decodable, Identifiable, Hashable, Equatable {
        let id: Int
        let name: String?
        let character: String?
        let profilePath: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case character
            case profilePath = "profile_path"
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    struct Crew: Decodable, Identifiable, Hashable, Equatable {
        let id: Int
        let name: String?
        let job: String?
        let profilePath: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case job
            case profilePath = "profile_path"
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.id == rhs.id
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

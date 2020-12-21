//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import Foundation

public struct MoviesResponse: Decodable {
  let page: Int
  let totalPages: Int
  let totalResults: Int
  let movies: [MovieResponse]
  
  private enum CodingKeys: String, CodingKey {
    case page
    case totalPages = "total_pages"
    case totalResults = "total_results"
    case movies = "results"
  }
}

public struct MovieResponse: Decodable {
  
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case backdropPath = "backdrop_path"
    case overview
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case runtime
    case genres
  }
  
  let id: Int
  let backdropPath: String?
  let overview: String
  let posterPath: String?
  let releaseDate: String?
  let title: String
  let voteAverage: Double
  let voteCount: Int
  let runtime: Int?
  let genres: [MovieGenreResponse]?
}

struct MovieGenreResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case name
  }

  let name: String
}

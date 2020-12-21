//
//  MovieModel.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import Foundation

public struct MovieModel: Decodable, Identifiable {
  public let id: Int
  public let title: String
  public let backdropPath: String?
  public let posterPath: String?
  public let overview: String
  public let voteAverage: Double
  public let voteCount: Int
  public let runtime: Int?
  public let releaseDate: String?
  public let genres: [MovieGenreModel]?
  public var isFavorite: Bool = false
  
  static private let yearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy"
    return formatter
  }()
  
  static let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    return dateFormatter
  }()

  static private let durationFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.hour, .minute]
    return formatter
  }()
  
  public var backdropURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
  }
  
  public var posterURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
  }
  
  public var yearText: String {
    guard let releaseDate = self.releaseDate, let date = MovieModel.dateFormatter.date(from: releaseDate) else {
      return "n/a"
    }
    return MovieModel.yearFormatter.string(from: date)
  }
  
  public var genresText: [String] {
    return genres?.compactMap { $0.name } ?? []
  }
  
  public var durationText: String {
    guard let runtime = self.runtime, runtime > 0 else {
      return "n/a"
    }
    return MovieModel.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
  }
}

//
//  MovieCrewModel.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import Foundation

public struct MovieCrewModel: Decodable {
  public let id: Int
  public let job: String
  public let name: String
  public let profilePath: String?
  
  public var profileURL: URL {
    return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath ?? "")")!
  }
}

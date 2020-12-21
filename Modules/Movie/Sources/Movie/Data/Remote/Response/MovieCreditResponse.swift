//
//  CreditResponse.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 08/12/20.
//

import Foundation

public struct MovieCreditResponse: Decodable, Identifiable {
  public let id: Int
  let cast: [MovieCastResponse]
  let crew: [MovieCrewResponse]
  
  private enum CodingKeys: String, CodingKey {
    case id
    case cast
    case crew
  }
}

public struct MovieCastResponse: Decodable, Identifiable {
  public let id: Int
  let character: String
  let name: String
  let profilePath: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case character
    case name
    case profilePath = "profile_path"
  }
}

public struct MovieCrewResponse: Decodable, Identifiable {
  public let id: Int
  let job: String
  let name: String
  let profilePath: String?
  
  private enum CodingKeys: String, CodingKey {
    case id
    case job
    case name
    case profilePath = "profile_path"
  }
}

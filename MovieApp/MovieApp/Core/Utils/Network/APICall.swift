//
//  APICall.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import Foundation

struct API {
  static let baseUrl = "https://api.themoviedb.org/3/"
  static let apiKey = "9fd3d1e0af6f8756258ada656005e3b4"
}

protocol Endpoint {
  
  var url: String { get }
  
}

enum Endpoints {
  
  enum Gets: Endpoint {
    case nowplaying
    case popular
    case search
    case moviebase
    public var url: String {
      switch self {
      case .nowplaying: return "\(API.baseUrl)movie/now_playing?api_key=\(API.apiKey)"
      case .popular: return "\(API.baseUrl)movie/popular?api_key=\(API.apiKey)"
      case .search: return "\(API.baseUrl)search/movie?api_key=\(API.apiKey)&query="
      case .moviebase: return "\(API.baseUrl)movie/"
      }
    }
  }
  
}

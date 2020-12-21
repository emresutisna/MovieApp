//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 16/12/20.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetMovieRemoteDataSource : DataSource {
    
    public typealias Request = String
    
    public typealias Response = MovieResponse
    
    private let _endpoint: String

    private let _apikey: String
    
    public init(endpoint: String, apikey: String) {
        _endpoint = endpoint
        _apikey = apikey
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        return Future<MovieResponse, Error> { completion in
            guard let request = request else { return completion(.failure(URLError.invalidRequest) )}
            if let url = URL(string: _endpoint + request + "?api_key=\(_apikey)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

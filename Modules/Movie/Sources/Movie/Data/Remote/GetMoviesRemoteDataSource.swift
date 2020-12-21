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

public struct GetMoviesRemoteDataSource : DataSource {
    public typealias Request = String
    
    public typealias Response = [MovieResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: String?) -> AnyPublisher<[MovieResponse], Error> {
        return Future<[MovieResponse], Error> { completion in
            if let url = URL(string: _endpoint) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MoviesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.movies))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

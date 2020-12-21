//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 16/12/20.
//

import Core
import Combine
import RealmSwift
import Foundation


public struct GetNowPlayingMoviesLocaleDataSource: LocaleDataSource {
    
    public typealias Request = String
    
    public typealias Response = MovieEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            let movieEntities = {
                _realm.objects(MovieEntity.self)
                    .filter("isNowPlaying = \(true)")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movieEntities.toArray(ofType: MovieEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in            
            do {
                try _realm.write {
                    for movie in entities {
                        if let currentItem = _realm.object(ofType: MovieEntity.self, forPrimaryKey: movie.id) {
                            movie.isPopular = currentItem.isPopular
                            movie.isFavorite = currentItem.isFavorite
                        }
                        movie.isNowPlaying = true
                        _realm.add(movie, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<MovieEntity, Error> {
        fatalError()
    }
    
    public func update(id: String, entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

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


public struct GetPopularMoviesLocaleDataSource: LocaleDataSource {
    
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
                    .filter("isPopular = \(true)")
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
                            movie.isNowPlaying = currentItem.isNowPlaying
                            movie.isFavorite = currentItem.isFavorite
                        }
                        movie.isPopular = true
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
        return Future<MovieEntity, Error> { completion in
            let movies: Results<MovieEntity> = {
                _realm.objects(MovieEntity.self)
                    .filter("id = '\(id)'")
            }()
            
            guard let movie = movies.first else {
                completion(.failure(DatabaseError.requestFailed))
                return
            }
            completion(.success(movie))
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let movieEntity = {
                _realm.objects(MovieEntity.self).filter("id = '\(id)'")
            }().first {
                do {
                    try _realm.write {
                        movieEntity.setValue(entity.title, forKey: "title")
                        movieEntity.setValue(entity.backdropPath, forKey: "backdropPath")
                        movieEntity.setValue(entity.posterPath, forKey: "posterPath")
                        movieEntity.setValue(entity.overview, forKey: "overview")
                        movieEntity.setValue(entity.voteAverage, forKey: "voteAverage")
                        movieEntity.setValue(entity.voteCount, forKey: "voteCount")
                        movieEntity.setValue(entity.runtime, forKey: "runtime")
                        movieEntity.setValue(entity.releaseDate, forKey: "releaseDate")
                        movieEntity.setValue(entity.isFavorite, forKey: "isFavorite")
                        movieEntity.setValue(entity.genres, forKey: "genres")
                    }
                    completion(.success(true))
                    
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

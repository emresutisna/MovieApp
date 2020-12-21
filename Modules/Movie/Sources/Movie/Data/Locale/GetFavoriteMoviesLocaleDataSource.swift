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


public struct GetFavoriteMoviesLocaleDataSource: LocaleDataSource {
    
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
                    .filter("isFavorite = \(true)")
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(movieEntities.toArray(ofType: MovieEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: String) -> AnyPublisher<MovieEntity, Error> {
        return Future<MovieEntity, Error> { completion in
            if let movieEntity = {
                _realm.objects(MovieEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        movieEntity.setValue(!movieEntity.isFavorite, forKey: "isFavorite")
                    }
                    completion(.success(movieEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

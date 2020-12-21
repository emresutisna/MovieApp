//
//  File.swift
//
//
//  Created by Nanang Sutisna on 18/12/20.
//

import Core
import Combine
import RealmSwift
import Foundation


public struct GetMovieCreditLocaleDataSource: LocaleDataSource {
    public typealias Request = String
    public typealias Response = MovieCreditEntity
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[MovieCreditEntity], Error> {
        fatalError()
    }
    
    public func add(entities: [MovieCreditEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for credit in entities {
                        _realm.add(credit, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<MovieCreditEntity, Error> {
        return Future<MovieCreditEntity, Error> { completion in
            let credit: MovieCreditEntity? = {
                _realm.object(ofType: MovieCreditEntity.self, forPrimaryKey: Int(id))
            }()
            completion(.success(credit ?? MovieCreditEntity()))
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: MovieCreditEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let movieCreditEntity = {
                _realm.objects(MovieCreditEntity.self).filter("id = \(id)")
            }().first {
                do {
                    try _realm.write {
                        movieCreditEntity.setValue(entity.id, forKey: "id")
                        movieCreditEntity.setValue(entity.cast, forKey: "cast")
                        movieCreditEntity.setValue(entity.crew, forKey: "crew")
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

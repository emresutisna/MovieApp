//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 16/12/20.
//

import Core
import RealmSwift

public struct MovieCreditTransformer: Mapper {
    public typealias Request = String
    public typealias Response = MovieCreditResponse
    public typealias Entity = MovieCreditEntity
    public typealias Domain = MovieCreditModel
    
    public init() { }
    
    public func transformResponseToEntity(request: String?, response: MovieCreditResponse) -> MovieCreditEntity {
        let newMovieCredit = MovieCreditEntity()
        newMovieCredit.id = response.id
        newMovieCredit.cast.append(
            objectsIn: response.cast.compactMap {
                MovieCastEntity(
                    $0.id,
                    $0.character,
                    $0.name,
                    $0.profilePath ?? ""
                )
            }
        )
        newMovieCredit.crew.append(
            objectsIn: response.crew.compactMap {
                MovieCrewEntity(
                    $0.id,
                    $0.job,
                    $0.name,
                    $0.profilePath ?? ""
                )
            }
        )
        return newMovieCredit
    }
    
    public func transformEntityToDomain(entity: MovieCreditEntity) -> MovieCreditModel {
        return MovieCreditModel(
            id: entity.id,
            cast: entity.cast.map {
                MovieCastModel(
                    id: $0.id,
                    character: $0.character,
                    name: $0.name,
                    profilePath: $0.profilePath
                )
            },
            crew: entity.crew.map {
                MovieCrewModel(
                    id: $0.id,
                    job: $0.job,
                    name: $0.name,
                    profilePath: $0.profilePath
                )
            }
        )
    }
}

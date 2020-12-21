//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 16/12/20.
//

import Core
import RealmSwift

public struct MovieTransformer: Mapper {
    public typealias Request = String
    public typealias Response = MovieResponse
    public typealias Entity = MovieEntity
    public typealias Domain = MovieModel
    
    public init() {}
    
    public func transformResponseToEntity(request: String?, response: MovieResponse) -> MovieEntity {
        let newMovie = MovieEntity()
        newMovie.id = response.id
        newMovie.title = response.title
        newMovie.backdropPath = response.backdropPath ?? ""
        newMovie.posterPath =  response.posterPath ?? ""
        newMovie.overview = response.overview
        newMovie.voteAverage = response.voteAverage
        newMovie.voteCount = response.voteCount
        newMovie.runtime = response.runtime ?? 0
        newMovie.releaseDate = response.releaseDate ?? ""
        newMovie.genres.append(objectsIn: response.genres?.compactMap { MovieGenreEntity($0.name) } ?? [])
        return newMovie
    }
    
    public func transformEntityToDomain(entity: MovieEntity) -> MovieModel {
        return MovieModel(
            id: entity.id,
            title: entity.title,
            backdropPath: entity.backdropPath,
            posterPath: entity.posterPath,
            overview: entity.overview,
            voteAverage: entity.voteAverage,
            voteCount: entity.voteCount,
            runtime: entity.runtime,
            releaseDate: entity.releaseDate,
            genres: entity.genres.compactMap { MovieGenreModel(name: $0.name) },
            isFavorite: entity.isFavorite
        )
    }
}

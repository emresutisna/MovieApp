//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 17/12/20.
//

import Core
import Combine

public struct UpdateFavoriteMovieRepository<
    MovieLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    MovieLocaleDataSource.Request == String,
    MovieLocaleDataSource.Response == MovieEntity,
    Transformer.Request == String,
    Transformer.Response == MovieResponse,
    Transformer.Entity == MovieEntity,
    Transformer.Domain == MovieModel {
    
    public typealias Request = String
    public typealias Response = MovieModel
    
    private let _localeDataSource: MovieLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MovieLocaleDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<MovieModel, Error> {
        return _localeDataSource.get(id: request ?? "")
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

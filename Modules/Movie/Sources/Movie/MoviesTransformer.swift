//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 17/12/20.
//

import Core

public struct MoviesTransformer<MovieMapper: Mapper>: Mapper
where
    MovieMapper.Request == String,
    MovieMapper.Response == MovieResponse,
    MovieMapper.Entity == MovieEntity,
    MovieMapper.Domain == MovieModel {
    
    public typealias Request = String
    public typealias Response = [MovieResponse]
    public typealias Entity = [MovieEntity]
    public typealias Domain = [MovieModel]
    
    private let _movieMapper: MovieMapper
    
    public init(movieMapper: MovieMapper) {
        _movieMapper = movieMapper
    }
    
    public func transformResponseToEntity(request: String?, response: [MovieResponse]) -> [MovieEntity] {
        return response.map { result in
            _movieMapper.transformResponseToEntity(request: request, response: result)
        }
    }
    
    public func transformEntityToDomain(entity: [MovieEntity]) -> [MovieModel] {
        return entity.map { result in
            return _movieMapper.transformEntityToDomain(entity: result)
        }
    }
}

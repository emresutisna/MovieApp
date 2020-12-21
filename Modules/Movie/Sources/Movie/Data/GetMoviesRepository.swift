//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 16/12/20.
//

import Core
import Combine

public struct GetMoviesRepository<
    MovieLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    MovieLocaleDataSource.Request == String,
    MovieLocaleDataSource.Response == MovieEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [MovieResponse],
    Transformer.Request == String,
    Transformer.Response == [MovieResponse],
    Transformer.Entity == [MovieEntity],
    Transformer.Domain == [MovieModel] {
    
    public typealias Request = String
    public typealias Response = [MovieModel]
    
    private let _localeDataSource: MovieLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MovieLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[MovieModel], Error> {
        return _localeDataSource.list(request: request)
            .flatMap { result -> AnyPublisher<[MovieModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                        .catch { _ in _localeDataSource.list(request: request) }
                        .flatMap {  _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.list(request: request)
                            .map {  _mapper.transformEntityToDomain(entity: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return _localeDataSource.list(request: request)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

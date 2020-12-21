//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 17/12/20.
//

import Core
import Combine

public struct SearchMoviesRepository<
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [MovieResponse],
    Transformer.Request == String,
    Transformer.Response == [MovieResponse],
    Transformer.Entity == [MovieEntity],
    Transformer.Domain == [MovieModel] {
    
    public typealias Request = String
    public typealias Response = [MovieModel]
    
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: String?) -> AnyPublisher<[MovieModel], Error> {
        return _remoteDataSource.execute(request: request)
            .map { _mapper.transformResponseToEntity(request: request, response: $0) }
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()        
    }
}

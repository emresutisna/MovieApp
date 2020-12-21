//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 18/12/20.
//

import Core
import Combine

public struct GetMovieCreditRepository<
    MovieCreditLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    MovieCreditLocaleDataSource.Request == String,
    MovieCreditLocaleDataSource.Response == MovieCreditEntity,
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == MovieCreditResponse,
    Transformer.Request == String,
    Transformer.Response == MovieCreditResponse,
    Transformer.Entity == MovieCreditEntity,
    Transformer.Domain == MovieCreditModel {
    
    public typealias Request = String
    public typealias Response = MovieCreditModel
    
    private let _localeDataSource: MovieCreditLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: MovieCreditLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
        
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }

    public func execute(request: String?) -> AnyPublisher<MovieCreditModel, Error> {
        guard let request = request else { fatalError("Request cannot be empty") }
        return _localeDataSource.get(id: request)
            .flatMap { result -> AnyPublisher<MovieCreditModel, Error> in
                if result.id == 0 {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToEntity(request: request, response: $0) }
                        .catch { _ in _localeDataSource.get(id: request) }
                        .flatMap {  _localeDataSource.add(entities: [$0]) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.get(id: request)
                            .map {  _mapper.transformEntityToDomain(entity: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return _localeDataSource.get(id: request)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}


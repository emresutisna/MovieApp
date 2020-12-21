//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 17/12/20.
//

import Foundation
import Combine
import Core

public class MoviePresenter<MovieUseCase: UseCase, MovieCreditUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    MovieUseCase.Request == String, MovieUseCase.Response == MovieModel,
    MovieCreditUseCase.Request == String, MovieCreditUseCase.Response == MovieCreditModel,
    FavoriteUseCase.Request == String, FavoriteUseCase.Response == MovieModel
{
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _movieUseCase: MovieUseCase
    private let _movieCreditUseCase: MovieCreditUseCase
    private let _favoriteUseCase: FavoriteUseCase
    
    @Published public var item: MovieModel?
    @Published public var credit: MovieCreditModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(movieUseCase: MovieUseCase, movieCreditUseCase: MovieCreditUseCase, favoriteUseCase: FavoriteUseCase) {
        _movieUseCase = movieUseCase
        _movieCreditUseCase = movieCreditUseCase
        _favoriteUseCase = favoriteUseCase
    }
    
    public func getMovie(request: MovieUseCase.Request) {
        isLoading = true
        _movieUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func getMovieCredit(request: MovieCreditUseCase.Request) {
        isLoading = true
        _movieCreditUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { result in
                self.credit = result
            })
            .store(in: &cancellables)
    }
    
    public func updateFavoriteMovie(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
}

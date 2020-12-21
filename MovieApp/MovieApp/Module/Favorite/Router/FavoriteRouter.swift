//
//  FavoriteRouter.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 10/12/20.
//
import SwiftUI
import Core
import Movie

class FavoriteRouter {
  func makeDetailView(for movie: MovieModel) -> some View {
    let useCase: Interactor<
      String,
      MovieModel,
      GetMovieRepository<
        GetMovieLocaleDataSource,
        GetMovieRemoteDataSource,
        MovieTransformer>
    > = Injection.init().provideMovie()
    
    let creditUseCase: Interactor<
      String,
      MovieCreditModel,
      GetMovieCreditRepository<
        GetMovieCreditLocaleDataSource,
        GetMovieCreditRemoteDataSource,
        MovieCreditTransformer>
    > = Injection.init().provideMovieCredit()
    
    let favoriteUseCase: Interactor<
      String,
      MovieModel,
      UpdateFavoriteMovieRepository<
        GetFavoriteMoviesLocaleDataSource,
        MovieTransformer>
    > = Injection.init().provideUpdateFavorite()
    
    let presenter = MoviePresenter(movieUseCase: useCase, movieCreditUseCase: creditUseCase, favoriteUseCase: favoriteUseCase)
    return DetailView(presenter: presenter, movie: movie)
    
  }
}

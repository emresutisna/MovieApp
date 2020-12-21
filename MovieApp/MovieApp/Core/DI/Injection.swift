//
//  Injection.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//
import UIKit
import Core
import Movie

final class Injection: NSObject {
  func provideNowPLayingMovies<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetNowPlayingMoviesLocaleDataSource(realm: appDelegate.realm)
    
    let remote = GetMoviesRemoteDataSource(endpoint: Endpoints.Gets.nowplaying.url)
    
    let movieMapper = MovieTransformer()
    let mapper = MoviesTransformer(movieMapper: movieMapper)
    
    let repository = GetMoviesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)    
    return Interactor(repository: repository) as! U
  }

  func providePopularMovies<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetPopularMoviesLocaleDataSource(realm: appDelegate.realm)
    
    let remote = GetMoviesRemoteDataSource(endpoint: Endpoints.Gets.popular.url)
    
    let movieMapper = MovieTransformer()
    let mapper = MoviesTransformer(movieMapper: movieMapper)
    
    let repository = GetMoviesRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let remote = SearchMoviesRemoteDataSource(endpoint: Endpoints.Gets.search.url)

    let movieMapper = MovieTransformer()
    let mapper = MoviesTransformer(movieMapper: movieMapper)
    
    let repository = SearchMoviesRepository(
      remoteDataSource: remote,
      mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideMovie<U: UseCase>() -> U where U.Request == String, U.Response == MovieModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetMovieLocaleDataSource(realm: appDelegate.realm)
    
    let remote = GetMovieRemoteDataSource(endpoint: Endpoints.Gets.moviebase.url, apikey: API.apiKey)
    
    let mapper = MovieTransformer()
    
    let repository = GetMovieRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideMovieCredit<U: UseCase>() -> U where U.Request == String, U.Response == MovieCreditModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetMovieCreditLocaleDataSource(realm: appDelegate.realm)
    
    let remote = GetMovieCreditRemoteDataSource(endpoint: Endpoints.Gets.moviebase.url, apikey: API.apiKey)
    
    let mapper = MovieCreditTransformer()
    
    let repository = GetMovieCreditRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideUpdateFavorite<U: UseCase>() -> U where U.Request == String, U.Response == MovieModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetFavoriteMoviesLocaleDataSource(realm: appDelegate.realm)
    
    let mapper = MovieTransformer()
    
    let repository = UpdateFavoriteMovieRepository(
      localeDataSource: locale,
      mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideFavorite<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetFavoriteMoviesLocaleDataSource(realm: appDelegate.realm)
    
    let movieMapper = MovieTransformer()
    let mapper = MoviesTransformer(movieMapper: movieMapper)
    
    let repository = GetFavoriteMoviesRepository(
      localeDataSource: locale,
      mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
}

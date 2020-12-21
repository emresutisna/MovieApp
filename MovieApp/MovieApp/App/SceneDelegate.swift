//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Movie

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    let injection = Injection()
    
    let favoriteUseCase: Interactor<
      String,
      [MovieModel],
      GetFavoriteMoviesRepository<
        GetFavoriteMoviesLocaleDataSource,
        MoviesTransformer<MovieTransformer>>
    > = injection.provideFavorite()
    
    let searchUseCase: Interactor<
      String,
      [MovieModel],
      SearchMoviesRepository<
        SearchMoviesRemoteDataSource,
        MoviesTransformer<MovieTransformer>>
    > = injection.provideSearch()

    let popularMoviesUseCase: Interactor<
      String,
      [MovieModel],
      GetMoviesRepository<
        GetPopularMoviesLocaleDataSource,
        GetMoviesRemoteDataSource,
        MoviesTransformer<MovieTransformer>>
    > = injection.providePopularMovies()

    let nowPlayingMoviesUseCase: Interactor<
      String,
      [MovieModel],
      GetMoviesRepository<
        GetNowPlayingMoviesLocaleDataSource,
        GetMoviesRemoteDataSource,
        MoviesTransformer<MovieTransformer>>
    > = injection.provideNowPLayingMovies()
    
    let popularPresenter = GetListPresenter(useCase: popularMoviesUseCase)
    let nowPlayingPresenter = GetListPresenter(useCase: nowPlayingMoviesUseCase)
    let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
    let searchPresenter = SearchPresenter(useCase: searchUseCase)
    
    let contentView = ContentView()
      .environmentObject(popularPresenter)
      .environmentObject(nowPlayingPresenter)
      .environmentObject(favoritePresenter)
      .environmentObject(searchPresenter)
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
}

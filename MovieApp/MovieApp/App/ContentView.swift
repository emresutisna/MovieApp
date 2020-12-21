//
//  ContentView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import SwiftUI
import Core
import Movie

struct ContentView: View {
  @EnvironmentObject var popularPresenter: GetListPresenter<String, MovieModel, Interactor<String, [MovieModel], GetMoviesRepository<GetPopularMoviesLocaleDataSource, GetMoviesRemoteDataSource, MoviesTransformer<MovieTransformer>>>>
  
  @EnvironmentObject var nowPlayingPresenter: GetListPresenter<String, MovieModel, Interactor<String, [MovieModel], GetMoviesRepository<GetNowPlayingMoviesLocaleDataSource, GetMoviesRemoteDataSource, MoviesTransformer<MovieTransformer>>>>
  @EnvironmentObject var favoritePresenter: GetListPresenter<String, MovieModel, Interactor<String, [MovieModel], GetFavoriteMoviesRepository<GetFavoriteMoviesLocaleDataSource, MoviesTransformer<MovieTransformer>>>>
  
  @EnvironmentObject var searchPresenter: SearchPresenter<MovieModel, Interactor<String, [MovieModel], SearchMoviesRepository<SearchMoviesRemoteDataSource, MoviesTransformer<MovieTransformer>>>>
  @State var current = "Movies"
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
      TabView(selection: $current) {
        NavigationView {
          HomeView(
            popularPresenter: self.popularPresenter,
            nowPlayingPresenter: self.nowPlayingPresenter,
            searchPresenter: self.searchPresenter
          )
        }.tag("Movies")
        
        NavigationView {
          FavoriteView(
            presenter: self.favoritePresenter
          )
        }
        .tag("Favorites")
        ProfileView()
          .tag("Profile")
      }
      
      HStack(spacing: 0) {
        TabButton(title: "Movies", image: "film", selected: $current)
        Spacer(minLength: 0)
        TabButton(title: "Favorites", image: "suit.heart.fill", selected: $current)
        Spacer(minLength: 0)
        TabButton(title: "Profile", image: "person.fill", selected: $current)
      }
      .padding(.vertical, 5)
      .padding(.horizontal)
      .background(Color(hex: "#303952").opacity(0.85))
      .clipShape(Capsule())
      .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.85), radius: 5, x: 5, y: 5)
      .padding(.horizontal, 25)
      .padding(.vertical, 10)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

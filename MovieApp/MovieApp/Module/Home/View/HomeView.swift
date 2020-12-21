//
//  HomeView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import SwiftUI
import Movie
import Core
import SDWebImageSwiftUI

struct HomeView: View {
  @ObservedObject var popularPresenter: GetListPresenter<String, MovieModel, Interactor<String, [MovieModel], GetMoviesRepository<GetPopularMoviesLocaleDataSource, GetMoviesRemoteDataSource, MoviesTransformer<MovieTransformer>>>>
  
  @ObservedObject var nowPlayingPresenter: GetListPresenter<String, MovieModel, Interactor<String, [MovieModel], GetMoviesRepository<GetNowPlayingMoviesLocaleDataSource, GetMoviesRemoteDataSource, MoviesTransformer<MovieTransformer>>>>
  
  @ObservedObject var searchPresenter: SearchPresenter<MovieModel, Interactor<String, [MovieModel], SearchMoviesRepository<SearchMoviesRemoteDataSource, MoviesTransformer<MovieTransformer>>>>
  
  @State var search = ""
  @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
  @State var index = 0
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    VStack {
      ZStack {
        if popularPresenter.isLoading || nowPlayingPresenter.isLoading {
          loadingIndicator
        } else {
          VStack {
            Image("tmdb")
              .resizable()
              .frame(width: 120, height: 35, alignment: .center)
              .padding(.top, 20)
            SearchBar(
              text: $searchPresenter.keyword
            )
            if searchPresenter.isLoading {
              loadingIndicator
            }
            if !searchPresenter.keyword.isEmpty && !searchPresenter.list.isEmpty {
              ScrollView {
                ForEach(searchPresenter.list) { movie in
                  linkBuilder(for: movie) {
                    VStack {
                      HStack {
                        if movie.posterPath == "" {
                          Image("noimage")
                            .resizable()
                            .frame(width: 35, height: 50)
                            .aspectRatio(contentMode: .fill)
                        } else {
                          WebImage(url: movie.posterURL)
                            .resizable()
                            .frame(width: 35, height: 50)
                            .aspectRatio(contentMode: .fill)
                        }
                        VStack(alignment: .leading) {
                          Text("\(movie.title)")
                          Text("\(movie.yearText)")
                        }
                        Spacer(minLength: 0)
                        Image(systemName: "chevron.right.circle.fill")
                      }
                      .font(.system(size: 14))
                      .foregroundColor(colorScheme == .dark ? Color.white : Color(hex: "#222f3e"))
                      .padding(.horizontal, 10)
                      .padding(.vertical, 5)
                      .padding(.horizontal, 10)
                      Divider()
                    }
                  }
                }
              }
            } else if !searchPresenter.keyword.isEmpty && searchPresenter.list.isEmpty && searchPresenter.isSearchRun && !searchPresenter.isLoading {
              Text("no_movies_text".localized(identifier: "com.cilegondev.MovieApp"))
            }
            ScrollView {
              LazyVStack {
                ScrollView(.horizontal, showsIndicators: false) {
                  HStack(alignment: .center, spacing: 10) {
                    ForEach(self.nowPlayingPresenter.list) {movie in
                      linkBuilder(for: movie) {
                        MovieCardView(movie: movie)
                      }
                    }
                  }
                  .padding(.horizontal, 10)
                  .padding(.vertical, 5)
                }
                
                HStack {
                  Text("popular_text".localized(identifier: "com.cilegondev.MovieApp"))
                    .font(.title)
                    .fontWeight(.bold)
                  
                  Spacer()
                  Button {
                    withAnimation(.easeOut) {
                      if self.columns.count == 2 {
                        self.columns.removeLast()
                      } else {
                        self.columns.append(GridItem(.flexible(), spacing: 15))
                      }
                    }
                    
                  } label: {
                    Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                      .font(.system(size: 24))
                  }
                }
                .padding(.horizontal)
                .padding(.top, 25)
                
                LazyVGrid(columns: self.columns, spacing: 25) {
                  ForEach(self.popularPresenter.list) {movie in
                    if self.columns.count == 2 {
                      linkBuilder(for: movie) {
                        MovieGridView(movie: movie)
                      }
                    } else {
                      linkBuilder(for: movie) {
                        MovieCardView(movie: movie)
                      }
                    }
                  }
                }
                .padding([.horizontal, .top])
                Spacer(minLength: 50)
              }
            }
          }
        }
      }
    }
    .onAppear {
      self.searchPresenter.startObserve()
      if self.popularPresenter.list.count == 0 || self.nowPlayingPresenter.list.count == 0 {
        self.popularPresenter.getList(request: "")
        self.nowPlayingPresenter.getList(request: "")
      }
    }
    .navigationBarHidden(true)
  }
}

extension HomeView {
  var loadingIndicator: some View {
    VStack {
      Text("loading_text".localized(identifier: "com.cilegondev.MovieApp"))
      ActivityIndicator()
    }
  }
  
  func linkBuilder<Content: View>(
    for movie: MovieModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: HomeRouter().makeDetailView(for: movie)
    ) { content() }
  }
}

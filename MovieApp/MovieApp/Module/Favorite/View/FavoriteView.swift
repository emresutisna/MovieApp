//
//  FavoriteView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 08/12/20.
//

import SwiftUI
import Movie
import Core

struct FavoriteView: View {
  @ObservedObject var presenter: GetListPresenter<String, MovieModel, Interactor<String, [MovieModel], GetFavoriteMoviesRepository<GetFavoriteMoviesLocaleDataSource, MoviesTransformer<MovieTransformer>>>>
  
  @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
  @State var index = 0
  @State var showingDetail = false
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else {
        ScrollView {
          LazyVStack {
            HStack {
              Text("favorite_text".localized(identifier: "com.cilegondev.MovieApp"))
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
            
            if self.presenter.list.isEmpty {
              CustomEmptyView(
                image: "heart.slash.fill",
                title: "no_favorite_text".localized(identifier: "com.cilegondev.MovieApp"),
                systemImage: true,
                color: .red
              ).padding(.top, 50)
            }
            LazyVGrid(columns: self.columns, spacing: 25) {
              ForEach(self.presenter.list) {movie in
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
    }.onAppear {
      self.presenter.getList(request: "")
    }
    .navigationBarHidden(true)
    .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
  }
}

extension FavoriteView {
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  func linkBuilder<Content: View>(
    for movie: MovieModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: FavoriteRouter().makeDetailView(for: movie)
    ) { content() }
  }
}

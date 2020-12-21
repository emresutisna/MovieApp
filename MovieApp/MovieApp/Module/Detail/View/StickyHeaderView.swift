//
//  StickyHeaderView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 08/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie
import Core

struct StickyHeaderView: View {
  @ObservedObject var presenter: MoviePresenter<
    Interactor<String, MovieModel, GetMovieRepository<GetMovieLocaleDataSource, GetMovieRemoteDataSource, MovieTransformer>>,
    Interactor<String, MovieCreditModel, GetMovieCreditRepository<GetMovieCreditLocaleDataSource, GetMovieCreditRemoteDataSource, MovieCreditTransformer>>,
    Interactor<String, MovieModel, UpdateFavoriteMovieRepository<GetFavoriteMoviesLocaleDataSource, MovieTransformer>>
  >
  let movie: MovieModel
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 12) {
        HStack(alignment: .center) {
          Button(
            action: {
              self.mode.wrappedValue.dismiss()
            },
            label: {
              Image(systemName: "chevron.left")
                .font(.system(size: 20))
                .foregroundColor(.black).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            })
          WebImage(url: self.movie.backdropURL)
            .renderingMode(.original)
            .resizable()
            .frame(width: 50, height: 40)
            .foregroundColor(.primary)
            .cornerRadius(5)
          VStack(alignment: .leading) {
            Text(self.movie.title)
              .font(.system(size: 14))
              .fontWeight(.bold)
            Text(self.movie.releaseDate ?? "-")
              .font(.system(size: 12))
              .foregroundColor(.gray)
          }
        }
      }
      
      Spacer(minLength: 0)
      
      Button(
        action: {
          self.presenter.updateFavoriteMovie(request: String(movie.id))
        },
        label: {
          if self.movie.isFavorite {
            Image(systemName: "suit.heart.fill")
              .font(.system(size: 30))
              .foregroundColor(.red)
          } else {
            Image(systemName: "suit.heart")
              .font(.system(size: 30))
              .foregroundColor(.red)
          }
        })
    }
    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
    .padding(.horizontal)
    .padding(.bottom)
    .background(BlurBG())
  }
}

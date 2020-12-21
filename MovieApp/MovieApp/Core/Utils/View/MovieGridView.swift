//
//  MovieGridView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 08/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie

struct MovieGridView: View {
  let movie: MovieModel
  var body: some View {
    VStack(spacing: 15) {
      ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
        WebImage(url: movie.posterURL)
          .resizable()
          .indicator(.activity)
          .transition(.fade(duration: 0.5))
          .frame(height: 250)
          .cornerRadius(15)
        Text("\(movie.voteAverage, specifier: "%.1f")")
          .font(.system(size: 14))
          .padding(5)
          .background(movie.voteAverage > 7.0 ? Color.green : movie.voteAverage > 6.0 ? Color.orange : Color.red)
          .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
          .foregroundColor(.white)
          .padding(.all, 10)
      }
    }
  }
}

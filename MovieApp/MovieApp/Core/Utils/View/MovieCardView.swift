//
//  PopularMovieCard.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie

struct MovieCardView: View {
  let movie: MovieModel
  
  var body: some View {
    VStack(alignment: .leading) {
      WebImage(url: movie.backdropURL)
        .resizable()
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .frame(width: UIScreen.main.bounds.width - 32, height: 180)
      
      ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
        Text("\(movie.voteAverage, specifier: "%.1f")")
          .font(.system(size: 18))
          .padding(10)
          .background(movie.voteAverage > 7.0 ? Color.green : movie.voteAverage > 6.0 ? Color.orange : Color.red)
          .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
          .foregroundColor(.white)
          .offset(x: 10, y: -30)
        VStack(alignment: .leading) {
          Text(movie.title)
            .font(.system(size: 15))
          Text(movie.releaseDate ?? "")
            .font(.system(size: 12))
            .padding(.bottom)
        }.padding()
      }
    }
    .background(Color.white)
    .foregroundColor(.black)
    .cornerRadius(15)
    .shadow(color: .black, radius: 3, x: 3, y: 3)
  }
}

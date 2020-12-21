//
//  DetailView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Movie
import Core

struct DetailView: View {
  @ObservedObject var presenter: MoviePresenter<
    Interactor<String, MovieModel, GetMovieRepository<GetMovieLocaleDataSource, GetMovieRemoteDataSource, MovieTransformer>>,
    Interactor<String, MovieCreditModel, GetMovieCreditRepository<GetMovieCreditLocaleDataSource, GetMovieCreditRemoteDataSource, MovieCreditTransformer>>,
    Interactor<String, MovieModel, UpdateFavoriteMovieRepository<GetFavoriteMoviesLocaleDataSource, MovieTransformer>>
  >
  let movie: MovieModel
  
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
  @State var show = false
  
  var body: some View {
    ZStack(alignment: .top) {
      if presenter.isLoading {
        loadingIndicator
      } else {
        ScrollView(.vertical, showsIndicators: false) {
          ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            GeometryReader { g in
              imageMovie
                .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.5 + g.frame(in: .global).minY : UIScreen.main.bounds.height / 2.5)
                .onReceive(self.time) { (_) in
                  let y = g.frame(in: .global).minY
                  if -y > (UIScreen.main.bounds.height / 2.5) - 50 {
                    withAnimation {
                      self.show = true
                    }
                  } else {
                    withAnimation {
                      self.show = false
                    }
                  }
                }
              
            }
            .frame(height: UIScreen.main.bounds.height / 2.5)
            
            HStack(alignment: .center, spacing: 10) {
              posterImageMovie
              VStack(alignment: .leading) {
                if self.presenter.item != nil {
                  Text("\(self.presenter.item!.title) - \(self.presenter.item!.yearText)")
                    .padding(.top, 40)
                    .padding(.trailing, 10)
                    .font(.system(size: 18))
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                  Text(self.presenter.item!.durationText)
                    .font(.system(size: 12))
                }
                rating
              }
            }
            .offset(x: 20, y: UIScreen.main.bounds.height / 2.5 - 40)
            
          }
          VStack {
            spacer
            genres
            content
            spacer
          }
        }
      }
      if self.show {
        if self.presenter.item != nil {
          StickyHeaderView(presenter: presenter, movie: self.presenter.item!)
        }
      }
    }
    .onAppear {
      self.presenter.getMovie(request: String(self.movie.id))
      self.presenter.getMovieCredit(request: String(self.movie.id))
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .edgesIgnoringSafeArea(.top)
  }
}

extension DetailView {
  var spacer: some View {
    Spacer(minLength: 30)
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("loading_text".localized(identifier: "com.cilegondev.MovieApp"))
      ActivityIndicator()
    }
  }
  
  var imageMovie: some View {
    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
      if self.presenter.item?.backdropPath == "" {
        Image("noimage")
          .resizable()
      } else {
        WebImage(url: self.presenter.item?.backdropURL)
          .resizable()
          .indicator(.activity)
          .transition(.fade(duration: 0.5))
      }
      HStack {
        Button(
          action: {
            self.mode.wrappedValue.dismiss()
          },
          label: {
            Image(systemName: "chevron.left.circle.fill")
              .font(.system(size: 30))
              .foregroundColor(.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
          })
        Spacer()
        Button(
          action: {
            self.presenter.updateFavoriteMovie(request: String(movie.id))
          },
          label: {
            if self.presenter.item != nil {
              if self.presenter.item!.isFavorite == true {
                Image(systemName: "heart.fill")
                  .font(.system(size: 25))
                  .foregroundColor(.red)
                  .padding(5)
                  .background(Color.white)
                  .clipShape(Circle())
              } else {
                Image(systemName: "heart")
                  .font(.system(size: 25))
                  .foregroundColor(.red)
                  .padding(5)
                  .background(Color.white)
                  .clipShape(Circle())
              }
            }
          })
      }
      .padding([.leading, .trailing])
      .offset(x: 0, y: 20)
    }
  }
  
  var posterImageMovie: some View {
    WebImage(url: self.presenter.item?.posterURL)
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .frame(width: 80, height: 120)
      .aspectRatio(contentMode: .fit)
      .cornerRadius(5)
      .padding(3)
      .background(Color.white)
      .cornerRadius(5)
  }
  
  var overview: some View {
    Text(self.presenter.item?.overview ?? "")
      .font(.system(size: 15))
  }
  
  var genres: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 10) {
        ForEach(self.presenter.item?.genresText ?? [], id: \.self) { genre in
          Text(genre)
            .padding(5)
            .padding(.horizontal, 15)
            .foregroundColor(.white)
            .background(Color.random)
            .clipShape(Capsule())
        }
      }
      .padding(.horizontal, 20)
    }
    .padding(.top, 70)
  }
  
  var casts: some View {
    VStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 15) {
          if self.presenter.credit != nil {
            ForEach(0..<self.presenter.credit!.cast.count, id: \.self) { index in
              VStack(alignment: .center) {
                if self.presenter.credit!.cast[index].profilePath == "" {
                  Image("noimage")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } else {
                  WebImage(url: self.presenter.credit!.cast[index].profileURL)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                Text(self.presenter.credit!.cast[index].name)
                  .frame(width: 100)
                  .fixedSize(horizontal: false, vertical: true)
                  .font(.system(size: 12))
              }
            }
            
          }
        }
      }
    }
  }
  
  var crews: some View {
    VStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 15) {
          if self.presenter.credit != nil {
            ForEach(0..<self.presenter.credit!.crew.count, id: \.self) { index in
              VStack(alignment: .center) {
                if self.presenter.credit!.crew[index].profilePath == "" {
                  Image("noimage")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } else {
                  WebImage(url: self.presenter.credit!.crew[index].profileURL)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                Text(self.presenter.credit!.crew[index].name)
                  .frame(width: 100)
                  .fixedSize(horizontal: false, vertical: true)
                  .font(.system(size: 10))
              }
            }
            
          }
        }
      }
    }
  }
  
  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }
  
  var rating: some View {
    HStack(spacing: 10) {
      ForEach(1...5, id: \.self) { rating in
        Image(systemName: "star.fill")
          .foregroundColor(Int(self.presenter.item?.voteAverage ?? 0) / 2 >= rating ? .yellow : .gray)
          .font(.system(size: 12))
      }
      Spacer(minLength: 0)
    }
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      headerTitle("overview_text".localized(identifier: "com.cilegondev.MovieApp"))
        .padding([.top, .bottom])
      overview
      if self.presenter.credit != nil {
        if self.presenter.credit!.cast.count > 0 {
          headerTitle("casts_text".localized(identifier: "com.cilegondev.MovieApp"))
            .padding([.top, .bottom])
          casts
        }
        if self.presenter.credit!.crew.count > 0 {
          headerTitle("crews_text".localized(identifier: "com.cilegondev.MovieApp"))
            .padding([.top, .bottom])
          crews
        }
      }
    }
    .padding()
  }
}

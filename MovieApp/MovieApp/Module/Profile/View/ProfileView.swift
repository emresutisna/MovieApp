//
//  ProfileView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 08/12/20.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
      VStack(spacing: 20) {
        HStack(spacing: 15) {
          Image("profile_photo")
            .resizable()
            .frame(width: 80, height: 80, alignment: .center)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .padding(2)
            .background(Color.blue)
            .clipShape(Circle())
          
          VStack(alignment: .leading, spacing: 10) {
            Text("Nanang Sutisna")
            Text("emresutisna@gmail.com")
              .font(.system(size: 15))
          }
          
          Spacer()
        }
        
        HStack(spacing: 15) {
          HStack {
            VStack(alignment: .leading) {
              Text("followers_text".localized(identifier: "com.cilegondev.MovieApp"))
                .fontWeight(.bold)
              Text("10K").fontWeight(.bold).font(.system(size: 22))
            }
            Spacer(minLength: 0)
            
          }.padding()
          .frame(width: (UIScreen.main.bounds.width - 45) / 2)
          .background(Color.blue)
          .cornerRadius(15)
          
          HStack {
            VStack(alignment: .leading) {
              Text("following_text".localized(identifier: "com.cilegondev.MovieApp"))
                .fontWeight(.bold)
              Text("512").fontWeight(.bold).font(.system(size: 22))
            }
            
            Spacer(minLength: 0)
            
          }.padding()
          .frame(width: (UIScreen.main.bounds.width - 45) / 2)
          .background(Color.pink)
          .cornerRadius(15)
          
        }.foregroundColor(.white)
        .padding(.top)
        
        HStack(spacing: 15) {
          Image(systemName: "map")
            .renderingMode(.original)
            .padding()
            .background(Color(.white))
            .clipShape(Circle())
          Text("Cilegon")
          Spacer()
        }.padding(10)
        .background(Color(hex: "#dff9fb"))
        .foregroundColor(.black)
        .cornerRadius(15)
        
        HStack(spacing: 15) {
          Image(systemName: "globe")
            .renderingMode(.original)
            .padding()
            .background(Color(.white))
            .clipShape(Circle())
          Text("Bahasa Indonesia")
          Spacer()
        }.padding(10)
        .background(Color(hex: "#dff9fb"))
        .foregroundColor(.black)
        .cornerRadius(15)
      }
      Spacer(minLength: 30)
    }
    .padding()
    .padding(.top, 30)
    .navigationBarHidden(true)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

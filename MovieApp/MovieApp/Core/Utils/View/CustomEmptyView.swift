//
//  CustomEmptyView.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 10/12/20.
//

import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String
  var systemImage: Bool = false
  var color: Color = .black
  
  var body: some View {
    VStack {
      if systemImage == true {
        Image(systemName: image)
          .resizable()
          .scaledToFit()
          .frame(width: 250)
          .foregroundColor(color)
      } else {
        Image(image)
          .resizable()
          .renderingMode(.original)
          .scaledToFit()
          .frame(width: 250)
      }
      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}

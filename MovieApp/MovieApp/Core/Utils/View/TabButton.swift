//
//  TabButton.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 10/12/20.
//

import SwiftUI

struct TabButton: View {
  var title: String
  var image: String
  @Binding var selected: String
  
  var body: some View {
    Button(
      action: {
        withAnimation(.spring()) { selected = title}
      },
      label: {
        HStack(spacing: 10) {
          
          Image(systemName: image)
            .resizable()
            .renderingMode(.template)
            .frame(width: 25, height: 20)
            .foregroundColor(.white)
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 10)
        .background(Color.white.opacity(selected == title ? 0.08 : 0))
        .clipShape(Capsule())
      })
  }
}

//
//  ActivityIndicator.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 07/12/20.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  
  func makeUIView(
    context: UIViewRepresentableContext<ActivityIndicator>
  ) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: .large)
  }
  
  func updateUIView(
    _ uiView: UIActivityIndicatorView,
    context: UIViewRepresentableContext<ActivityIndicator>
  ) {
    uiView.startAnimating()
  }
  
}

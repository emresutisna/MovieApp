//
//  BlurBG.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 08/12/20.
//

import SwiftUI

struct BlurBG: UIViewRepresentable {
  func makeUIView(context: Context) -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    return view
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
  }
}

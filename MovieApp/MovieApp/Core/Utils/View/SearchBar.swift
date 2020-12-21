//
//  SearchBar.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 10/12/20.
//
import SwiftUI

struct SearchBar: UIViewRepresentable {
  @Binding var text: String
  
  class Coordinator: NSObject, UISearchBarDelegate {
    
    let control: SearchBar
    
    init(_ control: SearchBar) {
      self.control = control
    }
    
    func searchBar(
      _ searchBar: UISearchBar,
      textDidChange searchText: String
    ) {
      control.text = searchText
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func makeUIView(
    context: UIViewRepresentableContext<SearchBar>
  ) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.placeholder = "search_text".localized(identifier: "com.cilegondev.MovieApp")
    searchBar.searchBarStyle = .minimal
    searchBar.delegate = context.coordinator
    return searchBar
  }
  
  func updateUIView(
    _ uiView: UISearchBar,
    context: UIViewRepresentableContext<SearchBar>
  ) {
    uiView.text = text
  }
  
}

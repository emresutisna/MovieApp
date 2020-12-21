//
//  String+Localization.swift
//  MovieApp
//
//  Created by Nanang Sutisna on 21/12/20.
//

import Foundation

extension String {
  public func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}

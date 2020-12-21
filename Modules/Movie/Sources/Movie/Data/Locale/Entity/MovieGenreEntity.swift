//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 15/12/20.
//

import Foundation
import RealmSwift

public class MovieGenreEntity: Object {
    @objc dynamic var name: String = ""
    let ofMovieEntity = LinkingObjects(fromType: MovieEntity.self, property: "genres")
    
    public convenience init(_ name: String) {
        self.init()
        self.name = name
    }
}


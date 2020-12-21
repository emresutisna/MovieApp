//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 15/12/20.
//

import Foundation
import RealmSwift

public class MovieCreditEntity: Object {
    @objc dynamic var id: Int = 0
    let cast = List<MovieCastEntity>()
    let crew = List<MovieCrewEntity>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}


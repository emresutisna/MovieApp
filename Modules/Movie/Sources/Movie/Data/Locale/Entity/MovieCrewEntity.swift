//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 15/12/20.
//

import Foundation
import RealmSwift

public class MovieCrewEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var job: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var profilePath: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    public convenience init(_ id: Int, _ job: String, _ name: String, _ profilePath: String) {
        self.init()
        self.id = id
        self.job = job
        self.name = name
        self.profilePath = profilePath
    }
}


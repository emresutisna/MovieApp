//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 15/12/20.
//
import Foundation
import RealmSwift

public class MovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var runtime: Int = 0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var isNowPlaying: Bool = false
    @objc dynamic var isPopular: Bool = false
    @objc dynamic var isFavorite: Bool = false
    
    let genres = List<MovieGenreEntity>()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}

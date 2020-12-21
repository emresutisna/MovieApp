//
//  File.swift
//  
//
//  Created by Nanang Sutisna on 18/12/20.
//

import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}


//
//  Tweet.swift
//  AdLudum
//
//  Created by Diogo Muller on 06/01/19.
//  Copyright © 2019 Diogo Muller. All rights reserved.
//

import Foundation

struct Tweet : Codable {
    var id : UInt64
    var text : String?
    var entities : Entities?
    var user : User?
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: Coding Keys
    //////////////////////////////////////////////////////////////////////////////////////////////////
    enum CodingKeys : String, CodingKey {
        case id
        case text = "full_text"
        case entities
        case user
    }
}

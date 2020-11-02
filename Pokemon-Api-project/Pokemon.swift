//
//  Pokemon.swift
//  Pokemon-Api-project
//
//  Created by Field Employee on 10/30/20.
//

import Foundation
import UIKit

struct Pokemon : Codable {
    //var name: String
    var count: Int
    var next: String
    var results: [result]
}

struct result : Codable, Equatable {
    var name: String
    var url: String
}

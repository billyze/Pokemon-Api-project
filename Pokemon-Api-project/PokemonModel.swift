//
//  PokemonModel.swift
//  Pokemon-Api-project
//
//  Created by Field Employee on 10/30/20.
//

import Foundation

struct PokemonModel : Codable {
    var weight : Int
    var sprites : spriteStruct
    var forms : [nameStruct]
    var types : [typeStruct]
    var abilities : [abilityStruct]
    var moves : [moveStruct]
}

struct nameStruct : Codable {
    var name : String
    var url : String
}

struct spriteStruct : Codable {
    var front_default : String
}

struct typeStruct : Codable {
    var slot : Int
    var type : nameStruct
}

struct abilityStruct : Codable {
    var ability : nameStruct
    var is_hidden : Bool
}

struct moveStruct : Codable {
    var move : nameStruct
}

//
//  NetworkManager.swift
//  Pokemon-Api-project
//
//  Created by Field Employee on 10/30/20.
//

import UIKit

final class NetworkManager {
    static var shared = NetworkManager()
    var pokemonReturn = [PokemonModel?]()
    var pokeSpot: PokemonModel?
    let session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager {
    
    func getPokemonCodable(url1: String, completion: @escaping ([PokemonModel?]?, String?) -> ()){
        guard let url = URL(string: url1) else {return}
        var nextUrl:String = ""
        let group = DispatchGroup()
        session.dataTask(with: url) { (data, response, error) in
            do {
                let x = try JSONDecoder().decode(Pokemon.self, from: data!)
                nextUrl = x.next
                x.results.forEach{
                    let index = x.results.firstIndex(of: $0)
                    group.enter()
                    self.getPokemonModel(urlSource: $0.url) { (pokeModel) in
                        while(self.pokemonReturn.count <= index!){
                            self.pokemonReturn.append(self.pokeSpot)
                        }
                        self.pokemonReturn[index!] = pokeModel
                        if ((pokeModel) != nil) {group.leave()}
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
            group.notify(queue: .main){
                completion(self.pokemonReturn, nextUrl)
            }
        }.resume()
        return
    }
    
    func getPokemonModel(urlSource: String, completion: @escaping (PokemonModel?) -> ()) -> () {
        var model: PokemonModel?
        guard let url = URL(string: urlSource) else {return}
        session.dataTask(with: url) { (data, response, error) in
            do{
                model = try JSONDecoder().decode(PokemonModel.self, from: data!)
            } catch let error{
                print(error.localizedDescription)
            }
            completion(model)
        }.resume()
    }
}

//    func getPokemonModel(urlSource: Pokemon?, completion: @escaping (PokemonModel?) -> ()) -> () {
//        var model: PokemonModel?
//        var count: Int = 0
//        (urlSource?.results.map({(result) -> PokemonModel? in
//            guard let url = URL(string: result.url) else {return model}
//            session.dataTask(with: url) { (data,  response, error) in
//                do{
//                    model = try JSONDecoder().decode(PokemonModel.self, from: data!)
//                    self.pokemonReturn[count] = model
//                    count = count + 1
//                    //print(self.pokemonReturn)
//                    //print(model!.types[0].type.name)
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }.resume()
//            return model
//        }))!
//        //urlSource.results.map({})
//        return
//    }

//    func getPokemonCodable(completion: @escaping ([PokemonModel?]?) -> ()){
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=0&limit=30") else {return}
//        session.dataTask(with: url) { (data, response, error) in
//            do {
//                let x = try JSONDecoder().decode(Pokemon.self, from: data!)
//                self.pokemonReturn = self.getPokemonModel(urlSource: x)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//            completion(self.pokemonReturn)
//        }.resume()
//        return
//    }
//
//    func getPokemonModel(urlSource: Pokemon?) -> [PokemonModel?] {
//        var modelArray: [PokemonModel?]
//        var model: PokemonModel?
//        var count: Int = 0
//        modelArray = (urlSource?.results.map({(result) -> PokemonModel? in
//            guard let url = URL(string: result.url) else {return model}
//            session.dataTask(with: url) { (data,  response, error) in
//                do{
//                    model = try JSONDecoder().decode(PokemonModel.self, from: data!)
//                    self.pokemonReturn[count] = model
//                    count = count + 1
//                    //print(self.pokemonReturn)
//                    //print(model!.types[0].type.name)
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//            }.resume()
//            return model
//        }))!
//        //urlSource.results.map({})
//        return modelArray
//    }

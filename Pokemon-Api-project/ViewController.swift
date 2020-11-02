//
//  ViewController.swift
//  Pokemon-Api-project
//
//  Created by Field Employee on 10/30/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var pokeArray: [PokemonModel?] = []
    var previousCell: Int = 0
    var nextUrl: String = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=30"
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getPokemonCodable(url1: self.nextUrl){(pokemonArray,nextUrl) in
            DispatchQueue.main.async {
                self.pokeArray = pokemonArray!
                self.nextUrl = nextUrl!
                self.myTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableCell", for: indexPath) as? myTableViewCell else { return UITableViewCell() }
        cell.pokemonImage?.image = UIImage(named: "doggo.png")
        cell.pokemonName.text = "Loading"
        cell.pokemonType.text = "Loading"
        if(pokeArray.indices.contains(indexPath.row)){
            let url = URL(string: (pokeArray[indexPath.row]?.sprites.front_default)!)
            let data = try? Data(contentsOf: url!)
            cell.pokemonImage?.image = UIImage(data: data!)
            cell.pokemonName.text = pokeArray[indexPath.row]?.forms[0].name
            cell.pokemonType.text = (pokeArray[indexPath.row]?.types[0].type.name)!
            if(pokeArray[indexPath.row]!.types.indices.contains(1)) {
                cell.pokemonType.text = cell.pokemonType.text! + "/" + (pokeArray[indexPath.row]?.types[1].type.name)!
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row > previousCell){
            previousCell = indexPath.row
            if(indexPath.row%30 == 20 && indexPath.row < 120)
            {
                NetworkManager.shared.getPokemonCodable(url1: self.nextUrl){(pokemonArray,nextUrl) in
                    DispatchQueue.main.async {
                        pokemonArray?.forEach{
                            self.pokeArray.append($0)
                        }
                        self.nextUrl = nextUrl!
                        self.myTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: (pokeArray[indexPath.row]?.sprites.front_default)!)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        let name = pokeArray[indexPath.row]?.forms[0].name
        let type = pokeArray[indexPath.row]?.types[0].type.name
        //let abilities = pokeArray[indexPath.row]?.abilities
        //let moves = pokeArray[indexPath.row]?.moves
        let vc = detailViewController(details: (image: image!, pokeName: name!, pokeType: type!))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


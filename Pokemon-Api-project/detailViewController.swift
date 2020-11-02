//
//  detailViewController.swift
//  Pokemon-Api-project
//
//  Created by Field Employee on 11/1/20.
//

import UIKit

class detailViewController: UIViewController {

    var imageView: UIImageView?
    var pokeNameLabel: UILabel?
    var pokeTypeLabel: UILabel?
    //var pokeMoves: UILabel?
    //var pokeAbilities: UILabel?
    
    var tuple: (image: UIImage, pokeName: String, pokeType: String)
    
    init(details: (image: UIImage, pokeName: String, pokeType:String)) {
        self.tuple = details
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    
    private func setUp() {
        self.view.backgroundColor = .white
        
        //Image View
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = self.tuple.image
        
        //Pokemon Name
        let pokeName = UILabel(frame: .zero)
        pokeName.translatesAutoresizingMaskIntoConstraints = false
        pokeName.contentMode = .scaleAspectFit
        pokeName.text = self.tuple.pokeName
        
        //Pokemon Type
        let pokeType = UILabel(frame: .zero)
        pokeType.translatesAutoresizingMaskIntoConstraints = false
        pokeType.contentMode = .scaleAspectFit
        pokeType.text = self.tuple.pokeName
        
        //add to view
        self.view.addSubview(imageView)
        self.view.addSubview(pokeName)
        self.view.addSubview(pokeType)
        
        //constraints
        imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        pokeName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        pokeName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        pokeName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        
        pokeType.topAnchor.constraint(equalTo: pokeName.bottomAnchor, constant: 0).isActive = true
        pokeType.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        pokeType.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true
        
        self.imageView = imageView
        self.pokeNameLabel = pokeName
        self.pokeTypeLabel = pokeType
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

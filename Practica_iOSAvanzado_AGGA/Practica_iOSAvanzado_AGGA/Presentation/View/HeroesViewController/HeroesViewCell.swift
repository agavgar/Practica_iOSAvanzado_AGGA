//
//  HeroesViewCell.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/2/24.
//

import UIKit

class HeroesViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var nameHero: UILabel!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        heroImage.layer.borderWidth = 3
        heroImage.layer.masksToBounds = false
        heroImage.layer.borderColor = UIColor.yellow.cgColor
        heroImage.layer.cornerRadius = heroImage.frame.height/2
        heroImage.clipsToBounds = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameHero.text = nil
        heroImage.image = UIImage(systemName: "person.and.background.striped.horizontal")
    }
    
    //MARK: - Methods
    func configure(heroe: NSMHeroes) {
        guard let urlImage = heroe.photo else {
            return
        }
        heroImage.setImage(url: urlImage)
        nameHero.text = heroe.name
    }

}


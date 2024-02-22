//
//  DetailCollectionViewCell.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/2/24.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var transformImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        transformImage.layer.borderWidth = 1
        transformImage.layer.masksToBounds = false
        transformImage.layer.borderColor = UIColor.yellow.cgColor
        transformImage.layer.cornerRadius = transformImage.frame.height/2
        transformImage.clipsToBounds = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transformImage.image = UIImage(systemName: "person.and.background.striped.horizontal")
    }
    
    //MARK: - Methods
    func configure(transform: NSMTransforms) {
        guard let urlImage = transform.photo else {
            return
        }
        transformImage.setImage(url: urlImage)
    }
}

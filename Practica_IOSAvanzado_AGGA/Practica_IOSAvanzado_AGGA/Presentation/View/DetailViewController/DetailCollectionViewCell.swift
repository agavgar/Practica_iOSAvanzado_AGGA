//
//  DetailCollectionViewCell.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/2/24.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var transformImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        transformImage.image = UIImage(systemName: "person.and.background.striped.horizontal")
    }
    

    func configure(transform: NSMTransforms) {
        guard let urlImage = transform.photo else {
            return
        }
        transformImage.setImage(url: urlImage)
    }
}

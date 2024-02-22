//
//  DetailViewController.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/2/24.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroKitMap: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Models
    private var viewModel: DetailViewModel
    
    //MARK: - Init
    init(viewModel: DetailViewModel = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HeroesViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        viewModel.dataUpdated = {
            self.collectionView.reloadData()
        }
        viewModel.loadInfo()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        guard let hero = viewModel.heroe else {
            return
        }
        guard let urlImage = viewModel.heroe?.photo else {
            return
        }
        heroImage.setImage(url: urlImage)
        heroDescription.text = hero.description
        heroName.text = hero.name
        
        heroKitMap.delegate = self
        heroKitMap.mapType = .hybrid
        
        let nib = UINib(nibName: String(describing: DetailCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        
        collectionView.backgroundColor = .clear
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor(.yellow)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }


    func addAnnotations(){
        /*
        var annotations = [HeroAnnotation]()
        for location in viewModel.heroe?.location {
            annotations.append(HeroAnnotation(coordinate: ))
         
        }
         */
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbOfTransform()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let transform = viewModel.transformIn(indexPath: indexPath) else { debugPrint("Can't get the hero from HeroesCollection")
            return UICollectionViewCell()
        }
        
        cell.configure(transform: transform)
        return cell
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
}

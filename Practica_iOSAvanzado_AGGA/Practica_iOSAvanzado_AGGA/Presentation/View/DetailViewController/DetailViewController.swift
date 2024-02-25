//
//  DetailViewController.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/2/24.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController, MKMapViewDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Models
    private var viewModel: DetailViewModel
    
    //MARK: - Init
    init(viewModel: DetailViewModel = DetailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        viewModel.dataUpdated = {
            self.collectionView.reloadData()
            self.mapLocations()
        }
        viewModel.loadInfo()
        mapLocations()
    }
    
    //MARK: - UIMethod
    private func configureUI(){
        guard let hero = viewModel.heroe else {
            return
        }
        guard let urlImage = viewModel.heroe?.photo else {
            return
        }
        
        heroImage.setImage(url: urlImage)
        heroDescription.text = hero.info
        heroName.text = hero.name
        
        heroDescription.numberOfLines = 30
        heroDescription.adjustsFontSizeToFitWidth = true
        
        mapView.delegate = self
        mapView.mapType = .hybrid
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: String(describing: DetailCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        
        collectionView.backgroundColor = .clear
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor(.red)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        setRightBar(UInavItem: self.navigationItem, UInavCont: self.navigationController!)
        
    }
    
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOut))
        
        navigationItem.rightBarButtonItem?.tintColor = .yellow
        
    }
    
    @objc
    func logOut(_sender: Any) {
        viewModel.eraseAll()
        let nextVM = LoginViewModel()
        let nextVC = LoginViewController(viewModel:nextVM)
        self.navigationController?.setViewControllers([nextVC], animated: true)
    }
    //MARK: - Map Delegate and Methods
    func mapLocations(){
        mapView.addAnnotations(viewModel.annotations)
        if let annotation = mapView.annotations.first {
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = HeroAnnotationView.reuseIdentifier

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }

            annotationView!.image = UIImage(named: "locationLogo")

            return annotationView
    }
    
}

//MARK: - Collection view Delegate and DataSource
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbOfTransform()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let transform = viewModel.transformIn(indexPath: indexPath) else { debugPrint("Can't get the trandform from DetailCollection")
            return UICollectionViewCell()
        }
        
        cell.configure(transform: transform)
        return cell
    }
    
}
//MARK: - Collection View FlowLayout Delegate
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
    
}

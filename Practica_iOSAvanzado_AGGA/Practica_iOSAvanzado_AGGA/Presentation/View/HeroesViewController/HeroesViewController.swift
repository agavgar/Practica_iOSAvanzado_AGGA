//
//  HeroesViewController.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/2/24.
//

import UIKit

class HeroesViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Bindings
    private let viewModel: HeroesViewModel
    
    //MARK: - Init
    init(viewModel: HeroesViewModel = HeroesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HeroesViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Livecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModel.dataUpdated = {
            self.collectionView.reloadData()
        }
        viewModel.loadHeroes()
        
    }
    
    func configureUI() {
        
        let nib = UINib(nibName: String(describing: HeroesViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: HeroesViewCell.reuseIdentifier)
        
        collectionView.backgroundColor = .clear
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor(.yellow)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
}

extension HeroesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbOfHeroes()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesViewCell.reuseIdentifier, for: indexPath) as? HeroesViewCell else {
            return UICollectionViewCell()
        }
        
        guard let hero = viewModel.heroesIn(indexPath: indexPath) else { debugPrint("Can't get the hero from HeroesCollection")
            return UICollectionViewCell()
        }
        
        cell.configure(heroe: hero)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //debugPrint("He tocado una celda")
        
        guard let hero = viewModel.heroesIn(indexPath: indexPath) else { return }
        
        navigateVC(heroe: hero)
        
    }
    
    func navigateVC(heroe: NSMHeroes){
        let nextVM = DetailViewModel(heroe: heroe)
        let nextVC = DetailViewController(viewModel:nextVM)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 190)
    }
    
}

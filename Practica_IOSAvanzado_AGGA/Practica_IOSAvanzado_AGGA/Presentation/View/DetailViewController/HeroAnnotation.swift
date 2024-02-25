//
//  heroAnnotation.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/2/24.
//

import Foundation
import MapKit

class HeroAnnotation: NSObject, MKAnnotation {
   
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var id: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, id: String? = nil){
        self.coordinate = coordinate
        self.title = title
        self.id = id
    }
    
}

class HeroAnnotationView: MKAnnotationView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setUpUI()
        canShowCallout = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        backgroundColor = .clear
        let image = UIImage.init(named: "locationLogo")
        let view = UIImageView.init(image: image)
        addSubview(view)
    }
    
    
}

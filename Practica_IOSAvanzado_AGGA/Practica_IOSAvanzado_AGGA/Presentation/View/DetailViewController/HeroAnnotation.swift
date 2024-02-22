//
//  heroAnnotation.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/2/24.
//

import Foundation
import MapKit

final class HeroAnnotation: NSObject, MKAnnotation {
   
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var id: String?
    var date: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, id: String? = nil, date: String? = nil){
        self.coordinate = coordinate
        self.title = title
        self.id = id
        self.date = date
    }
    
}

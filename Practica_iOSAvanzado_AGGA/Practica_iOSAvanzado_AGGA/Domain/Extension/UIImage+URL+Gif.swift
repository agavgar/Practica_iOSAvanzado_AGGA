//
//  UIImage+URL.swift
//  Practica_IOSAvanzado_AGGA
//
//  Created by Alejandro Alberto Gavira García on 15/2/24.
//

import UIKit

extension UIImageView {
    
    func setImage(url:String){
        guard let urlString = URL(string: url) else { return }
        
        downloadWithURLSession(url: urlString) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
        
    }
    
    private func downloadWithURLSession(url:URL, completion: @escaping (UIImage?) -> Void){
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
        .resume()
    }
    
}

extension UIImage {
    
    class func gifImageWithData(_ data: Data) -> UIImage? {
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
                return nil
            }
            
            let frameCount = CGImageSourceGetCount(source)
            var images: [UIImage] = []
            
            for i in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    let image = UIImage(cgImage: cgImage)
                    images.append(image)
                }
            }
            
            return UIImage.animatedImage(with: images, duration: 0.0)
        }
    
}

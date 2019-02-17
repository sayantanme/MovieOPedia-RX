//
//  ImageViewExtension.swift
//  MovieOpedia
//
//  Created by Sayantan Chakraborty on 08/02/19.
//  Copyright © 2019 Sayantan Chakraborty. All rights reserved.
//

import Foundation
import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView{
    func loadImageFromImageUrlFromCache(url:String){
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage{
            self.image = cachedImage
            print("in cache")
            return
        }
        print("in download")
        let urlRequest = URLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else{
                print(error?.localizedDescription ?? "error from loadImageFromImageUrlFromCache")
                return
            }
            DispatchQueue.main.async {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: url as AnyObject)
                    self.image = downloadImage
                }
            }
        }
        task.resume()
    }
}

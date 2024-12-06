//
//  ImageDownloderManager.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import UIKit

class ImageDownloderManager {
    static let shared = ImageDownloderManager()
    private let imageCache = NSCache<NSURL, UIImage>()

    private init() {}

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
       
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.imageCache.setObject(image, forKey: url as NSURL)
            completion(image)
        }
        task.resume()
    }
}


extension UIViewController {
    func showSnackbar(message: String, duration: TimeInterval = 3.0) {
        let snackbar = UILabel()
        snackbar.text = message
        snackbar.backgroundColor = .black
        snackbar.textColor = .white
        snackbar.textAlignment = .center
        snackbar.alpha = 0
        snackbar.layer.cornerRadius = 5
        snackbar.clipsToBounds = true
        snackbar.frame = CGRect(x: 20, y: self.view.frame.height - 100, width: self.view.frame.width - 40, height: 50)
        
        self.view.addSubview(snackbar)
        
        UIView.animate(withDuration: 0.5) {
            snackbar.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 0.5, animations: {
                snackbar.alpha = 0
            }) { _ in
                snackbar.removeFromSuperview()
            }
        }
    }
}

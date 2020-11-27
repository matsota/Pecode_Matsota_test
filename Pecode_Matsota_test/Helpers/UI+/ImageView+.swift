//
//  ImageView+.swift
//  Pecode_Matsota_test
//
//  Created by Andrew Matsota on 27.11.2020.
//

import UIKit

extension UIImageView {
    
    func download(from url: URL,
                  content mode: UIView.ContentMode = .scaleAspectFit) -> URLSessionTask {
        contentMode = mode
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)  else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }
        task.resume()
        return task
    }
    
}

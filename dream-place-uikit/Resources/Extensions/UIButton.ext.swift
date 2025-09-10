//
//  UIButton.ext.swift
//  dream-place-uikit
//
//  Created by Олег Дмитриев on 10.09.2025.
//

import UIKit

extension UIButton {
    func loadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.setImage(image, for: .normal)
                self.imageView?.contentMode = .scaleAspectFill
                self.imageView?.clipsToBounds = true
            }
        }.resume()
    }
}

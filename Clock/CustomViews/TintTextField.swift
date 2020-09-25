//
//  TintTextField.swift
//  Clock
//
//  Created by Hardijs on 20/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TintTextField: UITextField {

    var tintedClearImage: UIImage?
    
    var clearButtonColor: UIColor = .white {
        didSet {
            tintClearImage()
        }
    }

    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   override func layoutSubviews() {
       super.layoutSubviews()
       self.tintClearImage()
   }

   private func tintClearImage() {
       for view in subviews {
           if view is UIButton {
               let button = view as! UIButton
               if let image = button.image(for: .highlighted) {
                   if self.tintedClearImage == nil {
                    tintedClearImage = self.tintImage(image: image, color: clearButtonColor)
                   }
                   button.setImage(self.tintedClearImage, for: .normal)
                   button.setImage(self.tintedClearImage, for: .highlighted)
               }
           }
       }
   }

   private func tintImage(image: UIImage, color: UIColor) -> UIImage {
       let size = image.size

       UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
       let context = UIGraphicsGetCurrentContext()
       image.draw(at: .zero, blendMode: CGBlendMode.normal, alpha: 1.0)

       context?.setFillColor(color.cgColor)
       context?.setBlendMode(CGBlendMode.sourceIn)
       context?.setAlpha(1.0)

       let rect = CGRect(x: CGPoint.zero.x, y: CGPoint.zero.y, width: image.size.width, height: image.size.height)
       UIGraphicsGetCurrentContext()?.fill(rect)
       let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return tintedImage ?? UIImage()
   }
}

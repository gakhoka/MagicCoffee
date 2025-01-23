//
//  QRcodeGenerator.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 23.01.25.
//

import UIKit
import CoreImage.CIFilterBuiltins

class QRcodeGenerator {
    
    func generateQRCode(from string: String) -> UIImage? {
        guard let data = string.data(using: .ascii),
              let qrFilter = CIFilter(name: "CIQRCodeGenerator"),
              let colorFilter = CIFilter(name: "CIFalseColor") else {
            return nil
        }
        
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("Q", forKey: "inputCorrectionLevel")
  
        colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(color: UIColor.darkBrown), forKey: "inputColor0")
        colorFilter.setValue(CIColor(color: .clear), forKey: "inputColor1")
        
        let transform = CGAffineTransform(scaleX: 7, y: 7)
        if let coloredQRCode = colorFilter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: coloredQRCode)
        }
        
        return nil
    }
}

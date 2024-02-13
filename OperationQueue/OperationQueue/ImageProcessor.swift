//
//  ImageProcessor.swift
//  OperationQueue
//
//  Created by Heber Alvarez on 13/02/24.
//

import UIKit

class ImageProcessor {
    static func addGaussianBlur(_ image: UIImage?) -> UIImage? {
        guard let image,
              let ciImage = CIImage(image: image) else {
            return nil
        }

        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey) // Adjust the radius as needed

        guard let outputCIImage = filter?.outputImage else {
            return nil
        }

        let context = CIContext()
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else {
            return nil
        }

        return UIImage(cgImage: outputCGImage)
    }
}

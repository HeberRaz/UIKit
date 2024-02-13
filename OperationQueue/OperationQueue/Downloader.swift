//
//  Downloader.swift
//  OperationQueue
//
//  Created by Heber Alvarez on 13/02/24.
//

import UIKit

class Downloader {
    static func downloadImage(from url: URL) -> UIImage {
        guard let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(systemName: "applelogo")!
        }
        return image
    }
}

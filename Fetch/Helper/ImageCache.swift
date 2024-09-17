//
//  ImageCache.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/17/24.
//

import Foundation
import UIKit

class ImageCache {
    
    // Singleton instance
    static let shared = ImageCache()

    // NSCache for storing images
    private var cache = NSCache<NSString, UIImage>()

    // Private initializer to ensure singleton usage
    private init() {
        cache.countLimit = 100 // Max number of images to cache
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB total cache size
    }

    // Fetch image from cache or download if not available
    func getImage(forKey key: String, url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already cached
        if let cachedImage = cache.object(forKey: key as NSString) {
            completion(cachedImage)
            return
        }

        // If the image is not in cache, download it
        downloadImage(from: url) { [weak self] image in
            guard let self = self, let image = image else {
                completion(nil)
                return
            }
            // Cache the downloaded image
            self.cache.setObject(image, forKey: key as NSString)
            completion(image)
        }
    }

    // Clear the cache if needed
    func clearCache() {
        cache.removeAllObjects()
    }

    // Download image from the URL
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}

import SwiftUI

struct CachedImageView: View {
    let imageURL: URL
    @State private var image: UIImage?
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                // Show ProgressView while the image is loading
                ProgressView()
                    .onAppear(perform: loadImage)
            } else if let image = image {
                // Show the loaded image once fetched
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }

    private func loadImage() {
        ImageCache.shared.getImage(forKey: imageURL.absoluteString, url: imageURL) { cachedImage in
            DispatchQueue.main.async {
                self.image = cachedImage
                self.isLoading = false
            }
        }
    }
}

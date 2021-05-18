//
//  RemoteImg.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//

import Foundation
import Combine
import SwiftUI

class RemoteImg: ObservableObject {
    private var subscribtion: AnyCancellable?
    @Published private(set) var image: UIImage?
    private var cache = ImageCache.shared
    
    func load(url: URL) {
        if let image: UIImage = cache[url.absoluteString] {
            self.image = image
            return
        }
        
        subscribtion = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: {
                self.cache[url.absoluteString] = $0
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        subscribtion?.cancel()
    }
    
    deinit {
        self.cancel()
    }
}

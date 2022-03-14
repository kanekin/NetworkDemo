//
//  CachedAsyncImage.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 11/03/2022.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(url: url, scale: scale, transaction: transaction) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static let sampleUrl = URL(string: "https://image.tmdb.org/t/p/w154/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")!

    static var previews: some View {
        VStack{
            CachedAsyncImage(
                url: sampleUrl
            ) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                    case .failure(let error):
                        Image(systemName: "photo")
                    @unknown default:
                        fatalError()
                }
            }
        }
        .previewLayout(.sizeThatFits)
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

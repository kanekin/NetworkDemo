//
//  TitleView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 14/03/2022.
//

import SwiftUI

struct MovieDetailsTitleView: View {
    let details: DataModel.Movie.Details?
    
    var body: some View {
        titleImage()
            .overlay {
                Text(details?.title ?? "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .background {
                        LinearGradient(gradient: Gradient(colors: Color.gradient), startPoint: .top, endPoint: .bottom)
                    }
            }
    }
    
    @ViewBuilder
    private func titleImage() -> some View {
        if let imageUrl = details?.largePosterUrl {
            CachedAsyncImage(
                url: imageUrl
            ) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 500)
                            .clipped()
                    case .failure(let error):
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                }
            }
            .frame(maxWidth: .infinity, minHeight: 500)
        } else {
            Image(systemName: "photo")
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsTitleView(details: .init(
            id: 1,
            title: "Movie title",
            overview: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            releaseDate: "12 Mar, 2022",
            originalLanguage: "Spanish",
            voteAverage: 8.6,
            posterPath: "/74xTEgt7R36Fpooo50r9T25onhq.jpg"
        ))
            .previewLayout(.sizeThatFits)
    }
}

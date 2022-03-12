//
//  MovieDetailsView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 12/03/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: DataModel.Movie.Details?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CachedAsyncImage(
                    url: movie?.largePosterUrl
                ) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 300)
                                .clipped()
                        case .failure(let error):
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 200)
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(movie?.title ?? "")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    Text(movie?.overview ?? "")
                }
                .padding()
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MovieDetailsView(movie: .init(
                id: 1,
                title: "Movie title",
                overview: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                releaseDate: "12 Mar, 2022",
                originalLanguage: "Spanish",
                voteAverage: 8.6,
                posterPath: "/74xTEgt7R36Fpooo50r9T25onhq.jpg"
            ))
        }
    }
}

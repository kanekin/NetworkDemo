//
//  MovieDetailsView.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 12/03/2022.
//

import SwiftUI

struct MovieDetailsView: View {
    let details: DataModel.Movie.Details?
    @Binding var credits: DataModel.Movie.Credits?
    @State var creditType: CreditType = .cast
    @State var displayRatingOptions: Bool = false
    
    var body: some View {
        ScrollView {
            MovieDetailsTitleView(details: details)
                  
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Director: \(credits?.director?.name ?? " - ")")
                    .font(.title2)
                    .fontWeight(.bold)

                Text(details?.overview ?? "")
                
                SubmitRateButtonView {
                    displayRatingOptions = !displayRatingOptions
                }

                Picker("", selection: $creditType) {
                    Text("Cast").tag(CreditType.cast)
                    Text("Crew").tag(CreditType.crew)
                }
                .pickerStyle(.segmented)
                
                LazyVStack(alignment: .leading, spacing: 8.0) {
                    ForEach(displayedCredits, id: \.id) {
                        CreditCell(credit: $0)
                        Divider()
                    }
                }
            }
            .padding()
        }
        .confirmationDialog("Select your rating", isPresented: $displayRatingOptions, titleVisibility: .visible) {
            ForEach((1...5), id: \.self) { star in
                Button {
                    print(star)
                } label: {
                    HStack {
                        let starString = (1...star).map { _ in "☆" }.joined(separator: "")
                        Text("\(star): \(starString)")
                    }
                }
            }
        }
    }
    
    private var displayedCredits: [Credit] {
        switch creditType {
        case .cast:
            return credits?.casts.removeDuplicates() ?? []
        case .crew:
            return credits?.crews.removeDuplicates() ?? []
        }
    }
    
    enum CreditType: String, CaseIterable, Identifiable {
        case cast
        case crew
        
        var id: Self { self }
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}

extension DataModel.Movie.Credits {
    var director: Crew? {
        return crews.first { crew in
            crew.job == "Director"
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MovieDetailsView(
                details: .init(
                    id: 1,
                    title: "Movie title",
                    overview: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    releaseDate: "12 Mar, 2022",
                    originalLanguage: "Spanish",
                    voteAverage: 8.6,
                    posterPath: "/74xTEgt7R36Fpooo50r9T25onhq.jpg"
                ),
                credits: .constant(
                    .init(
                        id: 1,
                        casts: [
                            .init(
                                id: 1,
                                name: "Actor name",
                                character: "Role name",
                                profilePath: nil
                            )
                        ],
                        crews: [
                            .init(
                                id: 1,
                                name: "Crew name",
                                job: "Director",
                                profilePath: nil
                            )
                        ]
                    )
                ),
                displayRatingOptions: false
            )
        }
    }
}

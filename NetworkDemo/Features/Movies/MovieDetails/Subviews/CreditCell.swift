//
//  CreditCell.swift
//  NetworkDemo
//
//  Created by Tatsuya Kaneko on 14/03/2022.
//

import SwiftUI

protocol Credit {
    var id: Int { get }
    var name: String? { get }
    var role: String? { get }
    var profilePath: String? { get }
}

struct CreditCell: View {
    let credit: Credit
    
    var body: some View {
        HStack {
            creditImage()

            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
            .clipped()
            
            VStack (alignment: .leading) {
                Text(credit.name ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.label)
                Text(credit.role ?? "")
                    .foregroundColor(.secondaryLabel)
            }
        }
    }
    
    @ViewBuilder
    private func creditImage() -> some View {
        if let imageUrl = credit.imageUrl {
            CachedAsyncImage(url: imageUrl) { phase in
                switch (phase) {
                case .empty:
                    ProgressView()
                case .failure:
                    Image(systemName: "photo")
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "person")
        }
    }
}

private extension Credit {
    var imageUrl: URL? {
        return profilePath.map {
            URL(string: ApiConstants.smallImageBaseUrl)!.appendingPathComponent($0)
        }
    }
}

extension DataModel.Movie.Credits.Cast: Credit {
    var role: String? {
        return self.character
    }
}

extension DataModel.Movie.Credits.Crew: Credit {
    var role: String? {
        return self.job
    }
}

struct CreditCell_Previews: PreviewProvider {
    static var previews: some View {
        CreditCell(
            credit: DataModel.Movie.Credits.Cast(
                id: 1,
                name: "Name of a cast",
                character: "James",
                profilePath: ""
            )
        )
            .previewLayout(.sizeThatFits)
    }
}

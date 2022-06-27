//
//  ImageRowView.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct PhotoRowView: View {
    
    var photo: Photo
    
    var body: some View {
        HStack {
            Spacer()
            if let photoURL = URL(string: photo.url ?? String()) {
                AsyncImage(
                    url: photoURL,
                    content: { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                }, placeholder: {
                    Image(systemName: "photo")
                })
                    .padding()
            }
            Spacer()
        }
        .background(Color("Rose"))
        .multilineTextAlignment(.leading)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 0.5)
                .shadow(color: .black, radius: 20)
        )
    }
    
}

struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView(photo: Photo())
    }
}

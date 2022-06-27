//
//  CommentDetailView.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct CommentRowView: View {
    
    var comment: Comment
    @State private var selection: String?
    
    var body: some View {
        VStack {
            HStack {
                Text(comment.body ?? String())
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding()
            }
            .background(Color("Green"))
            .multilineTextAlignment(.leading)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 0.5)
                    .shadow(color: .black, radius: 20)
            )
            Text(comment.email ?? String())
                .font(.body)
                .foregroundColor(.black)
                .lineLimit(1)
        }
    }
    
}

struct CommentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CommentRowView(comment: Comment())
    }
}

//
//  PostRowView.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct PostRowView: View {
    
    var post: Post
    @State private var selection: String?
    @EnvironmentObject var commenstVM: CommentsViewModel
    @EnvironmentObject var photosVM: PhotosViewModel
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination:
                    PhotoListView()
                    .environmentObject(photosVM)
                ,
                tag: "photos",
                selection: $selection) {
                    EmptyView()
                }
            NavigationLink(
                destination:
                    CommentListView()
                    .environmentObject(commenstVM)
                ,
                tag: "comments",
                selection: $selection) {
                    EmptyView()
                }
            VStack {
                Text(post.title ?? String())
                    .font(.title2)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .padding(.bottom)
                Text(post.body ?? String())
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.bottom)
                HStack {
                    Button(action: {
                        photosVM.currentPost = post
                        photosVM.fetch {
                            selection = "photos"
                        }
                    }, label: {
                        Image(systemName: "photo")
                            .foregroundColor(.black)
                    })
                    .padding(5)
                    Button(action: {
                        commenstVM.currentPost = post
                        commenstVM.fetch { 
                            selection = "comments"
                        }
                    }, label: {
                        Image(systemName: "text.bubble")
                            .foregroundColor(.black)
                    })
                    .padding(5)
                    Spacer()
                }
            }
            .multilineTextAlignment(.leading)
        }
        .frame(height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 0.5)
                .shadow(color: .black, radius: 20)
        )
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(post: Post())
    }
}

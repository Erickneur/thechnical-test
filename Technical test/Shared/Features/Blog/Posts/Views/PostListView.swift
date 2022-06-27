//
//  PostListView.swift
//  Shared
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct PostListView: View {
    
    @State private var searchText = String()
    @StateObject private var postsVM = PostsViewModel()
    @StateObject private var commenstVM = CommentsViewModel()
    @StateObject private var photosVM = PhotosViewModel()
    
    var body: some View {
        VStack {
            if postsVM.postList.isEmpty {
                VStack(spacing: 0) {
                    Spacer()
                    Text("Add a post first, please!")
                        .foregroundColor(.white)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .opacity(0.54)
                    Spacer()
                }
            } else {
                HStack {
                    SearchBarView(placeHolder: "Search post", searchText: $searchText)
                        .padding()
                }
                .background(Color("Gray"))
                List {
                    ForEach(postsVM.postList.filter {
                        ($0.title ?? String())
                            .lowercased()
                            .contains(searchText.lowercased()) ||
                        ($0.body ?? String())
                            .lowercased()
                            .contains(searchText.lowercased()) ||
                        searchText == ""
                    }, id: \.id) { post in
                        PostRowView(post: post)
                            .environmentObject(commenstVM)
                            .environmentObject(photosVM)
                    }
                    .listRowBackground(Color.clear)
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle(Text("Post"), displayMode: .inline)
        .navigationBarColor(UIColor(named: "Gray"))
        .background(
            Color.white
                .edgesIgnoringSafeArea(.all)
        )
    }
    
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}

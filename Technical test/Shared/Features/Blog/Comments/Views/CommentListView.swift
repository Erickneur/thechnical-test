//
//  CommentListView.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct CommentListView: View {
    
    @State private var searchText = String()
    @EnvironmentObject var commentsVM: CommentsViewModel
    
    var body: some View {
        VStack {
            if commentsVM.commentList.isEmpty {
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
                    ForEach(commentsVM.commentList.filter {
                        ($0.body ?? String())
                            .lowercased()
                            .contains(searchText.lowercased()) ||
                        ($0.email ?? String())
                            .lowercased()
                            .contains(searchText.lowercased()) ||
                        searchText == ""
                    }, id: \.id) { comment in
                        CommentRowView(comment: comment)
                    }
                    .listRowBackground(Color.clear)
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle(Text("Comments"), displayMode: .inline)
        .navigationBarColor(UIColor(named: "Gray"))
        .background(
            Color.white
                .edgesIgnoringSafeArea(.all)
        )
    }
    
}

struct CommentListView_Previews: PreviewProvider {
    static var previews: some View {
        CommentListView()
            .environmentObject(CommentsViewModel())
    }
}

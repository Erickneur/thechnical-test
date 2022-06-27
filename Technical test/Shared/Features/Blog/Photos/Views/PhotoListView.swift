//
//  ImageListView.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct PhotoListView: View {
    
    @EnvironmentObject var photosVM: PhotosViewModel
    
    var body: some View {
        VStack {
            if photosVM.photoList.isEmpty {
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
                List {
                    ForEach(photosVM.photoList, id: \.id) { photo in
                        PhotoRowView(photo: photo)
                    }
                    .listRowBackground(Color.clear)
                }
                .buttonStyle(PlainButtonStyle())
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle(Text("Photos"), displayMode: .inline)
        .navigationBarColor(UIColor(named: "Gray"))
        .background(
            Color.white
                .edgesIgnoringSafeArea(.all)
        )
    }
    
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}

//
//  SearchBar.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

struct SearchBarView: View {
   
    var cornerRadius: CGFloat = 12
    var backgroundColor = Color("Light gray")
    var height: CGFloat = 48
    var placeHolder: String = "Search"
    @Binding var searchText: String
    @FocusState var focusField: Bool?
    var action: () -> Void = {}
    
    var body: some View {
        // Search view
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                TextField(placeHolder, text: $searchText, onEditingChanged: { _ in
                }, onCommit: {
                    action()
                })
                    .padding(.leading, 12)
                    .padding(.trailing, 20)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .focused($focusField, equals: true)
                    .disableAutocorrection(true)
                    .onAppear {
                        focusField = true
                    }
                if !searchText.isEmpty {
                    Button(action: {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding(.trailing, 20)
                            .foregroundColor(.gray)
                    })
                }
            }
            .frame(height: height, alignment: .leading)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
        }
        // .animation(.default, value: true) // animation does not work properly
    }
    
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(String()))
    }
}

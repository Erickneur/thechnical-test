//
//  Technical_testApp.swift
//  Shared
//
//  Created by Erick Dávila on 6/27/22.
//

import SwiftUI

@main
struct TechnicalTestApp: App {
    
    @AppStorage("isLoading") var isLoading: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PostListView()
            }
            .navigationViewStyle(.stack)
        }
    }
    
    func showActivityIndicator() {
        if isLoading {
            let items = ["Loading"]
            let activityView = UIActivityViewController(activityItems: items, applicationActivities: nil)
            if let topVC = UIApplication.getTopViewController() {
                topVC.present(activityView, animated: true, completion: nil)
            }
        }
    }
    
}

//
//  PhotosViewModel.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import Combine
import Foundation

class PhotosViewModel: ObservableObject {
    
    private let client = RestClient()
    private var cancellables = Set<AnyCancellable>()
    @Published var photoList = [Photo]()
    @Published var currentPost = Post()
    
    func fetch(completion: @escaping () -> Void) {
        if let postId = currentPost.id {
            client.request(
                endpoint: Endpoint(method: .GET, route: "posts/\(postId)/photos"),
                type: [Photo].self,
                errorType: GenericError.self
            )
                .sink(receiveCompletion: { error in
                    print(error)
                }, receiveValue: { response in
                    DispatchQueue.main.async {
                        self.photoList = response
                    }
                })
                .store(in: &cancellables)
        }
        completion()
    }
    
}

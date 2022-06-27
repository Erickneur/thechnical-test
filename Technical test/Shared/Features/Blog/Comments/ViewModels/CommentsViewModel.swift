//
//  CommentsViewModel.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import Combine
import Foundation

class CommentsViewModel: ObservableObject {
    
    private let client = RestClient()
    private var cancellables = Set<AnyCancellable>()
    @Published var commentList = [Comment]()
    @Published var currentPost = Post()
    
    func fetch(completion: @escaping () -> Void) {
        if let postId = currentPost.id {
            client.request(
                endpoint: Endpoint(method: .GET, route: "posts/\(postId)/comments"),
                type: [Comment].self,
                errorType: GenericError.self
            )
                .sink(receiveCompletion: { error in
                    print(error)
                }, receiveValue: { response in
                    DispatchQueue.main.async {
                        self.commentList = response
                    }
                })
                .store(in: &cancellables)
        }
        completion()
    }
    
}

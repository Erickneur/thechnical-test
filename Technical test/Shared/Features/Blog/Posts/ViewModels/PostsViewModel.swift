//
//  PostViewModel.swift
//  Technical test
//
//  Created by Erick Dávila on 6/27/22.
//

import Combine
import Foundation

class PostsViewModel: ObservableObject {
    
    private let client = RestClient()
    private var cancellables = Set<AnyCancellable>()
    @Published var postList = [Post]()
    
    init() {
        fetch { _ in }
    }
    
    func fetch(completion: @escaping (Bool) -> Void) {
        client.request(
            endpoint: Endpoint(method: .GET, route: "posts"),
            type: [Post].self,
            errorType: GenericError.self
        )
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { response in
                DispatchQueue.main.async {
                    self.postList = response
                }
            })
            .store(in: &cancellables)
    }
    
}

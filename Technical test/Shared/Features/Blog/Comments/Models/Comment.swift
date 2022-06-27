//
//  Post.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import Foundation

struct Comment: Identifiable, Codable {
    
    var postId: Int?
    var id: Int?
    var name: String?
    var email: String?
    var body: String?
    
}

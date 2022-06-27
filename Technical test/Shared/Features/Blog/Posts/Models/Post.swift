//
//  Post.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import Foundation

struct Post: Identifiable, Codable {
    
    var id: Int?
    var userId: Int?
    var title: String?
    var body: String?
    
}

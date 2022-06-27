//
//  Image.swift
//  Technical test (iOS)
//
//  Created by Erick Dávila on 6/27/22.
//

import Foundation

struct Photo: Identifiable, Codable {
    
    var albumId: Int?
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
}

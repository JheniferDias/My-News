//
//  FeedResponse.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import Foundation

struct FeedResponse {
    let title: String?
    let link: String?
    let description: String?
    let imageUrl: String?
    
    private enum CodingKeys : String, CodingKey {
        case title, link, description, imageUrl = "media:content"
    }
}

//
//  NewsDetailsViewModel.swift
//  My News
//
//  Created by Jhenifer Dias on 03/08/22.
//

import Foundation

class NewsDetailsViewModel {
    
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func getURLConverted() -> URL? {
        return URL(string: url)
    }
}

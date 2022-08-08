//
//  XMLNetwokManager.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import Foundation

class XMLNetworkManager: NSObject {
    
    enum MyError: Error {
        case generic(String)
    }
    
    private var rssItems = [FeedResponse]()
    private var error: Error?
    
    private var currentElement = ""
    private var currentTitle: String = ""
    private var currentLink: String = ""
    private var currentImageUrl = ""
    private var currentDescription = ""
    
    func getFeed(with url: URL, completion: @escaping (Result<[FeedResponse], Error>) -> Void) {
        
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        
        if parser?.parse() == true {
            completion(.success(self.rssItems))
        } else {
            completion(.failure(MyError.generic("A error ocurred")))
        }
    }
}

extension XMLNetworkManager: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentImageUrl = ""
            currentLink = ""
        }
        
        if currentElement == "media:content" {
            currentImageUrl += attributeDict["url"]!
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let stringConverted = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch currentElement {
        case "title":
            currentTitle += stringConverted
            
        case "description":
            currentDescription += stringConverted
            
        case "link":
            currentLink += stringConverted
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            let rssItem = FeedResponse(title: currentTitle,
                                      link: currentLink,
                                      description: currentDescription,
                                      imageUrl: currentImageUrl)
            self.rssItems.append(rssItem)
        }
    }
}

//
//  FeedViewModel.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import Foundation

// MARK: Protocols
protocol FeedViewModelCoordinatorDelegate: AnyObject {
    func goToDetails(_ viewModel: FeedViewModel, link: String)
}

protocol FeedViewModelViewDelegate: AnyObject {
    func viewFailure(_ viewModel: FeedViewModel, error: Error)
    func viewSuccess(_ viewModel: FeedViewModel)
}

class FeedViewModel {
    
    weak var viewDelegate: FeedViewModelViewDelegate?
    weak var coordinatorDelegate: FeedViewModelCoordinatorDelegate?
    
    var feed = [FeedResponse]()
    
    private let url = URL(string: "https://g1.globo.com/rss/g1/carros")
    let service = XMLNetworkManager()

    func getFeed() {
        
        guard let url = url else { return }
        
        service.getFeed(with: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let feed):
                    self.feed = feed
                    self.viewDelegate?.viewSuccess(self)
                case .failure(let error):
                    self.viewDelegate?.viewFailure(self, error: error)
                }
            }
        }
    }
    
    func goToDetails(link: String) {
        coordinatorDelegate?.goToDetails(self, link: link)
    }
}

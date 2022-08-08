//
//  FeedCoordinator.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import UIKit

class FeedCoordinator {
    
    var window: UIWindow
    var navigationController: UINavigationController?
    var viewModel: FeedViewModel?
    var feedViewController: FeedViewController?
    
    var detailsView: NewsDetailsViewController?
    var detailsCoordinator: NewsDetailsCoordinator?
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        viewModel = FeedViewModel()
        viewModel?.coordinatorDelegate = self
        feedViewController = FeedViewController(viewModel: viewModel!)
        
        navigationController = UINavigationController(rootViewController: feedViewController!)
        window.rootViewController = navigationController
    }
    
    func stop() {
        viewModel = nil
        feedViewController = nil
        detailsCoordinator = nil
        detailsView = nil
    }
}

extension FeedCoordinator: FeedViewModelCoordinatorDelegate {
    func goToDetails(_ viewModel: FeedViewModel, link: String) {
        guard let navigation = self.navigationController else { return }
        detailsCoordinator = NewsDetailsCoordinator()
        detailsCoordinator?.start(url: link, navigation: navigation)
    }
}



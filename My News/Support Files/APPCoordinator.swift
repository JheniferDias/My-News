//
//  APPCoordinator.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import UIKit

class AppCoordinator {
    
    var window: UIWindow
    var homeCoordinator: FeedCoordinator?
    var viewModel: FeedViewModel?
    var loginViewController: FeedViewController?
    
    required init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        homeCoordinator = FeedCoordinator(window: window)
        homeCoordinator?.start()
    }
}

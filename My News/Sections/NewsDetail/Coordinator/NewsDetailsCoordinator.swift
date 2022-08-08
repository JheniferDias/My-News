//
//  NewsDetailsCoordinator.swift
//  My News
//
//  Created by Jhenifer Dias on 03/08/22.
//

import UIKit

class NewsDetailsCoordinator {
    
    var navigation: UINavigationController?
    
    var viewModel: NewsDetailsViewModel?
    var view: NewsDetailsViewController?
    
    func start(url: String, navigation: UINavigationController) {
        self.navigation = navigation
        viewModel = NewsDetailsViewModel(url: url)
        view = NewsDetailsViewController(viewModel: viewModel!)
        navigation.pushViewController(view!, animated: true)
    }
}

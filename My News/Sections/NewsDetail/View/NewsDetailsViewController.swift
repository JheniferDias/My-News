//
//  NewsDetailsViewController.swift
//  My News
//
//  Created by Jhenifer Dias on 03/08/22.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Variables
    var viewModel: NewsDetailsViewModel!
    
    // MARK: - Inits
    init(viewModel: NewsDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = false
        loadingView.startAnimating()
        
        guard let url = viewModel.getURLConverted() else { return }
        webView.load(URLRequest(url: url))
        
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
}

//
//  FeedViewController.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: - Variables
    var viewModel: FeedViewModel!
    let identifierCell = "FeedTableViewCell"
    let identifierNibName = "FeedTableViewCell"
    
    // MARK: - Inits
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notícias"
        viewModel.viewDelegate = self
        setupTableView()
        loadingView.startAnimating()
        viewModel.getFeed()
    }
    
    // MARK: - Auxiliary methods
    func setupTableView() {
        tableView.register(UINib(nibName: identifierNibName, bundle: nil), forCellReuseIdentifier: identifierCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDelegate and DataSource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell,
                                                       for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.feed[indexPath.row]
        cell.setup(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feed.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = viewModel.feed[indexPath.row].link else { return }
        viewModel.goToDetails(link: link)
    }
}

// MARK: - FeedViewModelViewDelegate
extension FeedViewController: FeedViewModelViewDelegate {
    func viewFailure(_ viewModel: FeedViewModel, error: Error) {
        print(error.localizedDescription)
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    func viewSuccess(_ viewModel: FeedViewModel) {
        self.tableView.reloadData()
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
}

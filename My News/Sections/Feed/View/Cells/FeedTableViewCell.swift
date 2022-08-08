//
//  FeedTableViewCell.swift
//  My News
//
//  Created by Jhenifer Dias on 02/08/22.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(model: FeedResponse) {
        let descriptionFormated = model.description?.replacingOccurrences(of: "<img[^>]*>", with: "", options: .regularExpression)
        descriptionLabel.text = descriptionFormated?.replacingOccurrences(of: "<br />", with: "")
        titleLabel.text = model.title
        convertImage(imageUrlString: model.imageUrl ?? "")
        
        containerView.dropShadow(color: .gray, opacity: 0.6,
                                 offSet: CGSize(width: 0, height: 0),
                                 radius: 6)
    }
    
    func convertImage(imageUrlString: String) {
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: imageUrlString) else { return }
            let data = try? Data(contentsOf: imageURL)
            
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.headerImage.image = image
                }
            }
        }
    }
}


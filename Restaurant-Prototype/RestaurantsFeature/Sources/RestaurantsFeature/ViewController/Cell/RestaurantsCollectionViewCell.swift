//
//  RestaurantsCollectionViewCell.swift
//  
//
//  Created by Abdulaziz on 10/08/2022.
//

import UIKit

class RestaurantsCollectionViewCell: UICollectionViewListCell {
    
    var loadedImage: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    var customText: String?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        var content = self.defaultContentConfiguration().updated(for: state)
        
        content.imageProperties.maximumSize = CGSize(width: 56, height: 56)
        content.imageProperties.reservedLayoutSize = CGSize(width: 56, height: 56)
        
        content.image = self.loadedImage
        content.text = self.customText
        
        self.contentConfiguration = content
    }
    
    func showOrHideActivityIndicator(show: Bool, cell: RestaurantsCollectionViewCell) {
        
        if (show) {
            
            let activityIndicatorView = UIActivityIndicatorView(style: .medium)
            
            activityIndicatorView.startAnimating()
            cell.backgroundConfiguration?.customView = activityIndicatorView
        } else {
            cell.backgroundConfiguration?.customView = nil
        }
    }
}

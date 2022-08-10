//
//  RestaurantsTableViewCell.swift
//  
//
//  Created by Abdulaziz on 07/08/2022.
//

import UIKit

class RestaurantsTableViewCell: UITableViewCell {
    
    static let identifier = "RestaurantsTableViewCell"
    
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
        
        self.backgroundColor = .systemGray6
        
        content.image = self.loadedImage
        content.text = self.customText
        
        self.contentConfiguration = content
    }
    
    func showOrHideActivityIndicator(show: Bool, cell: UITableViewCell) {
        
        if (show) {
            cell.accessoryType = .none
            
            let activityIndicatorView = UIActivityIndicatorView(style: .medium)
            
            activityIndicatorView.startAnimating()
            cell.accessoryView = activityIndicatorView;
        } else {
            cell.accessoryView = nil;
        }
    }
}

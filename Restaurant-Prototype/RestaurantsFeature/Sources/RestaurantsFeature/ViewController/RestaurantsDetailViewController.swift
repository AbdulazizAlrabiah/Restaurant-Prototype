//
//  RestaurantsDetailViewController.swift
//  
//
//  Created by Abdulaziz on 08/08/2022.
//

import UIKit

class RestaurantsDetailViewController: UIViewController {
    
    let viewModel: RestaurantsDetailViewModel
    var restaurant: Restaurant
    var restaurantImage: UIImage?
    
    public init(viewModel: RestaurantsDetailViewModel, restaurant: Restaurant, restaurantImage: UIImage?) {
        self.viewModel = viewModel
        self.restaurant = restaurant
        self.restaurantImage = restaurantImage
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray4
        
        restaurantImage = viewModel.resizeImageIfLargerThan(image: restaurantImage, largerThan: CGSize(width: 300, height: 300))
        
        createViews()
    }
    
    private func createViews() {
        
        let imageView = UIImageView(image: restaurantImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let nameLabel = UILabel()
        nameLabel.text = restaurant.name
        nameLabel.textAlignment = .center
        
        let desciptionLabel = UILabel()
        desciptionLabel.text = restaurant.description
        desciptionLabel.numberOfLines = 0
        desciptionLabel.adjustsFontSizeToFitWidth = true
        
        let middleStackView = UIStackView()
        middleStackView.axis = .horizontal
        middleStackView.alignment = .center
        middleStackView.spacing = 10
        
        middleStackView.addArrangedSubview(nameLabel)
        middleStackView.addArrangedSubview(desciptionLabel)
        
        let hoursLabel = UILabel()
        hoursLabel.text = restaurant.hours
        hoursLabel.textAlignment = .center
        hoursLabel.textColor = .gray
        hoursLabel.adjustsFontSizeToFitWidth = true
        
        let ratingLabel = UILabel()
        ratingLabel.text = "\(restaurant.rating)"
        ratingLabel.textAlignment = .center
        
        
        let bottomStackView = UIStackView()
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.alignment = .center
        
        bottomStackView.addArrangedSubview(hoursLabel)
        bottomStackView.addArrangedSubview(ratingLabel)
        
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(middleStackView)
        mainStackView.addArrangedSubview(bottomStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            mainStackView.topAnchor.constraint(greaterThanOrEqualTo: self.view.topAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: -5),
            
            mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -55),
            mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}

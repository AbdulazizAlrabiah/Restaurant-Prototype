//
//  DependencyProvider.swift
//  
//
//  Created by Abdulaziz on 08/08/2022.
//

import UIKit

class DependencyProvider {
    
    static func getDetailScreen(restaurant: Restaurant, restaurantImage: UIImage?) -> RestaurantsDetailViewController {
        return RestaurantsDetailViewController(viewModel: detailScreenVM,
                                               restaurant: restaurant,
                                               restaurantImage: restaurantImage)
    }
    
    static var detailScreenVM: RestaurantsDetailViewModel {
        return RestaurantsDetailViewModel()
    }
}

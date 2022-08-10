//
//  MainDependencyProvider.swift
//  Restaurant-Prototype
//
//  Created by Abdulaziz on 08/08/2022.
//

import Foundation
import RestaurantsFeature

class MainDependencyProvider {
    
    static var getMainScreen: RestaurantsMainViewController {
        return RestaurantsMainViewController(viewModel: getMainScreenVM)
    }
    
    static var getMainCollectionScreen: RestaurantsMainCollectionViewController {
        return RestaurantsMainCollectionViewController(viewModel: getMainScreenVM)
    }
    
    static var getMainScreenVM: RestaurantsMainViewModel {
        return RestaurantsMainViewModel(restaurantsData: getMainRestaurantApi)
    }
    
    static var getMainRestaurantApi: RestaurantsApi {
        return RestaurantsApi()
    }
}

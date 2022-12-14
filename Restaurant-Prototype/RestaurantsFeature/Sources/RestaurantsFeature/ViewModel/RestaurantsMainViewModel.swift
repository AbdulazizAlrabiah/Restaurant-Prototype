//
//  RestaurantsMainViewModel.swift
//  
//
//  Created by Abdulaziz on 06/08/2022.
//

import Foundation

public protocol RestaurantsData {
    func getRestaurantsData() async -> [Restaurant]
    func getRestaurantsImageData(url: String) async -> Data?
}

public class RestaurantsMainViewModel {
    
    var restaurants: [Restaurant]
    let restaurantsData: RestaurantsData
    
    public init(restaurantsData: RestaurantsData) {
        restaurants = []
        self.restaurantsData = restaurantsData
    }
    
    func getRestaurants() async {
        restaurants = await restaurantsData.getRestaurantsData()
        sortRestaurants()
    }
    
    // TODO: Remove the background of the logos using CoreML dynamically, because of the shifing in Jan Burger's logo (May solve the issue)
    func getImageData(url: String) async -> Data? {
        return await restaurantsData.getRestaurantsImageData(url: url)
    }
    
    func sortRestaurants() {
        restaurants.sort { $0.distance < $1.distance }
    }
}

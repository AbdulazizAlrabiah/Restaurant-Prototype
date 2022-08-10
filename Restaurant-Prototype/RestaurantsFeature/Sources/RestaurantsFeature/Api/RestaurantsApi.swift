//
//  RestaurantsApi.swift
//  
//
//  Created by Abdulaziz on 06/08/2022.
//

import Foundation

public class RestaurantsApi: RestaurantsData {
    
    public init() {}
    
    public func getRestaurantsData() async -> [Restaurant] {
        guard let url = URL(string: "https://jahez-other-oniiphi8.s3.eu-central-1.amazonaws.com/restaurants.json") else {
            fatalError("Malformed URL!")
        }
        
        // Since it's a prototype we will favor the cached data
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let data: Data
        let response: URLResponse
        // TODO: Can remove and use below function
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            print("Request Error: \(error)")
            return []
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Response status code error")
            return []
        }
        
        do {
            return try JSONDecoder().decode([Restaurant].self, from: data)
        } catch {
            print("Decoding response Error: \(error)")
            return []
        }
    }
    
    public func getRestaurantsImageData(url: String) async -> Data? {
        guard let url = URL(string: url) else {
            print("Malformed image url")
            return nil
        }
        
        // Since it's a prototype we will favor the cached data
        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let data: Data
        
        do {
            (data, _) = try await URLSession.shared.data(for: urlRequest)
            return data
        } catch {
            print("Fetching image data failed")
            return nil
        }
    }
}

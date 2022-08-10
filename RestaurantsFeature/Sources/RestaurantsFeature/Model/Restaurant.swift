//
//  Restaurant.swift
//  
//
//  Created by Abdulaziz on 06/08/2022.
//

import Foundation

public struct Restaurant: Codable, Hashable {
    
    let id: Int
    let name: String
    let description: String
    let hours: String
    let image: String
    let rating: Double
    let distance: Double
    let hasOffer: Bool
    let offer: String?
}

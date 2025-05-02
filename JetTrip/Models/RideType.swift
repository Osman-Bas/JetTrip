//
//  RideType.swift
//  JetTrip
//
//  Created by Osman Baş on 1.05.2025.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL
    
    var id: Int {
        return rawValue
    }
    
    var description: String {
        switch self {
        case .uberX:
            return "UberX"
        case .black:
            return "UberBlack"
        case .uberXL:
            return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX:
            return "uber-x"
        case .black:
            return "uber-black"
        case .uberXL:
            return "uber-x"
        }
    }
    
    
    
    var baseFare: Double {
        switch self {
        case .uberX:
            return 35
        case .black:
            return 50
        case .uberXL:
            return 40
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles = distanceInMeters / 1600
        
        switch self {
        case .uberX: return distanceInMiles * 15 + baseFare
        case .black: return distanceInMiles * 20 + baseFare
        case .uberXL: return distanceInMiles * 30 + baseFare
        }
        
        
    }
}

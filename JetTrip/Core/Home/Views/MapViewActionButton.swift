//
//  MapViewActionButton.swift
//  JetTrip
//
//  Created by Osman Baş on 27.04.2025.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring()) {
actionForState(mapState)            }
        }
            label: {
                Image(systemName: imageNameForState(mapState))
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .black,radius: 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .noInput:
            print("Debug: no input action")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected, .polylineAdded:
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput))
}

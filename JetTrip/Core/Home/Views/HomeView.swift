//
//  HomeView.swift
//  JetTrip
//
//  Created by Osman Baş on 27.04.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearhView = false
    var body: some View {
        ZStack(alignment:.top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if showLocationSearhView {
                LocationSearchView()
            }else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearhView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearhView)
                .padding(.leading)
                .padding(.top,4)
        }
    }
}

#Preview {
    HomeView()
}

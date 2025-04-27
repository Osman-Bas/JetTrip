//
//  HomeView.swift
//  JetTrip
//
//  Created by Osman Baş on 27.04.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}

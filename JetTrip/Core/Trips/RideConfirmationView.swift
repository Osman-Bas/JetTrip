//
//  RideConfirmationView.swift
//  JetTrip
//
//  Created by Osman Baş on 11.06.2025.
//

import SwiftUI

struct RideConfirmationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            
            Text("Seferiniz başarıyla onaylandı!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Sürücünüz yola çıkmak üzere. İyi yolculuklar!")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
           
        }
        .padding()
    }
}

#Preview {
    RideConfirmationView()
}

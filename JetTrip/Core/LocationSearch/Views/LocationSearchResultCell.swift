//
//  LocationSearchResultCell.swift
//  JetTrip
//
//  Created by Osman Baş on 27.04.2025.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading,spacing: 4){
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading,8)
            .padding(.vertical,8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultCell(title: "Starbucks", subtitle: "12 Sokak, Turgutlu")
}

//
//  MapPinView.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import SwiftUI

struct MapPinView: View {
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 32, height: 32)
            Image(systemName: "mappin.circle.fill")
                .foregroundColor(color)
                .font(.title2)
        }
    }
}

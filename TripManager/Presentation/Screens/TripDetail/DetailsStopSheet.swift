//
//  DetailsStopSheet.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import SwiftUI

struct DetailsStopSheet: View {
    let marker: SelectedMarker
    let trip: Trip
    let stop: DetailedStop?

    var body: some View {
        VStack(spacing: 12) {
            Text(stop?.userName ?? "No username")
                .font(.headline)
                .padding(.top)

            Divider()

            Text(stop?.address ?? "No address")
                .font(.body)

            VStack(spacing: 8) {
                Text("Lat: \(stop?.point.latitude ?? 0.0, specifier: "%.5f")")
                Text("Lon: \(stop?.point.longitude ?? 0.0, specifier: "%.5f")")
            }
            .font(.caption)

            if let stopTime = stop?.stopTime {
                Text("Stop Time: \(formattedDate(stopTime))")
                    .font(.caption)
            }

            Text("Price: \(stop?.price ?? 0.0, specifier: "%.2f")€")
                .font(.caption)

            Text(stop?.paid ?? false ? "Paid" : "Not Paid")
                .font(.caption)
                .foregroundColor(stop?.paid ?? false ? .green : .red)

            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.30)])
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


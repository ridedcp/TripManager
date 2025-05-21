//
//  TripInfoFooterView.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import SwiftUI

struct TripInfoFooterView: View {
    let trip: Trip

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(trip.description)
                .font(.headline)

            Text("Driver: \(trip.driverName)")
                .font(.subheadline)

            Text("From \(formattedDate(trip.startTime)) to \(formattedDate(trip.endTime))")
                .font(.caption)
                .foregroundColor(.secondary)

            if trip.stops.isEmpty {
                Text("No stops")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text("Stops: \(trip.stops.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

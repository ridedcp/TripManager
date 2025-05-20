//
//  StopDetailedMapper.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

enum StopDetailedMapper {
    static func map(dto: DetailedStopDTO) -> DetailedStop? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let stopTime = formatter.date(from: dto.stopTime) else { return nil }

        return DetailedStop(
            price: dto.price,
            address: dto.address,
            tripId: dto.tripId,
            paid: dto.paid,
            stopTime: stopTime,
            point: GeoPoint(latitude: dto.point.latitude, longitude: dto.point.longitude),
            userName: dto.userName
        )
    }
}

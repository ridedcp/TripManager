//
//  StopDetailedMapper.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

enum StopDetailedMapper {
    static func mapList(dtos: [StopDetailedDTO]) -> [StopDetailed] {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return dtos.compactMap { dto in
            guard let point = dto.point,
                  let address = dto.address,
                  let tripId = dto.tripId,
                  let paid = dto.paid,
                  let userName = dto.userName,
                  let price = dto.price
            else { return nil }

            let stopTime = dto.stopTime.flatMap { formatter.date(from: $0) }

            return StopDetailed(
                id: dto.id ?? -1,
                point: GeoPoint(latitude: point.latitude, longitude: point.longitude),
                address: address,
                tripId: tripId,
                paid: paid,
                stopTime: stopTime,
                userName: userName,
                price: price
            )
        }
    }
}

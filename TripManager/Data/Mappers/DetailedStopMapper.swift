//
//  DetailedStopMapper.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

enum DetailedStopMapperError: Error {
    case invalidDate(String)
}

enum DetailedStopMapper {
    static func map(dto: DetailedStopDTO) throws -> DetailedStop {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = formatter.date(from: dto.stopTime) else {
            throw DetailedStopMapperError.invalidDate(dto.stopTime)
        }

        return DetailedStop(
            id: dto.id,
            tripId: dto.tripId,
            userName: dto.userName,
            stopTime: date,
            address: dto.address,
            paid: dto.paid,
            price: dto.price,
            point: GeoPoint(latitude: dto.point.latitude, longitude: dto.point.longitude)
        )
    }

    static func mapList(dtos: [DetailedStopDTO]) -> [DetailedStop] {
        dtos.compactMap { try? map(dto: $0) }
    }
}

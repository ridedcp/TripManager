//
//  TripMapper.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

struct TripMapper {
    static func map(dto: TripDTO, id: Int) throws -> Trip {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let start = formatter.date(from: dto.startTime) else {
            throw TripMapperError.invalidDate(dto.startTime)
        }

        guard let end = formatter.date(from: dto.endTime) else {
            throw TripMapperError.invalidDate(dto.endTime)
        }

        return Trip(
            id: id,
            description: dto.description,
            driverName: dto.driverName,
            startTime: start,
            endTime: end,
            origin: GeoPoint(latitude: dto.origin.point.latitude, longitude: dto.origin.point.longitude),
            destination: GeoPoint(latitude: dto.destination.point.latitude, longitude: dto.destination.point.longitude),
            route: dto.route,
            stops: StopMapper.mapList(dtos: dto.stops ?? []),
            originAddress: dto.origin.address,
            destinationAddress: dto.destination.address
        )
    }

    static func mapList(dtos: [TripDTO]) -> [Trip] {
        var result: [Trip] = []
        for (index, dto) in dtos.enumerated() {
            do {
                let trip = try map(dto: dto, id: index)
                result.append(trip)
            } catch {
                print("Failed to map trip: \(dto.description) — \(error)")
            }
        }
        return result
    }
}



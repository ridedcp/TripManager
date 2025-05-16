//
//  TripMapper.swift
//  TripManager
//
//  Created by Daniel Cano on 16/5/25.
//

import Foundation

struct TripMapper {
    static func map(dto: TripDTO) throws -> Trip {
        let formatter = ISO8601DateFormatter()

        guard let start = formatter.date(from: dto.startTime) else {
            throw TripMapperError.invalidDate(dto.startTime)
        }

        guard let end = formatter.date(from: dto.endTime) else {
            throw TripMapperError.invalidDate(dto.endTime)
        }

        return Trip(
            description: dto.description,
            driverName: dto.driverName,
            startTime: start,
            endTime: end
        )
    }
}



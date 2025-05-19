//
//  StopMapper.swift
//  TripManager
//
//  Created by Daniel Cano on 19/5/25.
//

import Foundation

enum StopMapper {
    static func mapList(dtos: [StopDTO]) -> [Stop] {
        dtos.enumerated().compactMap { index, dto in
            guard let point = dto.point else { return nil }
            return Stop(
                id: dto.id ?? index + 1,
                point: GeoPoint(latitude: point.latitude, longitude: point.longitude)
            )
        }
    }
}

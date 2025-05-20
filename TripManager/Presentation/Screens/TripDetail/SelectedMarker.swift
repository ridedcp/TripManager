//
//  SelectedMarker.swift
//  TripManager
//
//  Created by Daniel Cano on 20/5/25.
//

import Foundation

enum SelectedMarker: Identifiable {
    case start
    case end
    case stop(Int)

    var id: String {
        switch self {
        case .start: return "start"
        case .end: return "end"
        case .stop(let n): return "stop-\(n)"
        }
    }

    var title: String {
        switch self {
        case .start: return "Start"
        case .end: return "End"
        case .stop(let n): return "Stop \(n)"
        }
    }
}

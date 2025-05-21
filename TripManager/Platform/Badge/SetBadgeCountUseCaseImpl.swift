//
//  SetBadgeCountUseCaseImpl.swift
//  TripManager
//
//  Created by Daniel Cano on 21/5/25.
//

import UIKit
import UserNotifications

final class SetBadgeCountUseCaseImpl: SetBadgeCountUseCase {
    func execute(_ count: Int) {
        UNUserNotificationCenter.current().setBadgeCount(count) { error in
            if let error = error {
                print("Failed to set badge count: \(error.localizedDescription)")
            }
        }
    }
}

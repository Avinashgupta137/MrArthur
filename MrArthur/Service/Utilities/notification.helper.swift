//
//  NotificationHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 26/09/22.
//

import Foundation

enum ENotificationType: String {
    case INSTALL_ON_CHILD_PHONE_OBSERVER_PUSH = "install-on-child-phone-observer-push"
    case HELP_FOR_SETTINGS_OBSERVER_PUSH = "help-for-settings-observer-push"
    case SEND_YOUR_GOAL_OBSERVER_PUSH = "send-your-goal-observer-push"
    case SEND_YOUR_GOAL_ATTENDEE_PUSH = "send-your-goal-attendee-push"
    case GOAL_SENT_OBSERVER_PUSH = "goal-sent-observer-push"
    case GOAL_SENT_ATTENDEE_PUSH = "goal-sent-attendee-push"
    case GOAL_REJECTED_OBSERVER_PUSH = "goal-rejected-observer-push"
    case GOAL_REJECTED_ATTENDEE_PUSH = "goal-rejected-attendee-push"
    case none = "none"
}

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var notificationType: ENotificationType = .none
    @Published var pageData : Any?
    @Published var attendeeMediationCompleted : Bool = UserDefaultsHelper.selectedAttendee?.mediationCompleted ?? false
    @Published var attendeeMediationCompletedOBS : Bool = UserDefaultsHelper.getAttendeeScreenTimeFlag(uuid: UserDefaultsHelper.selectedAttendee?.uuid)
    @Published var hasValidSubscription: Bool = true
}


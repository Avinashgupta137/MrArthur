//
//  family.activity.selection.service.swift
//  MrArthur
//
//  Created by IPS-157 on 14/09/22.
//

import Foundation
import FamilyControls
import ManagedSettings
import SwiftUI

extension FamilyActivitySelection: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

class ExtensionFamilyActivitySelectionService {
    static func getEntertainmentSelection() -> FamilyActivitySelection {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        return entertainmentFamilyActivitySelection
    }

    static func getEducationalSelection() -> FamilyActivitySelection {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        return educationalFamilyActivitySelection
    }

    static func getAllCategoriesSelection() -> FamilyActivitySelection {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORY_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        return allCategoriesFamilyActivitySelection
    }

    static func getForbiddenBrowsersSelection() -> FamilyActivitySelection {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.FORBIDDEN_BROWSERS_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var forbiddenBrowsersFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        return forbiddenBrowsersFamilyActivitySelection
    }
    
    static func setEntertainmentSelection(selection: FamilyActivitySelection) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ENTERTAINMENT_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var entertainmentFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        entertainmentFamilyActivitySelection = selection
    }

    static func setEducationalSelection(selection: FamilyActivitySelection) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.EDUCATIONAL_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var educationalFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        educationalFamilyActivitySelection = selection
    }

    static func setAllCategoriesSelection(selection: FamilyActivitySelection) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.ALL_CATEGORY_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var allCategoriesFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        allCategoriesFamilyActivitySelection = selection
    }

    static func setForbiddenBrowsersSelection(selection: FamilyActivitySelection) -> Void {
        @AppStorage(
            ExtensionSharedAppGroupService.keys.FORBIDDEN_BROWSERS_FAMILY_ACTIVITY_SELECTION,
            store: ExtensionSharedAppGroupService.sharedDefault
        ) var forbiddenBrowsersFamilyActivitySelection: FamilyActivitySelection = FamilyActivitySelection()
        forbiddenBrowsersFamilyActivitySelection = selection
    }

    static func categoryIsInList(
            categoryTokenList: Set<ManagedSettings.ActivityCategoryToken>,
            categoryToken: ManagedSettings.ActivityCategoryToken
    ) -> Bool {
        var inList: Bool = false
        if (categoryTokenList.count > 0) {
            for token in categoryTokenList {
                if (categoryToken == token) {
                    inList = true
                    break
                }
            }
        }
        return inList
    }

    static func applicationIsInList(
        applicationTokenList: Set<ManagedSettings.ApplicationToken>,
        applicationToken: ManagedSettings.ApplicationToken
    ) -> Bool {
        var inList: Bool = false
        if (applicationTokenList.count > 0) {
            for token in applicationTokenList {
                if (applicationToken == token) {
                    inList = true
                    break
                }
            }
        }
        return inList
    }
}

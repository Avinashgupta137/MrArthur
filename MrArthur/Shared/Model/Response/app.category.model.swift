//
//  app.category.model.swift
//  MrArthur
//
//  Created by BAPS on 17/01/23.
//

import Foundation

struct AppCategory: Codable, Hashable, Identifiable {
    var id: Int?
    var uuid: String?
    var frName: String?
    var enName: String?
    var createdAt: String?
    var updatedAt: String?
    
    var size: CGFloat?
    var selected: Bool?
    
    var isSelected: Bool {
        return selected ?? false
    }
    var catName: String {
        return UtilityMethod.isFrench ? (frName ?? "") : (enName ?? "")
    }
}

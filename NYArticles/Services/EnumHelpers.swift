//
//  EnumHelpers.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 18/02/24.
//

import Foundation

enum Period: String, CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }

    case day = "1"
    case week = "7"
    case month = "30"

    func title() -> String{
        switch self {
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "Month"
        }
    }
}

enum PathsType: String, CaseIterable, Identifiable {
    var id: String {
        return self.rawValue
    }
    case emailed
    case shared
    case viewed

    func title() -> String {
        switch self {
        case .emailed:
            return "Emailed"
        case .shared:
            return "Shared"
        case .viewed:
            return "Viewed"
        }
    }
}

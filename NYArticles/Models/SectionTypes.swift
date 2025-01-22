//
//  SectionTypes.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import Foundation
import SwiftUI

enum SectionTypes: String, Codable {
    case opinion = "Opinion"
    case us = "U.S."
    case world = "World"
    case business = "Business"
    case climate = "Climate"
    case science = "Science"
    case newYork = "New York"
    case arts = "Arts"
    case realEState = "Real Estate"
    case style = "Style"
    case upshot = "The Upshot"
    case music = "Music"
    case well = "Well"
    case food = "Food"
    case travel = "Travel"
    case briefing = "Briefing"
    case yourMoney = "Your Money"
    case magazine = "Magazine"
    case movies = "Movies"
    case obituaries = "Obituaries"
    case health = "Health"
    case fashion = "Fashion"
    case techonology = "Technology"

    func getColor() -> Color {
        switch self {
        case .opinion:
            return Color.orange
        case .us:
            return Color.blue
        case .world:
            return Color.yellow
        case .business:
            return Color.gray
        case .climate:
            return Color.green
        case .science:
            return Color.cyan
        case .newYork:
            return Color.indigo
        case .arts:
            return Color.mint
        case .realEState:
            return Color.brown
        case .style:
            return Color.pink
        case .upshot:
            return Color.purple
        case .music:
            return Color.teal
        case .well:
            return Color.red
        case .food:
            return Color.primary
        case .travel:
            return Color.accentColor
        case .briefing:
            return Color.black
        case .yourMoney:
            return Color(uiColor: .magenta)
        case .magazine:
            return Color(uiColor: .tintColor)
        case .movies:
            return Color(uiColor: .quaternaryLabel)
        case .obituaries:
            return Color(uiColor: .tertiaryLabel)
        case .health:
            return Color(uiColor: .tertiarySystemBackground)
        case .fashion:
            return Color(uiColor: .secondarySystemGroupedBackground)
        default:
            return Color(uiColor: .darkText)
        }

    }
}

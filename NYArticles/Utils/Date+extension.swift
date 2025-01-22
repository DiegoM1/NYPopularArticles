//
//  Date+extension.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import Foundation


extension Date {
    func toString(withFormat format: String = "MMM d, yyyy, HH:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}

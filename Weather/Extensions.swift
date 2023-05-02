//
//  Extensions.swift
//  Weather
//
//  Created by Isaac Shoma on 2023-04-01.
//

import Foundation
import SwiftUI

// This extension is adding a function to Double type which rounds the Double to 0 decimal places and returns the result as a String
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

// This extension is adding a function to Double type which converts the Double to a Date object using the Unix timestamp
extension Double {
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}

// This extension is adding a function to Date type which checks whether a Date object is between two other Date objects
extension Date {
    func isBetween(_ date1: Date, _ date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
}

// This extension is adding a function to View type which sets the corner radius for specific corners of the view
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// This is a custom Shape which creates a rounded corner path for the specified corners with the given radius
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    // Returns a Path which can be used to create a shape for the given rectangle
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

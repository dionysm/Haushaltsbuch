//
//  Category.swift
//  Haushaltsbuch
//
import Foundation
import SwiftUI

struct Category: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var iconName: String // SF Symbol name
    var color: String    // Color name as string for Codable
    
    init(name: String, iconName: String = "folder", color: String = "blue") {
        self.name = name
        self.iconName = iconName
        self.color = color
    }
    
    // Computed property for SwiftUI Color
    var displayColor: Color {
        Color(color)
    }
    
    // Default categories
    static let defaultCategories: [Category] = [
        Category(name: "Lebensmittel", iconName: "cart.fill", color: "green"),
        Category(name: "Transport", iconName: "car.fill", color: "blue"),
        Category(name: "Essen", iconName: "fork.knife", color: "orange"),
        Category(name: "Unterhaltung", iconName: "gamecontroller.fill", color: "purple"),
        Category(name: "Shopping", iconName: "bag.fill", color: "pink"),
        Category(name: "Gesundheit", iconName: "heart.fill", color: "red"),
        Category(name: "Bildung", iconName: "book.fill", color: "indigo"),
        Category(name: "Rechnungen", iconName: "doc.text.fill", color: "gray"),
        Category(name: "Gehalt", iconName: "banknote.fill", color: "green"),
        Category(name: "Anlagen", iconName: "chart.line.uptrend.xyaxis", color: "teal")
    ]
}

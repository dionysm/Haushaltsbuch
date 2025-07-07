//
//  Transaction.swift
//  Haushaltsbuch
//

import Foundation

enum TransactionType: String, Codable {
    case income
    case expense
}
// smallChange
// Transaction.swift
struct Transaction: Identifiable, Codable {
    let id: UUID
    var name: String
    var date: Date
    var amount: Double
    var type: TransactionType
    var categoryId: Int
    var merchantId: Int
    var createdAt: Date
    var updatedAt: Date?
    var previousAmount: Double?
    
    // Standard-Konstruktor für neue Transaktionen
    init(name: String, date: Date, amount: Double, type: TransactionType, categoryId: Int, merchantId: Int) {
        self.id = UUID()
        self.name = name
        self.date = date
        self.amount = amount
        self.type = type
        self.categoryId = categoryId
        self.merchantId = merchantId
        self.createdAt = Date()
        self.updatedAt = nil
        self.previousAmount = nil
    }
    
    // Konstruktor für Updates (behält die ID)
    init(id: UUID, name: String, date: Date, amount: Double, type: TransactionType, categoryId: Int, merchantId: Int, createdAt: Date) {
        self.id = id
        self.name = name
        self.date = date
        self.amount = amount
        self.type = type
        self.categoryId = categoryId
        self.merchantId = merchantId
        self.createdAt = createdAt
        self.updatedAt = Date()
        self.previousAmount = nil
    }
}

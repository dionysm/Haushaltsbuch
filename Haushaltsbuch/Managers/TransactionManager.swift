// TransactionManager.swift
import Foundation

class TransactionManager: ObservableObject {
    @Published var transactions: [Transaction] = []
    private let storage = TransactionStorage()
    
    init() {
        load()
    }
    
    func load() {
        transactions = storage.load()
    }
    
    func add(_ transaction: Transaction) {
        transactions.append(transaction)
        save()
    }
    
    func update(_ transaction: Transaction) {
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions[index] = transaction
            save()
        }
    }
    
    func delete(_ transaction: Transaction) {
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions.remove(at: index)
            save()
        }
    }
    
    func save() {
        storage.save(transactions)
    }
}

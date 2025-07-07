//
//  TransactionViewModel.swift
//  Haushaltsbuch
//
//  Created by Dio on 07.07.25.
//
import Foundation

@MainActor
class TransactionViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private let storage = TransactionStorage()

    init() {
        load()
    }

    func add(_ transaction: Transaction) {
        transactions.append(transaction)
        storage.save(transactions)
    }

    func load() {
        transactions = storage.load()
    }
}

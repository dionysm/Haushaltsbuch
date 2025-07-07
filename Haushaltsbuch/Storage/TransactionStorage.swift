//
//  TransactionStorage.swift
//  Haushaltsbuch
//
//  Created by Dio on 07.07.25.
//

import Foundation

class TransactionStorage {
    private let filename = "transactions.json"
    
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }

    func save(_ transactions: [Transaction]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601

        do {
            let data = try encoder.encode(transactions)
            try data.write(to: fileURL)
            print("Transaktionen gespeichert.")
        } catch {
            print("Fehler beim Speichern: \(error)")
        }
    }

    func load() -> [Transaction] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            let data = try Data(contentsOf: fileURL)
            let transactions = try decoder.decode([Transaction].self, from: data)
            print("\(transactions.count) Transaktionen geladen.")
            return transactions
        } catch {
            print("Keine Daten gefunden oder Fehler: \(error)")
            return []
        }
    }
}

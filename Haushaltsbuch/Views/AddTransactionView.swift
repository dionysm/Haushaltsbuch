// AddTransactionView.swift (umbenennen zu TransactionFormView.swift wäre sinnvoll)
import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var manager: TransactionManager
    
    @State private var name = ""
    @State private var amountString = ""
    @State private var date = Date()
    @State private var type: TransactionType = .expense
    
    // Für Edit-Modus
    var transactionToEdit: Transaction?
    var isEditMode: Bool {
        transactionToEdit != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Name", text: $name)
                    TextField("Betrag", text: $amountString)
                        .keyboardType(.decimalPad)
                    DatePicker("Datum", selection: $date, displayedComponents: .date)
                    Picker("Typ", selection: $type) {
                        Text("Einnahme").tag(TransactionType.income)
                        Text("Ausgabe").tag(TransactionType.expense)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(isEditMode ? "Änderungen speichern" : "Speichern") {
                    saveTransaction()
                }
                .disabled(name.isEmpty || Double(amountString) == nil)
            }
            .navigationTitle(isEditMode ? "Eintrag bearbeiten" : "Neuer Eintrag")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Abbrechen") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onAppear {
            if let transaction = transactionToEdit {
                // Vorhandene Werte laden
                name = transaction.name
                amountString = String(format: "%.2f", transaction.amount)
                date = transaction.date
                type = transaction.type
            }
        }
    }
    
    func saveTransaction() {
        guard let amount = Double(amountString) else { return }
        
        if isEditMode, let existingTransaction = transactionToEdit {
            // Update mit korrekter ID
            let updatedTransaction = Transaction(
                id: existingTransaction.id,
                name: name,
                date: date,
                amount: amount,
                type: type,
                categoryId: existingTransaction.categoryId,
                merchantId: existingTransaction.merchantId,
                createdAt: existingTransaction.createdAt
            )
            manager.update(updatedTransaction)
        } else {
            // Neue Transaction
            let newTransaction = Transaction(
                name: name,
                date: date,
                amount: amount,
                type: type,
                categoryId: 0,
                merchantId: 0
            )
            manager.add(newTransaction)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

import SwiftUI

enum TransactionFilter {
    case all
    case income
    case expense
}

struct TransactionListView: View {
    @EnvironmentObject var manager: TransactionManager
    @State private var showingAddView = false
    @State private var selectedDate = Date()
    @State private var transactionToEdit: Transaction?
    @State private var showingEditView = false
    
    let filter: TransactionFilter
    let title: String
    
    private var filteredTransactions: [Transaction] {
        manager.transactions.filter { transaction in
            let matchesDate = Calendar.current.isDate(transaction.date, equalTo: selectedDate, toGranularity: .month)
            
            switch filter {
            case .all:
                return matchesDate
            case .income:
                return matchesDate && transaction.type == .income
            case .expense:
                return matchesDate && transaction.type == .expense
            }
        }
    }
    
    private var totalAmount: Double {
        switch filter {
        case .all:
            return filteredTransactions.reduce(0) { total, transaction in
                total + (transaction.type == .income ? transaction.amount : -transaction.amount)
            }
        case .income, .expense:
            return filteredTransactions.reduce(0) { $0 + $1.amount }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Gesamt: \(totalAmount, specifier: "%.2f") €")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                
                DatePicker("Monat auswählen", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .padding(.horizontal)
                
                List {
                    ForEach(filteredTransactions) { transaction in
                        HStack {
                            VStack(alignment: .center, spacing: 0) {
                                Text("\(transaction.date.formatted(.dateTime.month(.wide)))")
                                    .font(.subheadline)

                                Text("\(transaction.date.formatted(.dateTime.day()))")
                                    .font(.headline)

                            }
                            
                            Image(systemName: "dollarsign.ring")
                                .font(.system(size: 30))
                                .symbolEffect(.rotate)
                                .foregroundColor(.primary)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(transaction.name)
                                    .font(.headline)
                                Text("\(transaction.amount, specifier: "%.2f") €")
                                    .font(.subheadline)
                                    .foregroundColor(colorForTransaction(transaction))
                            }
                            .padding(.vertical, 0)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteTransaction(transaction)
                            } label: {
                                Label("Löschen", systemImage: "trash")
                            }
                            
                            Button {
                                transactionToEdit = transaction
                                showingEditView = true
                            } label: {
                                Label("Bearbeiten", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                //Color.white.opacity(1),
                                Color.black.opacity(0.1)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            }
            .navigationTitle(title)
            .foregroundColor(.primary)
            .background(
                LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.9), .white]), startPoint: .top, endPoint: .center)
            )
            //Bottom border
            .overlay(Rectangle().frame(width: nil, height: 1, alignment: .top).foregroundColor(Color.white.opacity(0.1)), alignment: .topTrailing)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddTransactionView()
        }
        .sheet(isPresented: $showingEditView) {
            if let transaction = transactionToEdit {
                AddTransactionView(transactionToEdit: transaction)
            }
        }
    }
    
    private func colorForTransaction(_ transaction: Transaction) -> Color {
        switch filter {
        case .all:
            return transaction.type == .income ? .green : .red
        case .income:
            return .green
        case .expense:
            return .red
        }
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        manager.delete(transaction)
    }
    
    func deleteTransactions(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = filteredTransactions[index]
            manager.delete(transactionToDelete)
        }
    }
}

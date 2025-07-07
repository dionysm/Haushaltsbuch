// ExpenseView.swift
import SwiftUI

struct ExpenseView: View {
    var body: some View {
        TransactionListView(filter: .expense, title: "Ausgaben")
    }
}

// IncomeView.swift
import SwiftUI

struct IncomeView: View {
    var body: some View {
        TransactionListView(filter: .income, title: "Einnahmen")
    }
}

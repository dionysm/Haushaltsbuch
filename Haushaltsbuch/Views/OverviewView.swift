// OverviewView.swift
import SwiftUI

struct OverviewView: View {
    var body: some View {
        TransactionListView(filter: .all, title: "Übersicht")
    }
}

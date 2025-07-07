//
//  MothYearPicker.swift
//  Haushaltsbuch
//
//  Created by Dio on 09.07.25.
//
import Foundation
import SwiftUI

struct MonthYearPicker: View {
    @Binding var selectedDate: Date
    
    private let months = Calendar.current.monthSymbols
    private let years = Array(2020...2030)
    
    @State private var selectedMonth: Int
    @State private var selectedYear: Int
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .year], from: selectedDate.wrappedValue)
        self._selectedMonth = State(initialValue: components.month ?? 1)
        self._selectedYear = State(initialValue: components.year ?? 2024)
    }
    
    var body: some View {
        HStack {
            Picker("Month", selection: $selectedMonth) {
                ForEach(1...12, id: \.self) { month in
                    Text(months[month - 1]).tag(month)
                }
            }
            .pickerStyle(.wheel)
            
            Picker("Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text(String(year)).tag(year)
                }
            }
            .pickerStyle(.wheel)
        }
        .onChange(of: selectedMonth) { _, _ in updateDate() }
        .onChange(of: selectedYear) { _, _ in updateDate() }
    }
    
    private func updateDate() {
        let calendar = Calendar.current
        let components = DateComponents(year: selectedYear, month: selectedMonth, day: 1)
        selectedDate = calendar.date(from: components) ?? Date()
    }
}

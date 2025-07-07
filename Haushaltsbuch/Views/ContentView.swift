    //
    //  ContentView.swift
    //  Haushaltsbuch
    //
    //  Created by Dio on 07.07.25.
    //

    import SwiftUI



    struct ContentView: View {
        var body: some View {
            TabView {
                IncomeView()
                    .tabItem {
                        Label("Einnahmen", systemImage: "plus.circle")
                    }
                    // Debug .border(Color.pink)


                OverviewView()
                    .tabItem {
                        Label("Übersicht", systemImage: "chart.pie")
                    }
                
                ExpenseView()
                    .tabItem {
                        Label("Ausgaben", systemImage: "minus.circle")
                    }
            }

        }
    }

#Preview {
    ContentView()
        .environmentObject(TransactionManager()) // ✅ Provide the environment object for preview
        .toolbarBackground(Color.pink)
        .toolbarColorScheme(.dark)
        //.preferredColorScheme(.dark) //
}

//
//  HaushaltsbuchApp.swift
//  Haushaltsbuch
//
//  Created by Dio on 07.07.25.
//

import SwiftUI

@main
struct HaushaltsbuchApp: App {
    @StateObject private var manager = TransactionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager) // 👈 global verfügbar machen
        }
    }
}

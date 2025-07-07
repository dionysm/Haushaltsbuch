//
//  User.swift
//  Haushaltsbuch
//
//  Created by Dio on 07.07.25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
}


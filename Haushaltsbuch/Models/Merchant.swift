//
//  Merchant.swift
//  Haushaltsbuch
//
//  Created by Dio on 07.07.25.
//
import Foundation

struct Merchant: Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
}

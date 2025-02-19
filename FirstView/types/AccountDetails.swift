//
//  AccountDetails.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/16/25.
//


public struct AccountDetails: Codable {
    let accountNumber: String
    let accountName: String
    let balance: Double
    let transactions: [Transaction]
}

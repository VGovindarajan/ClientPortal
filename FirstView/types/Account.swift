//
//  AccountBasicDetails.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 3/2/25.
//

import Foundation

struct Account: Codable, Identifiable {
    let id: Int
    let accountName: String
    let accountNumber: String
    let accountType: String
    let clientType: String

    enum CodingKeys: String, CodingKey {
        case id = "account_id"
        case accountName = "account_name"
        case accountNumber = "account_number"
        case accountType = "account_type"
        case clientType = "client_type"
    }
}

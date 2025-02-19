//
//  AccountsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//



import SwiftUI

public struct AccountsView: View {
    public var body: some View {
        NavigationView { // Embed PositionsView in a NavigationView
            Text("Accounts")
                .navigationTitle("Accounts") // Add a navigation title
        }
    }
}

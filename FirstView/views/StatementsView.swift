//
//  StatementsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//


import SwiftUI

public struct StatementsView: View {
    public var body: some View {
        NavigationView { // Embed PositionsView in a NavigationView
            Text("Statements")
                .navigationTitle("Statements") // Add a navigation title
        }
    }
}

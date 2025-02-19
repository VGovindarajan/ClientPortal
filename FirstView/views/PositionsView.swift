//
//  PositionsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//


import SwiftUI

public struct PositionsView: View {
    public var body: some View {
        NavigationView { // Embed PositionsView in a NavigationView
            Text("Open positions")
                .navigationTitle("Positions") // Add a navigation title
        }
    }
}

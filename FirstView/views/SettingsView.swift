//
//  SettingsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//


import SwiftUI

public struct SettingsView: View {
    public var body: some View {
        NavigationView { // Embed PositionsView in a NavigationView
            Text("Settings")
                .navigationTitle("Settings") // Add a navigation title
        }
    }
}

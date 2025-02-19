//
//  MainView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//
import SwiftUI

struct MainView: View {
    let user : User?
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayView()
                .tabItem {
                    Label("Balances", systemImage: "dollarsign")
                }
                .tag(0)

            PositionsView()
                .tabItem {
                    Label("Positions", systemImage: "cart")
                }
                .tag(1)

            StatementsView()
                .tabItem {
                    Label("Statements", systemImage: "tray")
                }
                .tag(2)

            AccountsView()
                .tabItem {
                    Label("Accounts", systemImage: "list.dash")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(4)
        }
    }
}

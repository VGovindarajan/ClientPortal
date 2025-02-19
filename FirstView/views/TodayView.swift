//
//  Tab1View.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//

import SwiftUI

public struct TodayView: View {
    public var body: some View {
        NavigationView { // Embed Tab1View in a NavigationView
            Text("Content of Today's balance")
                .navigationTitle("Today") // Add a navigation title
        }
    }
}

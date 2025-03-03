//
//  AccountsView 2.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 3/2/25.
//


//
//  AccountsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//




import SwiftUI

struct OrientationAwareListView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        let isPortrait = verticalSizeClass == .regular && horizontalSizeClass == .compact
        let columns = isPortrait ?
            Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 3) :
            Array(repeating: GridItem(.flexible(), spacing: 0, alignment: nil), count: 7)


        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(0..<100) { index in
                    Text("Item \(index)")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                        .background(Color.yellow.opacity(0.1))
                        .cornerRadius(2)
                        .border(.black, width: 1)
                }
            }
            .padding()
        }
    }
}

struct OrientationAwareListView_Previews: PreviewProvider {
    static var previews: some View {
        OrientationAwareListView()
    }
}

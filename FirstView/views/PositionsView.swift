//
//  PositionsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//

import SwiftUI

struct Position: Identifiable {
    let id = UUID()  // Make it Identifiable
    let symbol: String
    let position: Int
    let openPrice: Double
    let currentPrice: Double
}

struct PositionsView: View {
    
    let positionData = [
        Position(
            symbol: "AAPL", position: 100, openPrice: 210, currentPrice: 215),
        Position(
            symbol: "GOOG", position: 20, openPrice: 195, currentPrice: 198),
        Position(
            symbol: "META", position: 40, openPrice: 600, currentPrice: 660),
        Position(
            symbol: "NFLX", position: 10, openPrice: 700, currentPrice: 720),
        Position(
            symbol: "AA", position: 100, openPrice: 210, currentPrice: 215),
        Position(
            symbol: "BAC", position: 20, openPrice: 195, currentPrice: 198),
        Position(
            symbol: "PLTR", position: 40, openPrice: 600, currentPrice: 660),
        Position(
            symbol: "NVDA", position: 10, openPrice: 700, currentPrice: 720),
        Position(
                symbol: "CRWD", position: 100, openPrice: 210, currentPrice: 215),
        Position(
            symbol: "NET", position: 20, openPrice: 195, currentPrice: 198),
        Position(
            symbol: "ISRG", position: 40, openPrice: 600, currentPrice: 660),
        Position(
            symbol: "MA", position: 10, openPrice: 700, currentPrice: 720),
        Position(
            symbol: "V", position: 100, openPrice: 210, currentPrice: 215),
        Position(
            symbol: "TLT", position: 20, openPrice: 195, currentPrice: 198),
        Position(
            symbol: "SPY", position: 40, openPrice: 600, currentPrice: 660),
        Position(
            symbol: "QQQ", position: 10, openPrice: 700, currentPrice: 720),

    ]
    
    func formattedDouble(_ value: Double) -> String {
           return String(format: "%.2f", value)
       }
    
    var body: some View {
        NavigationView {  // Embed PositionsView in a NavigationView
            //GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack (spacing:0){
                        Text("Name")
                            .frame(width:120, alignment: .leading)
                            .padding()
                        Text("Account Name")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .border(Color.black, width:1)
                    
                    HStack (spacing:0){
                        Text("Account Number")
                            .frame(width:120, alignment: .leading)
                            .padding()
                        Text("TTA0000")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .border(Color.black, width:1)
                }
                //.frame(height: geometry.size.height * 0.15)  // 15% of parent height
                
                List {
                    
                    HStack {
                        Text("Symbol")
                            .frame(maxWidth: 150, alignment: .trailing)
                        Text("Position")
                            .frame(maxWidth: 150, alignment: .trailing)
                        
                        Text("Opening Price")
                            .frame(maxWidth: 150, alignment: .trailing)
                        
                        Text("Current Price")
                            .frame(maxWidth: 150, alignment: .trailing)
                    }

                    ForEach(positionData) {
                        posiData in  // Your 75% height List
                        HStack {
                            Text(posiData.symbol)
                                .frame(maxWidth: 150, alignment: .trailing)
                            Text(String(posiData.position))
                                .frame(maxWidth: 150, alignment: .trailing)
                            
                            Text(formattedDouble(posiData.openPrice))
                                .frame(maxWidth: 150, alignment: .trailing)
                            
                            Text(formattedDouble(posiData.currentPrice))
                                .frame(maxWidth: 150, alignment: .trailing)
                            
                            //                        Text(
                            //                            "\((posiData.currentPrice-posiData.openPrice)*posiData.position))"
                            //                        )
                            //                        .frame(maxWidth: 150, alignment: .trailing)
                        }
                    }
                }
                //.frame(height: geometry.size.height * 0.85)  // 75% of parent height
            }
        }
    }
}


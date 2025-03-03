//
//  StatementsView.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//


import SwiftUI

struct StatementsView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    let data: [[Any]] = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        return (0..<5).map { _ in
            (0..<5).map { _ in
                let randomValue = Double.random(in: -100...100)
                let randomDate = Calendar.current.date(byAdding: .day, value: Int.random(in: -30...30), to: Date())!
                let randomString = "Item \(Int.random(in: 1...100))"
                let randomChoice = Int.random(in: 0...2)

                switch randomChoice {
                case 0:
                    return randomValue
                case 1:
                    return randomDate
                default:
                    return randomString
                }
            }
        }
    }()
        
    var body: some View {
        NavigationView{
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<data.count, id: \.self) { rowIndex in
                    ForEach(0..<data[rowIndex].count, id: \.self) { columnIndex in
                        let item = data[rowIndex][columnIndex]
                        
                        if let doubleValue = item as? Double {
                            Text(String(format: "%.2f", doubleValue))
                                .foregroundColor(doubleValue < 0 ? .red : .green)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        } else if let dateValue = item as? Date {
                           
                            Text(dateValue.formatted(date: .abbreviated, time: .omitted))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        } else if let stringValue = item as? String {
                            Text(stringValue)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        } else {
                            Text("Unknown")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(5)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct StatementsView_Previews: PreviewProvider {
    static var previews: some View {
        StatementsView()
    }
}

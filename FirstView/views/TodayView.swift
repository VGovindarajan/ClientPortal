//
//  Tab1View.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 2/17/25.
//

import SwiftUI

public struct TodayView: View {
    
    let data =
        ["Name": "Account Name", "Account Number": "TTA0000", "Client Type": "Individual", "Account Type": "Speculative"]
    public var body: some View {
        NavigationView { // Embed Tab1View in a NavigationView
            ScrollView([.horizontal, .vertical],showsIndicators: true){
                VStack (spacing:0){
                    HStack (spacing:0){
                        Text("Name")
                            .frame(width:120, alignment: .leading)
                            .padding()
                        Text(data["Name"] ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .border(Color.black, width:1)
                    
                    HStack (spacing:0){
                        Text("Account Number")
                            .frame(width:120, alignment: .leading)
                            .padding()
                        Text(data["Account Number"] ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .border(Color.black, width:1)
                    
                    HStack (spacing:0){
                        Text("Client Type")
                            .frame(width:120,  alignment: .leading)
                            .padding()
                        Text(data["Client Type"] ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .border(Color.black, width:1)
                    
                    HStack {
                        Text("Account Type")
                            .frame(width:120,  alignment: .leading)
                            .padding()
                        Text(data["Account Type"] ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .border(Color.black, width:1)
                    Spacer()
                    TVHeader(heading: "TTA0000", firstString: "Statement Value (USD)", secondString: "Current Value (USD)", delta: "Change (USD)")
                    TVHeader(heading: "", firstString: "2/19/2025", secondString: "2/20/2025", delta: "")
                    
                    TVRow(heading: "Ledger Balance", firstData: 56226.09, secondData: nil, delta: nil)
                    TVRow(heading: "Collateral", firstData: 0.00, secondData: nil, delta: nil)
                    TVRow(heading: "Equity Collateral", firstData: 57451.09, secondData: nil, delta: nil)
                    TVRow(heading: "Initial Margin", firstData: 1225.00, secondData: 1635.00, delta: 410.00)
                    TVRow(heading: "Maintenance Margin", firstData: 1225.00, secondData: 1635.00, delta: 410.00)
                    TVRow(heading: "OTE", firstData: nil, secondData: nil, delta: nil)
                    TVRow(heading: "Long Option Value", firstData: 1225.00, secondData: 60.00, delta: -1165.00)
                    TVRow(heading: "Short Option Value", firstData: nil, secondData: nil, delta: nil)
                    TVRow(heading: "Margin Excess/Deficit", firstData: 56226.09, secondData: 54651.09, delta: -1575.00)
                    TVRow(heading: "NLV", firstData: 57451.09, secondData: 56286.09, delta: -1165.00)
                
                }
                
            }
        }
    }
}


public struct TVHeader : View{
    
    var heading:String?
    var firstString:String?
    var secondString:String?
    var delta:String?
    public var body: some View{
        
        HStack{
            Text(heading ?? "")
                .frame(width:120, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
            Text(firstString ?? "")
                .frame(width:120, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
            Text(secondString ?? "")
                .frame(width:120, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
            Text(delta ?? "")
                .frame(width:80, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
        }
        .border(Color.black, width:1)

    }
}
    

public struct TVRow : View{
    
    var heading:String?
    var firstData:Float?
    var secondData:Float?
    var delta:Float?
    public var body: some View{
        
        HStack{
            Text(heading ?? "")
                .frame(width:120, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
            Text((String)(firstData ?? 0))
                .frame(width:120, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
            Text((String)(secondData ?? 0))
                .frame(width:120, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
            Text((String)(delta ?? 0))
                .frame(width:80, alignment: .leading)
                .padding()
                //.border(Color.gray,width:0.25)
        }
        .border(Color.black, width:1)

    }
}
    

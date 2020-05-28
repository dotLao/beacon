//
//  DetailView.swift
//  beacon
//
//  Created by Dylan Todd on 5/25/20.
//  Copyright © 2020 Dotlao. All rights reserved.
//

import SwiftUI
import Foundation

struct DetailView: View {
    var item: TestData
    @State var showChat = false
    var body: some View {
        VStack{
            HStack(alignment:.top){
                Image(systemName: "person.circle")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 100.0,height:100)
                 .shadow(radius: 10)
                Text(item.name)
                 .font(.headline)
                Spacer()
            }.padding()
            .sheet(isPresented: self.$showChat) {
                 ChatView()
            }
            Spacer()
            Button(action: {
                self.showChat.toggle()
            }) {
                Text("Start a conversation")
                    .font(.largeTitle)
                    .fontWeight(.ultraLight)
            }
        }
        .navigationBarTitle("Beacon",displayMode: .inline)
    }
}

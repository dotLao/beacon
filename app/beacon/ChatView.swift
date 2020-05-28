//
//  ChatView.swift
//  sampleapp
//
//  Created by Unitoro on 5/27/20.
//  Copyright © 2020 DEDstop. All rights reserved.
//

import SwiftUI

struct Chat: Hashable {
    var message: String
    var avatar: String
    var color: Color
}

struct ChatView : View {
    
    // A sent with a red message bubble color
    // B sent with a blue message color
    var messages = [
        Chat(message: "Hey thanks for your time!", avatar: "A", color: .red),
        Chat(message: "I'm happy to be here, friend.", avatar: "B", color: .blue)
    ]
    
    var body: some View {
        List {
            ForEach(messages, id: \.self) { msg in
                Group {
                    Text(msg.avatar)
                    Text(msg.message)
                        .bold()
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(msg.color)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

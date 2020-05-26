//
//  ContentView.swift
//  beacon
//
//  Created by Dylan Todd on 5/25/20.
//  Copyright © 2020 Dotlao. All rights reserved.
//

import SwiftUI

struct ContentView: View {
     @EnvironmentObject var session:FirebaseSession
       // let data = ["stringOne","stringTwo","stringThree","stringFour","stringFive", "stringSix"]
        let data = TestData.self
        @State var testData:[TestData] = []
        var body: some View {
            Group{
                if session.user == nil {
                    LoginView().environmentObject(session)
                } else {
                    NavigationView {
                        List {
                            Text("username:\(session.user?.displayName ?? "no name found")")
                            Button(action: {
                                self.logout()
                            }) {
                                Text("Logout")
                            }
                            ForEach (self.testData) {item in
                                NavigationLink(destination: DetailView(item:item)) {
                                    CellView(item:item)
            //                        Text("")
                                }
                            }
                        }.navigationBarTitle("users")
                    }
                }
            }.onAppear{
                self.session.startListening()
                self.getData()
            }
        }
        func logout() {
               session.logOut()
        }
        func getData() {
            session.getData { (data, error) in
                self.testData = data ?? []
            }
        }
    }


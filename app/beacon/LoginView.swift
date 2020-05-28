//
//  LoginView.swift
//  beacon
//
//  Created by Dylan Todd on 5/25/20.
//  Copyright © 2020 Dotlao. All rights reserved.
//

import SwiftUI
import GoogleSignIn
 
struct LoginView: View {
    @EnvironmentObject var session:FirebaseSession
    var body: some View {
        VStack{
            Text("We are here to help.")
                .font(.headline)
            Spacer()
            Text("Please sign in")
                .font(.subheadline)
                .foregroundColor(Color.gray)
            Spacer.init(minLength: 10)
            GoogleButtonView()
         }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct GoogleButtonView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleButtonView>) -> UIView {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        return button
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GoogleButtonView>) {
    }
    
}

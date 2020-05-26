//
//  FirebaseSession.swift
//  beacon
//
//  Created by Dylan Todd on 5/25/20.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestoreSwift

class FirebaseSession:ObservableObject{
    var db = Firestore.firestore()
    @Published var user:User?
    func startListening() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.user = user
            } else {
                self.user = nil
            }
        }
    }
    
    func logOut() {
        try! Auth.auth().signOut()
        self.user = nil
        GIDSignIn.sharedInstance()?.signOut()
    }
}

extension FirebaseSession{
    func getData(completion: @escaping ([TestData]?,Error?) -> Void) {
        db.collection("testData").getDocuments { (snapshot, error) in
            self.handleDocuments(type: TestData.self, snapshot: snapshot, error: error, completion: completion)
        }
    }
}

struct TestData: Codable, Identifiable, Equatable {
       static func == (lhs: TestData, rhs: TestData) -> Bool {
        return lhs.id == rhs.id
    }
    @DocumentID var id: String?
    var name:String
}

extension FirebaseSession {
    //, completion:@escaping ([T]?,Error?)->Void
    func handleDocument<T:Decodable>(type:T.Type, snapshot:DocumentSnapshot?, error:Error?, completion:@escaping (T?,Error?)->Void){
        let result = Result {
            try snapshot.flatMap {
                try $0.data(as: T.self)
            }
        }
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                completion(data,error)
            }
            break
        case .failure(let error):
            print("Error sending message: \(error.localizedDescription)")
        }
    }
    func handleDocuments<T:Decodable>(type:T.Type, snapshot:QuerySnapshot?, error:Error?, completion:@escaping ([T]?,Error?)->Void){
        let result = Result {
            try snapshot?.documents.compactMap {
                try $0.data(as: T.self)
            }
        }
        switch result {
        case .success(let data):
            DispatchQueue.main.async {
                completion(data,error)
            }
            break
        case .failure(let error):
            print("Error sending message: \(error.localizedDescription)")
        }
    }
}

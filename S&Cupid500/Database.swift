//
//  Database.swift
//  S&Cupid500
//
//  Created by Steven Su on 9/19/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var isSingle: Bool
    var couplePortfolio: [String]  // References to couple documents
}

struct Couple: Identifiable, Codable {
    @DocumentID var id: String?
    var user1ID: String
    var user2ID: String
}

class UserViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var couples: [Couple] = []
    
    private var db = Firestore.firestore()
    
    func fetchUser(userId: String) {
        db.collection("users").document(userId).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            if let user = try? document?.data(as: User.self) {
                self?.user = user
                self?.fetchCouples(forUser: user)
            }
        }
    }
    
    func fetchCouples(forUser user: User) {
        let coupleReferences = user.couplePortfolio
        
        coupleReferences.forEach { coupleID in
            db.collection("couples").document(coupleID).getDocument { [weak self] (document, error) in
                if let error = error {
                    print("Error fetching couple: \(error.localizedDescription)")
                    return
                }
                
                if let couple = try? document?.data(as: Couple.self) {
                    self?.couples.append(couple)
                }
            }
        }
    }
}





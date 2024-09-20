import Foundation
import FirebaseFirestore
import SwiftUI

enum Grade: String, Codable {
    case freshman
    case sophomore
    case junior
    case senior
}

struct Couple: Identifiable, Codable {
    var id: String?
    var user1ID: String
    var user2ID: String
    var name: String
    var howWeMet: String
    var emoji: String
    var dataset: [ChartData]
}

struct ChartData: Identifiable, Codable{
    let id: UUID
    let day: String
    let value: Double
}

struct User: Identifiable, Codable {
    var id: String?
    var name: String
    var isSingle: Bool
    var age: Int
    var year: Grade
    var couplePortfolio: [String]  // References to couple documents
}

class UserViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var couples: [Couple] = []
    @EnvironmentObject var authModel: AuthModel

    private var db = Firestore.firestore()
    
    init() {
        db.collection("users").document(authModel.useruid).getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, let user = try? document.data(as: User.self) else {
                print("User not found or failed to decode")
                return
            }
            
            self?.user = user  // Save the fetched user data
            
        }
    
    func fetchAllCouples() {
        db.collection("couples").getDocuments { [weak self] (snapshot, error) in
            if let error = error {
                print("Error fetching couples: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No couples found")
                return
            }
            
            self?.couples = documents.compactMap { document -> Couple? in
                var couple = try? document.data(as: Couple.self)
                couple?.id = document.documentID  // Manually assign document ID
                return couple
            }
        }
    }

    func fetchUserCouples() {
                // Step 2: Fetch couples referenced in the user's couplePortfolio array
        guard let user = self.user else {
                print("User is not available.")
                return
            }
                let coupleIDs = user.couplePortfolio
                let coupleCollection = self.db.collection("couples")
                
                var fetchedCouples: [Couple] = []
                
                let group = DispatchGroup() // To handle async fetching of multiple documents
                
                for coupleID in coupleIDs {
                    group.enter()
                    coupleCollection.document(coupleID).getDocument { (snapshot, error) in
                        if let error = error {
                            print("Error fetching couple: \(error.localizedDescription)")
                        } else if let snapshot = snapshot, let couple = try? snapshot.data(as: Couple.self) {
                            fetchedCouples.append(couple)  // Collect each fetched couple
                        }
                        group.leave()
                    }
                }
                
                // Once all couple fetches are done, update the published couples list
                group.notify(queue: .main) {
                    self.couples = fetchedCouples
                }
            }
        }
}

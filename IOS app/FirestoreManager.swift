//
//  FirestoreManager.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-11.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore

class FirestoreManager: ObservableObject {
    private let db = Firestore.firestore()
    
    // MARK: - User Profile Management
    func createUserProfile(userId: String, email: String, displayName: String) {
        let userData: [String: Any] = [
            "email": email,
            "displayName": displayName,
            "createdAt": Timestamp(),
            "lastLoginAt": Timestamp()
        ]
        
        db.collection("users").document(userId).setData(userData, merge: true) { error in
            if let error = error {
                print("Error creating user profile: \(error.localizedDescription)")
            } else {
                print("User profile created successfully")
            }
        }
    }
    
    func getUserProfile(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        db.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                completion(.success(document.data() ?? [:]))
            } else {
                completion(.failure(NSError(domain: "FirestoreManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
            }
        }
    }
    
    // MARK: - Generic Data Operations
    func addDocument(to collection: String, data: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        var ref: DocumentReference? = nil
        ref = db.collection(collection).addDocument(data: data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(ref!.documentID))
            }
        }
    }
    
    func updateDocument(collection: String, documentId: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collection).document(documentId).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func deleteDocument(collection: String, documentId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(collection).document(documentId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getDocuments(from collection: String, completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        db.collection(collection).getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let documents = querySnapshot?.documents.compactMap { $0.data() } ?? []
                completion(.success(documents))
            }
        }
    }
    
    // MARK: - Real-time Listeners
    func listenToCollection(_ collection: String, completion: @escaping (Result<[[String: Any]], Error>) -> Void) -> ListenerRegistration {
        return db.collection(collection).addSnapshotListener { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let documents = querySnapshot?.documents.compactMap { $0.data() } ?? []
                completion(.success(documents))
            }
        }
    }
}

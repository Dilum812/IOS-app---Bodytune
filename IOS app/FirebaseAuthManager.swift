//
//  FirebaseAuthManager.swift
//  IOS app
//
//  Created by Dilum Dissanayake on 2025-11-11.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftUI

class FirebaseAuthManager: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn = false
    
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        // Check if user is already signed in
        self.user = Auth.auth().currentUser
        self.isSignedIn = user != nil
        
        // Listen for authentication state changes
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.user = user
                self?.isSignedIn = user != nil
            }
        }
    }
    
    deinit {
        if let listener = authStateListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    // MARK: - Google Sign In
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("No client ID found in Firebase configuration")
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller!")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Failed to get Google ID token")
                return
            }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // Sign in to Firebase with Google credentials
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase Sign-In Error: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.user = authResult?.user
                    self?.isSignedIn = true
                    print("Successfully signed in with Google!")
                }
            }
        }
    }
    
    // MARK: - Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            DispatchQueue.main.async {
                self.user = nil
                self.isSignedIn = false
            }
            print("Successfully signed out")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    // MARK: - User Info
    var userDisplayName: String {
        return user?.displayName ?? "Unknown User"
    }
    
    var userEmail: String {
        return user?.email ?? "No Email"
    }
    
    var userPhotoURL: URL? {
        return user?.photoURL
    }
}

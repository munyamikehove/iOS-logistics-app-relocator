//
//  ViewRouter.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CryptoKit
import AuthenticationServices
import Foundation
import Combine
import WebKit
import UIKit
import AVKit

public protocol Fetcher {
  func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, URLError>
}

extension URLSession: Fetcher {
  public func dataTaskPublisher(for url: URL) -> AnyPublisher<Data, URLError> {
    self.dataTaskPublisher(for: url).map(\.data).eraseToAnyPublisher()
  }
}

class ViewRouter: NSObject, ASAuthorizationControllerPresentationContextProviding, ObservableObject {
    
    
    
    let db = Firestore.firestore()
    let objectWillChange = ObservableObjectPublisher()
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
    
    
    
    @Published var Moveday: Date = Date().addingTimeInterval(60 * 60 * 24 * 8){
        didSet {
            
            objectWillChange.send()
            
        }
       }
        
        
    
    
    @Published var currentView: String = "Login" {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    @Published var AboutAppCounter: Int = 1{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var OriginSelectorCounter: Int = 0{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var DestinationSelectorCounter: Int = 0{
        didSet {
            objectWillChange.send()
            
        }
       }
    
    @Published var originAddress: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var originAddressLat: Double = 0.0{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var originAddressLng: Double = 0.0{
        didSet {
            objectWillChange.send()
            
        }
       }
    
    @Published var destinationAddress: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var destinationAddressLat: Double = 0.0{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var userID: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var destinationAddressLng: Double = 0.0{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var shouldOpenPlacePicker = false{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var placePickerButton: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var placePickerString: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var placeIDOrigin: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var placeIDDestination: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var Tm2 :[String:Int] = [:]
    @Published var Tm3 :[String:Int] = [:]
    
    @Published var TruckDataPrimary = [
        TruckPrimary(itemName: "Other Items", itemCount: 0)
    ]{
        didSet {
            objectWillChange.send()
            
        }
    }
    @Published var lastView: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    
    @Published var displayDestinationAddress: String = "Loading..."{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var destinationType: String = ""{
            didSet {
                objectWillChange.send()
                
            }
           }
    @Published var distanceFromMidtownToronto: Int = 0 {
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var displayMoveDate: String = ""{
            didSet {
                objectWillChange.send()
                
            }
           }
    @Published var displayOriginAddress: String = "Loading..."{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var originToDestinationDistance: Int = 0 {
            didSet {
                objectWillChange.send()
                
            }
           }
    @Published var originType: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var displayEndTime: String = "4:30 PM"{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var movingDurationDisplay: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var movingCost: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var hst: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var totalCost: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var dueToday: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var dueOnMoveDay: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var paymentAuthCode: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var birthday: Date = Date(){
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var email: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var lastName: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var firstName: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var RelocatorPayCurrentView: String = "Relocator Pay Setup"{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var cdIssuer: String = "default"{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var lastFour: String = "no payment method"{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var whatSectionToShow: String = "main"{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var pm: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var cust: String = ""{
        didSet {
            objectWillChange.send()
            
        }
       }
    @Published var doesPaymentMethodExist: Bool = false{
        didSet {
            objectWillChange.send()
            
        }
       }
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
}

@available(iOS 13.0, *)
extension ViewRouter: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) {(authResult, error) in
                if (error != nil) {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    
                    
                    
                    print(" SIError is \(String(describing: error?.localizedDescription)) and current View is \(self.currentView)")
                    
                    print("Got here C ")
                    
                    self.currentView = "ErrorView"
                    self.objectWillChange.send()
                    
                    
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                
                self.db.collection("userData").document((authResult?.user.uid)!).collection("allUserDocuments").document("identification")
                    .getDocument { (document, error) in
                        if let document = document, document.exists {
                            self.AboutAppCounter = 1
                            self.currentView = "AboutFilabusi"
                            self.userID = (authResult?.user.uid)!
                            self.objectWillChange.send()
                        } else {
                            print("Document does not exist")
                            self.AboutAppCounter = 1
                            self.currentView = "AboutFilabusi"
                            self.userID = (authResult?.user.uid)!
                            self.objectWillChange.send()
                        }
                    }
                
                
                
                
                
                
                
            }
            
            
            
            
        }
    }
}

func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
    print("Sign in with Apple errored: \(error)")
}



// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}




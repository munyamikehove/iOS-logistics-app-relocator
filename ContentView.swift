//
//  ContentView.swift
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

struct ContentView: View {
    
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var user = Auth.auth().currentUser
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View {
        
        VStack(spacing: 0){
            
            switch viewRouter.currentView {
            case "StepTwo":
                StepTwo()
            case "AboutFilabusi":
                AboutFilabusi()
            case "ListOfOtherItems":
                ListOfOtherItems()
            case "Login":
                Login()
            case "StepOne":
                StepOne()
            case "StepThree":
                StepThree()
            case "TruckView":
                TruckView()
            case "NoServiceView":
                NoServiceView()
            case "StripeSetupView":
                StripeSetupView()
            case "PaymentsSetupView":
                PaymentsSetupView()
            default:
                Login()
            }
        }.onAppear{
            if user != nil{
                 // self.viewRouter.currentView = "StepTwo"
                 self.viewRouter.currentView = "AboutFilabusi"
                         }else{
                            // No user is signed in.
                            do {
                              try firebaseAuth.signOut()
                                self.viewRouter.currentView = "Login"
                            } catch let signOutError as NSError {
                              print ("Error signing out: %@", signOutError)
                            }
                             
                               

                         }
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}

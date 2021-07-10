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
    @State var user = Auth.auth().currentUser?.uid
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
            case "UpcomingMoves":
                UpcomingMoves()
            case "UpcomingMoveDetails":
                UpcomingMoveDetails()
            case "LandingPage":
                LandingPage()
            case "MoverSignUp":
                MoverSignUp()
            case "StepOneBusiness":
                StepOneBusiness()
            case "StepTwoBusiness":
                StepTwoBusiness()
            case "AddCustomerStepOne":
                AddCustomerStepOne()
            case "AddCustomerStepTwo":
                AddCustomerStepTwo()
            case "StepThreeBusiness":
                StepThreeBusiness()
            case "DeliveryRangeExceeded":
                DeliveryRangeExceeded()
            case "ViewDeliveryList":
                ViewDeliveryList()
            case "UpcomingDeliveries":
                UpcomingDeliveries()
            case "UpcomingDeliveryDetails":
                UpcomingDeliveryDetails()
            default:
                Login()
            }
        }.onAppear{
            
            let currentUser = Auth.auth().currentUser
            currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                if error != nil {
                // Handle error
                do {
                    try firebaseAuth.signOut()
                    self.viewRouter.currentView = "Login"
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                }
                return;
              }

              // token exists
                self.viewRouter.currentView = "LandingPage"
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}

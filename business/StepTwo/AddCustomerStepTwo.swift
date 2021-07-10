//
//  AddCustomerStepTwo.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-18.
//

import SwiftUI
import AlertToast
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import SDWebImageSwiftUI

struct AddCustomerStepTwo: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @State var functions = Functions.functions()
    @State var userID = Auth.auth().currentUser?.uid
    
    var body: some View {
        VStack(spacing:0){
            
            Customer_Creation_Success()
                .onAppear{
                    switch viewRouter.ServiceSelectorCounter{
                    case 1:
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").addSnapshotListener{ (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                
                                viewRouter.BusinessCustomersList.removeAll()
                                
                                for document in querySnapshot!.documents {
                                    
                                   
                                    let customerInfo : [String: Any] = document.data()
                                    
                                    let test = customerInfo["currentCustomerAddress"] as? String ?? "Loading Address..."
                                    if test == "Loading Address..."{
                                        
                                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(customerInfo["moveID"]as? String ?? "none")","userID":"\(viewRouter.userID)","pidO":"\(customerInfo["businessAddressPlaceID"]as? String ?? "none")","pidD":"\(customerInfo["customerAddressPlaceID"]as? String ?? "none")","target":"S\(viewRouter.ServiceSelectorCounter)"])
                                        { (result, error) in
                                            if let error = error as NSError? {
                                                if error.domain == FunctionsErrorDomain {
                                                    let code = FunctionsErrorCode(rawValue: error.code)
                                                    print("Error1 writing document: \(String(describing: code))")
                                                    let message = error.localizedDescription
                                                    print("Error2 writing document: \(String(describing: message))")
                                                    let details = error.userInfo[FunctionsErrorDetailsKey]
                                                    print("Error3 writing document: \(String(describing: details))")
                                                }
                                                // ...
                                            }
                                            
                                        }
                                        
                                    }else{
                                        
                                        viewRouter.BusinessCustomersList.append(BusinessDeliveryCustomers(name:"\(customerInfo["customerName"]as? String ?? "")",customerID:customerInfo["customerPhoneNumber"] as? String ?? "",customerAddress:customerInfo["currentCustomerAddress"] as? String ?? "Loading Address...",deliveryNotes:customerInfo["customerDeliveryNotes"] as? String ?? "",customerAddressPlaceID:customerInfo["customerAddressPlaceID"] as? String ?? ""))
                                        
                                        //viewRouter.businessPickupDisplayAddress
                                        viewRouter.businessPickupDisplayAddress = customerInfo["currentBusinessAddress"] as? String ?? "Loading Address..."
                                            
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                        
                                    }
                                    
                                    
                              
                                    
                                    
                                    
                                }
                            }
                            
                            
                        }
                    case 2:
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS2").addSnapshotListener{ (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                
                                viewRouter.BusinessCustomersList.removeAll()
                                
                                for document in querySnapshot!.documents {
                                    
                                   
                                    let customerInfo : [String: Any] = document.data()
                                    
                                  
                                    let test = customerInfo["currentCustomerAddress"] as? String ?? "Loading Address..."
                                    if test == "Loading Address..."{
                                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(customerInfo["moveID"]as? String ?? "none")","userID":"\(viewRouter.userID)","pidO":"\(customerInfo["businessAddressPlaceID"]as? String ?? "none")","pidD":"\(customerInfo["customerAddressPlaceID"]as? String ?? "none")","target":"S\(viewRouter.ServiceSelectorCounter)"])
                                        { (result, error) in
                                            if let error = error as NSError? {
                                                if error.domain == FunctionsErrorDomain {
                                                    let code = FunctionsErrorCode(rawValue: error.code)
                                                    print("Error1 writing document: \(String(describing: code))")
                                                    let message = error.localizedDescription
                                                    print("Error2 writing document: \(String(describing: message))")
                                                    let details = error.userInfo[FunctionsErrorDetailsKey]
                                                    print("Error3 writing document: \(String(describing: details))")
                                                }
                                                // ...
                                            }
                                            
                                        }
                                    }else{
                                        viewRouter.BusinessCustomersList.append(BusinessDeliveryCustomers(name:"\(customerInfo["customerName"]as? String ?? "")",customerID:customerInfo["customerPhoneNumber"] as? String ?? "",customerAddress:customerInfo["currentCustomerAddress"] as? String ?? "Loading Address...",deliveryNotes:customerInfo["customerDeliveryNotes"] as? String ?? "",customerAddressPlaceID:customerInfo["customerAddressPlaceID"] as? String ?? ""))
                                        
                                        //viewRouter.businessPickupDisplayAddress
                                        viewRouter.businessPickupDisplayAddress = customerInfo["currentBusinessAddress"] as? String ?? "Loading Address..."
                                            
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            
                            
                        }
                    case 3:
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS3").addSnapshotListener{ (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                
                                viewRouter.BusinessCustomersList.removeAll()
                                
                                for document in querySnapshot!.documents {
                                    
                                   
                                    let customerInfo : [String: Any] = document.data()
                                    
                                  
                                    let test = customerInfo["currentCustomerAddress"] as? String ?? "Loading Address..."
                                    if test == "Loading Address..."{
                                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(customerInfo["moveID"]as? String ?? "none")","userID":"\(viewRouter.userID)","pidO":"\(customerInfo["businessAddressPlaceID"]as? String ?? "none")","pidD":"\(customerInfo["customerAddressPlaceID"]as? String ?? "none")","target":"S\(viewRouter.ServiceSelectorCounter)"])
                                        { (result, error) in
                                            if let error = error as NSError? {
                                                if error.domain == FunctionsErrorDomain {
                                                    let code = FunctionsErrorCode(rawValue: error.code)
                                                    print("Error1 writing document: \(String(describing: code))")
                                                    let message = error.localizedDescription
                                                    print("Error2 writing document: \(String(describing: message))")
                                                    let details = error.userInfo[FunctionsErrorDetailsKey]
                                                    print("Error3 writing document: \(String(describing: details))")
                                                }
                                                // ...
                                            }
                                            
                                        }
                                    }else{
                                        viewRouter.BusinessCustomersList.append(BusinessDeliveryCustomers(name:"\(customerInfo["customerName"]as? String ?? "")",customerID:customerInfo["customerPhoneNumber"] as? String ?? "",customerAddress:customerInfo["currentCustomerAddress"] as? String ?? "Loading Address...",deliveryNotes:customerInfo["customerDeliveryNotes"] as? String ?? "",customerAddressPlaceID:customerInfo["customerAddressPlaceID"] as? String ?? ""))
                                        
                                        //viewRouter.businessPickupDisplayAddress
                                        viewRouter.businessPickupDisplayAddress = customerInfo["currentBusinessAddress"] as? String ?? "Loading Address..."
                                            
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                    }
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            
                            
                        }
                    default:
                        ()
                        
                    }
            }
            
        }
    }
}

struct Customer_Creation_Success: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isPresentingToast = false
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View{
        VStack(spacing:0){
            
            Image("correct")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160.0, height: 160.0)
                .padding(EdgeInsets(top: 80, leading: 10, bottom: 25, trailing: 10))
            
            
            Text("Customer added successfully.\n\nSelect 'Continue' to pick more customers from you existing customer list.\n\nSelect 'Add another customer' to add new customers to your customer list .")
                .font(.custom("Courier New", size: 18))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 25, leading: 10, bottom: 5, trailing: 10))
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                .fixedSize(horizontal: false, vertical: true)
            
            Button(action: {
                
                ref.child("businessQuickRef").child("\(viewRouter.userID)").setValue(["customerDistanceFromBusiness": nil])
                viewRouter.whatBusinessCustomerCreationSectionToShow = "main"
                viewRouter.customerFirstName = ""
                viewRouter.customerPhoneNumber = ""
                viewRouter.placeIDCustomer = ""
                viewRouter.customerDeliveryNotes = "Notes on Delivery: "
                viewRouter.customerDeliveryAddress = "Customer address here"
                self.viewRouter.currentView = "AddCustomerStepOne"
                
            }) {
                
                Text("Add another customer")
                    .font(.custom("Gill Sans Light", size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .padding(EdgeInsets(top: 30, leading: 30, bottom: 45, trailing: 30))
                
                //.fixedSize(horizontal: false, vertical: true)
                
            }
            
            
            Button(action: {
                
                ref.child("businessQuickRef").child("\(viewRouter.userID)").setValue(["customerDistanceFromBusiness": nil])
                viewRouter.whatBusinessCustomerCreationSectionToShow = "main"
                viewRouter.customerFirstName = ""
                viewRouter.customerPhoneNumber = ""
                viewRouter.placeIDCustomer = ""
                viewRouter.customerDeliveryNotes = "Notes on Delivery: "
                viewRouter.customerDeliveryAddress = "Customer address here"
                self.viewRouter.currentView = "StepTwoBusiness"
                
            }) {
                
                Text("CONTINUE")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .background(Color("bag1"))
                    .clipShape(Capsule())
                
            }
        }
    }
    
}

struct AddCustomerStepTwo_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomerStepTwo()
            .environmentObject(ViewRouter())
    }
}

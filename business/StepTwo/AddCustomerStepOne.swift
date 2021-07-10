//
//  AddCustomerStepOne.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-18.
//

import Foundation
import UIKit
import SwiftUI
import GooglePlaces
import Combine
import GoogleMaps
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseFunctions


struct AddCustomerStepOne: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingAlert = false
    @State var alertMessage = ""
    @State var userID = Auth.auth().currentUser?.uid
    
    @State var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
 
    @State var address = ""
    @State var currentPlaceID = ""
    @State var lat = 0.0
    @State var lng = 0.0
    
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @State var functions = Functions.functions()
    
    
    var body: some View {
        VStack(spacing:0){
            
            if viewRouter.whatBusinessCustomerCreationSectionToShow == "main" {
                ZStack{
                    
                    VStack(spacing: 0){
                        
                        VStack(spacing: 0){
                            
                          
                            HStack(spacing: 15){
                                
                                Button(action: {
                                    
                                    self.viewRouter.currentView = "StepTwoBusiness"
                                    
                                }, label: {
                                    
                                    Image(systemName: "arrow.left")
                                        .font(.title)
                                        .foregroundColor(.black)
                                })
                                
                                Spacer(minLength: 0)
                                
                                
                                Text("Add Customer")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                    .padding(.trailing,10)
                                
                                Spacer(minLength: 0)
                                
                            }
                            .padding()
                            //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                            .background(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        //stepTwoBody
                        ScrollView(.vertical, showsIndicators: false, content: {
                            
                            VStack{
                                
                                // Divider Line...
                                HStack{
                                    
                                    
                                    Text("CUSTOMER DETAILS")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("bag1"))
                                    
                                    
                                    
                                    
                                    
                                    Rectangle()
                                        .fill(Color("bag1").opacity(0.6))
                                        .frame(height: 0.5)
                                }
                                .padding()
                                
                                
                                
                                customerDetailsViews()
                                
                                Spacer().frame(height: 30)
                                
                               
                                
                                Divider().background(Color.black.opacity(0.45)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center)
                                
                                
                                
                                Button(action: {
                                    
                                    if viewRouter.customerFirstName != ""{
                                        if viewRouter.customerPhoneNumber != ""{
                                            if viewRouter.placeIDCustomer != ""{
                                                if viewRouter.customerDeliveryAddress != "Customer address here" {
                                                    viewRouter.whatBusinessCustomerCreationSectionToShow = "loadView"
                                                }else{
                                                    alertMessage = "Please add a customer address to continue"
                                                    showingAlert = true
                                                }
                                            }else{
                                                alertMessage = "Please add a customer address to continue"
                                                showingAlert = true
                                            }
                                        }else{
                                            alertMessage = "Please add a customer phone number to continue"
                                            showingAlert = true
                                        }
                                    }else{
                                        alertMessage = "Please add a customer name to continue"
                                        showingAlert = true
                                    }
                                    
                                    
                                    
                               
                                    
                                }) {
                                    
                                    Text("ADD CUSTOMER")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 50)
                                        .background(Color("bag1"))
                                        .clipShape(Capsule())
                                }
                                .padding(.top)
                                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                                
                                Spacer().frame(height: 25)
                                
                            }
                        })
                        //.background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
                        
                    }
                    .background(Color.white)
                    
                    
                    
                }
            }else if viewRouter.whatBusinessCustomerCreationSectionToShow == "loadView"{
                VStack{
                    
                    Text("Please Wait...")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    
                    ProgressView("Adding Customer")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(EdgeInsets(top: 50, leading: 10, bottom: 250, trailing: 10))
                    
                }
                .onReceive(timer) { time in
                    if self.counter == 5 {
                                       self.timer.upstream.connect().cancel()
                        sendToNewActivity()
                        
                                   }

                                   self.counter += 1
                    }
                .padding(EdgeInsets(top: 280, leading: 20, bottom: 0, trailing: 20))
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Hey there"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
        }
        .onAppear{
            viewRouter.userID = userID ?? "currentUser"
        }
        .background(Color.white)
        .sheet(isPresented: $viewRouter.shouldOpenPlacePicker)
            {
            PlacePicker(addressFromInput: $address, placeID: $currentPlaceID, addressLat: $lat, addressLng: $lng)
                .environmentObject(ViewRouter())
                .onDisappear {
                    if viewRouter.placePickerButton == "cu"{
                        if address != ""{
                            
                            functions.httpsCallable("customerZoneCalculator").call(["userID":"\(userID ?? "currentUser")","pidO":"\(viewRouter.placeIDBusiness)","pidD":"\(currentPlaceID)"])
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
                            
                        viewRouter.customerDeliveryAddress = address
                        viewRouter.placeIDCustomer = currentPlaceID
                        currentPlaceID = ""
                        address = ""
                        lat = 0.0
                        lng = 0.0
                            
                        }
                       
                    }
                  
                }
            
        }
    }
    
    func sendToNewActivity(){
        
        
    
        ref.child("businessQuickRef").child("\(viewRouter.userID)").getData{ (error, DataSnapshot) in
            
            if DataSnapshot.exists(){
                
                //print("ValueIs: hknujgku \(DataSnapshot)")
                
                let value = DataSnapshot.value as? NSDictionary
                let Distance = value?["customerDistanceFromBusiness"] as? Int ?? 0
                
                switch viewRouter.ServiceSelectorCounter{
                case 1:
                    if Distance > 5250{
                        self.viewRouter.currentView = "DeliveryRangeExceeded"
                    }else{
                        var ref: DocumentReference? = nil
                        
                        let docData: [String: Any] = [
                            
                            "customerName":viewRouter.customerFirstName,
                            "customerPhoneNumber": viewRouter.customerPhoneNumber,
                            "customerAddressPlaceID": viewRouter.placeIDCustomer,
                            "businessAddressPlaceID": viewRouter.placeIDBusiness,
                            "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                           
                            
                        ]
                        
                        ref = db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").addDocument(data: docData){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        let docDataTwo: [String: Any] = [
                            
                            "customerName":viewRouter.customerFirstName,
                            "customerPhoneNumber": viewRouter.customerPhoneNumber,
                            "customerAddressPlaceID": viewRouter.placeIDCustomer,
                            "businessAddressPlaceID": viewRouter.placeIDBusiness,
                            "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                            "moveID": "\(ref!.documentID)",
                            
                        ]
                        
                        
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").document("\(ref!.documentID)").setData(docDataTwo){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(ref!.documentID)","userID":"\(viewRouter.userID)","pidO":"\(viewRouter.placeIDBusiness)","pidD":"\(viewRouter.placeIDCustomer)","target":"S\(viewRouter.ServiceSelectorCounter)"])
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
                        
                    viewRouter.currentView  = "AddCustomerStepTwo"
                        
                    }
                case 2:
                    if Distance > 25500{
                        self.viewRouter.currentView = "DeliveryRangeExceeded"
                    }else{
                        var ref: DocumentReference? = nil
                        
                        let docData: [String: Any] = [
                            
                            "customerName":viewRouter.customerFirstName,
                            "customerPhoneNumber": viewRouter.customerPhoneNumber,
                            "customerAddressPlaceID": viewRouter.placeIDCustomer,
                            "businessAddressPlaceID": viewRouter.placeIDBusiness,
                            "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                           
                            
                        ]
                        
                        ref = db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS2").addDocument(data: docData){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        let docDataTwo: [String: Any] = [
                            
                            "customerName":viewRouter.customerFirstName,
                            "customerPhoneNumber": viewRouter.customerPhoneNumber,
                            "customerAddressPlaceID": viewRouter.placeIDCustomer,
                            "businessAddressPlaceID": viewRouter.placeIDBusiness,
                            "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                            "moveID": "\(ref!.documentID)",
                            
                        ]
                        
                        
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS2").document("\(ref!.documentID)").setData(docDataTwo){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(ref!.documentID)","userID":"\(viewRouter.userID)","pidO":"\(viewRouter.placeIDBusiness)","pidD":"\(viewRouter.placeIDCustomer)","target":"S\(viewRouter.ServiceSelectorCounter)"])
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
                        
                    viewRouter.currentView  = "AddCustomerStepTwo"
                        
                    }
                case 3:
                    if Distance > 51000{
                        self.viewRouter.currentView = "DeliveryRangeExceeded"
                    }else{
                        var ref: DocumentReference? = nil
                        
                        let docData: [String: Any] = [
                            
                            "customerName":viewRouter.customerFirstName,
                            "customerPhoneNumber": viewRouter.customerPhoneNumber,
                            "customerAddressPlaceID": viewRouter.placeIDCustomer,
                            "businessAddressPlaceID": viewRouter.placeIDBusiness,
                            "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                           
                            
                        ]
                        
                        ref = db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS3").addDocument(data: docData){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        let docDataTwo: [String: Any] = [
                            
                            "customerName":viewRouter.customerFirstName,
                            "customerPhoneNumber": viewRouter.customerPhoneNumber,
                            "customerAddressPlaceID": viewRouter.placeIDCustomer,
                            "businessAddressPlaceID": viewRouter.placeIDBusiness,
                            "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                            "moveID": "\(ref!.documentID)",
                            
                        ]
                        
                        
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS3").document("\(ref!.documentID)").setData(docDataTwo){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(ref!.documentID)","userID":"\(viewRouter.userID)","pidO":"\(viewRouter.placeIDBusiness)","pidD":"\(viewRouter.placeIDCustomer)","target":"S\(viewRouter.ServiceSelectorCounter)"])
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
                        
                    viewRouter.currentView  = "AddCustomerStepTwo"
                        
                    }
                default:
                    var ref: DocumentReference? = nil
                    
                    let docData: [String: Any] = [
                        
                        "customerName":viewRouter.customerFirstName,
                        "customerPhoneNumber": viewRouter.customerPhoneNumber,
                        "customerAddressPlaceID": viewRouter.placeIDCustomer,
                        "businessAddressPlaceID": viewRouter.placeIDBusiness,
                        "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                       
                        
                    ]
                    
                    ref = db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").addDocument(data: docData){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    let docDataTwo: [String: Any] = [
                        
                        "customerName":viewRouter.customerFirstName,
                        "customerPhoneNumber": viewRouter.customerPhoneNumber,
                        "customerAddressPlaceID": viewRouter.placeIDCustomer,
                        "businessAddressPlaceID": viewRouter.placeIDBusiness,
                        "customerDeliveryNotes": viewRouter.customerDeliveryNotes,
                        "moveID": "\(ref!.documentID)",
                        
                    ]
                    
                    
                    db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").document("\(ref!.documentID)").setData(docDataTwo){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":"\(ref!.documentID)","userID":"\(viewRouter.userID)","pidO":"\(viewRouter.placeIDBusiness)","pidD":"\(viewRouter.placeIDCustomer)","target":"S\(viewRouter.ServiceSelectorCounter)"])
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
                    
                viewRouter.currentView  = "AddCustomerStepTwo"
                }
                
                
                
                
            }
            
            
        }
    }
}

struct customerDetailsViews: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingAlert = false
    @State var alertMessage = ""
    @State var userID = Auth.auth().currentUser?.uid
    @State var text: String = ""
    
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @State var functions = Functions.functions()
    
    var body: some View{
        
        VStack(spacing: 0){
            
            VStack(spacing: 0){
                
                HStack{
                    
                    if viewRouter.customerDeliveryAddress == "Customer address here" {
                        Text("\(viewRouter.customerDeliveryAddress)")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .font(.system(size: 20))
                            .frame(minWidth: UIScreen.main.bounds.width-100,alignment: .leading)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .onTapGesture {
                                
                                viewRouter.placePickerButton = "cu"
                                print("Address kjhgkj none4: ", self.viewRouter.placePickerButton)
                                viewRouter.shouldOpenPlacePicker = true
                            }
                    }else{
                        Text("\(viewRouter.customerDeliveryAddress)")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                            .frame(minWidth: UIScreen.main.bounds.width-100,alignment: .leading)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .onTapGesture {
                                
                                viewRouter.placePickerButton = "cu"
                                print("Address kjhgkj none4: ", self.viewRouter.placePickerButton)
                                viewRouter.shouldOpenPlacePicker = true
                            }
                    }
                    
                   
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
                
               
                HStack{
                    
                    
                    TextField("Customer Name", text: $viewRouter.customerFirstName)
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                
                HStack{
                    
                    
                    TextField("Customer Phone number", text: $viewRouter.customerPhoneNumber)
                        .keyboardType(.numberPad)
                        .onReceive(Just(viewRouter.lastName)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            viewRouter.lastName = filtered
                                        }
                                }
                        .foregroundColor(Color.black)
                        .font(.system(size: 20))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                
                
               
                
                VStack{
                        
                TextEditor(text: $viewRouter.customerDeliveryNotes)
                               .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(EdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 10))
                                .frame(minWidth: 310,  maxWidth: 310, minHeight: 290, maxHeight: 290, alignment: .topLeading)
                    
                    Spacer()
                }
                .frame(height: 280)
                .overlay(
                    RoundedRectangle(cornerRadius: 5.0)
                        .stroke(Color.black, lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                

            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 600)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .gray, radius: 5, x: 2, y: 2)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        
    }
}

struct AddCustomerStepOne_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomerStepOne()
            .environmentObject(ViewRouter())
    }
}

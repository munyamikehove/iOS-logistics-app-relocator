//
//  StepOneBusiness.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-13.
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

struct StepOneBusiness: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingAlert = false
    @State var alertMessage = ""
    @State var userID = Auth.auth().currentUser?.uid
    
    @State var address = ""
    @State var currentPlaceID = ""
    @State var lat = 0.0
    @State var lng = 0.0
    
    @State var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @State var functions = Functions.functions()
    
    var body: some View {
        
        VStack(spacing:0){
            
            
            if viewRouter.whatBusinessStepOneSectionToShow == "main" {
                VStack{
                    
                    VStack(spacing: 0){
                        
                        ZStack{
                            
                            HStack(spacing: 15){
                                
                                Button(action: {
                                    self.viewRouter.AboutAppCounter = 1
                                    self.viewRouter.currentView = "LandingPage"
                                }, label: {
                                    
                                    Image(systemName: "arrow.left")
                                        .font(.title)
                                        .foregroundColor(.black)
                                })
                                
                                Spacer(minLength: 0)
                                
                                
                                
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                    
                                    Button(action: {}, label: {
                                        
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 35.0, height: 25.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5))
                                    })
                                    
                                    
                                })
                            }
                            
                            
                            
                            Text("Step 1")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding(.trailing,10)
                            
                            
                            
                        }
                        .padding()
                        //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .background(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        
                        
                        
                        
                        
                        
                    }
                    
                    ScrollView{
                        
                        
                        DateSelectorBusiness()
                        
                        Spacer().frame(height: 50)
                        
                        //Spacer().frame(height: 50)
                        
                        DeliveryServiceSelector()
                        
                        //Spacer().frame(height: 50)
                        
                        OriginBusinessAddress()
                        
                        Spacer().frame(height: 50)
                        
                        
                        
                        Button(action: {
                            
                            viewRouter.stepOneOrigin = "delivery"
                            
                            if viewRouter.ServiceSelectorCounter != 0{
                                print("jgbyhtfgcesxres 1")
                                if viewRouter.OriginBusinessAddress != "Dispatch address here"{
                                    print("jgbyhtfgcesxres 2")
                                    if viewRouter.existingBusinessAccount != true{
                                        print("jgbyhtfgcesxres 3")
                                    viewRouter.whatBusinessStepOneSectionToShow = "loadView"
                                    }else{
                                        print("jgbyhtfgcesxres 4")
                                        let formatter = DateFormatter()
                                        formatter.timeStyle = .none
                                        formatter.dateStyle = .full
                                        
                                        
                                        let dateString = formatter.string(from: viewRouter.deliveryDay)
                                        
                                        viewRouter.displayDeliveryDay = dateString
                                        
                                        viewRouter.inspectionDay = formatter.string(from: viewRouter.deliveryDay.addingTimeInterval(-7*24*60*60))

                                        
                                        self.viewRouter.currentView = "StepTwoBusiness"
                                    }
                                
                                }else{
                                    alertMessage = "Please enter the address you are shipping from"
                                    showingAlert = true
                                }
                                
                            }else{
                                alertMessage = "Please select an option from the 'what delivery service do you require' section of the form"
                                showingAlert = true
                                
                            }
                            
                            
                            
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
                        .padding(.top)
                        .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                    }
                    
                    
                }
            }else if viewRouter.whatBusinessStepOneSectionToShow == "loadView" {
                VStack{
                    
                    Text("Please Wait...")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    
                    ProgressView("Setting up your account")
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
        .sheet(isPresented: $viewRouter.shouldOpenPlacePicker)
        {
            PlacePicker(addressFromInput: $address, placeID: $currentPlaceID, addressLat: $lat, addressLng: $lng)
                .environmentObject(ViewRouter())
                .onDisappear {
                    if viewRouter.placePickerButton == "so"{
                        if address != ""{
                            
                            //viewRouter.whatBusinessStepOneSectionToShow = "loadView"
                            functions.httpsCallable("businessZoneCalculator").call(["userID":"\(userID ?? "currentUser")","pidO":"\(currentPlaceID)","pidD":"\(viewRouter.placeIDDestination)"])
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
                            
                            db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomers").getDocuments(){ (querySnapshot, error) in
                                if let error = error {
                                    print("Error getting documents: \(error)")
                                } else {
                                    for document in querySnapshot!.documents {
                                        
                                        
                                        let customerInfo : [String: Any] = document.data()
                                        
                                        
                                        functions.httpsCallable("newCustomerDistanceCalculator").call(["customerID":customerInfo["moveID"] as? String ?? "none","userID":"\(viewRouter.userID)","pidO":"\(viewRouter.placeIDBusiness)","pidD":customerInfo["customerAddressPlaceID"] as? String ?? "none"])
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
                                        
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                        
                                        
                                        
                                    }
                                }
                                
                                
                            }
                            
                            viewRouter.OriginBusinessAddress = address
                            viewRouter.placeIDBusiness = currentPlaceID
                            currentPlaceID = ""
                            address = ""
                            lat = 0.0
                            lng = 0.0
                            
                        }
                        
                    }
                    
                }
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Hey there"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
        }
        .onAppear{
            self.viewRouter.BusinessCustomersList.removeAll()
            viewRouter.userID = userID ?? "currentUser"
            viewRouter.selectedCustomers.removeAll()
            
            for item in viewRouter.BusinessCustomersList {
                
                if item.name == "Placeholder" && item.customerID == "Placeholder"{
                    //count = item.itemCount
                    viewRouter.BusinessCustomersList.removeAll(where: { $0.name == "Placeholder" })
                }
                
            }
            
        }
        
    }
    
    func sendToNewActivity(){
        
       
            ref.child("businessQuickRef").child("\(viewRouter.userID)").getData{ (error, DataSnapshot) in
                
                if DataSnapshot.exists(){
                    
                    //print("ValueIs: hknujgku \(DataSnapshot)")
                    
                    let value = DataSnapshot.value as? NSDictionary
                    let Distance = value?["distanceFromMidtownToronto"] as? Int ?? 0
                    
                    if Distance > 120000{
                        self.viewRouter.currentView = "NoServiceView"
                    }else{
                        let formatter = DateFormatter()
                        formatter.timeStyle = .none
                        formatter.dateStyle = .full
                        
                        
                        let dateString = formatter.string(from: viewRouter.deliveryDay)
                        
                        viewRouter.displayDeliveryDay = dateString
                        
                        viewRouter.inspectionDay = formatter.string(from: viewRouter.deliveryDay.addingTimeInterval(-5*24*60*60))

                        
                        self.viewRouter.currentView = "StepTwoBusiness"
                    }
                    
                    
                }else{
                    sendToNewActivity()
                }
                
                
            }
        
        
       
        
        
    }
}

struct DateSelectorBusiness: View {
    
    // Search Text...
    @State var searchQuery = ""
    
    // Offsets...
    @State var offset: CGFloat = 0
    // Start Offset...
    @State var startOffset: CGFloat = 0
    
    // to move title to center were getting the title Width...
    @State var titleOffset: CGFloat = 0
    
    // to get the scrollview padded from the top were going to get the height of the title Bar...
    @State var titleBarHeight: CGFloat = 0
    
    // to adopt for dark mode...
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var viewRouter: ViewRouter
    
    var closedRange: ClosedRange<Date> {
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: 98, to: Date())!
        let fiveDaysAgo = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        
        return fiveDaysAgo...twoDaysAgo
    }
    
    var body: some View {
        ZStack(alignment: .top){
            
            // moving the search bar to the top if user starts typing...
            
            VStack{
                
                
                VStack{
                    
                    // Divider Line...
                    HStack{
                        
                        Text("WHAT DAY ARE YOU DELIVERING TO YOUR CUSTOMERS")
                            .font(.body)
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color("bag1"))
                        
                        Rectangle()
                            .fill(Color("bag1").opacity(0.6))
                            .frame(height: 0.5)
                    }
                    .padding()
                    
                    HStack{
                        Text("Delivery Date")
                            .foregroundColor(Color.black)
                            //.font(.system(size: 24))
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        DatePicker("", selection: $viewRouter.deliveryDay, in: closedRange, displayedComponents: .date)
                            .background(Color.white)
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                    
                    
                    HStack{
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.black)
                            .frame(width: 18, height: 18)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        
                        
                        Text("All deliveries are picked at 11:30 AM")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    
                }
                
                
            }
            .zIndex(1)
            
            .background(
                
                ZStack{
                    
                    let color = scheme == .dark ? Color.black : Color.white
                    
                    LinearGradient(gradient: .init(colors: [color,color,color,color,color.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                }
                .ignoresSafeArea()
            )
            
            
            
            
        }
    }
}



struct DeliveryServiceSelector: View {
    
    // Search Text...
    @State var searchQuery = ""
    
    // Offsets...
    @State var offset: CGFloat = 0
    // Start Offset...
    @State var startOffset: CGFloat = 0
    
    // to move title to center were getting the title Width...
    @State var titleOffset: CGFloat = 0
    
    // to get the scrollview padded from the top were going to get the height of the title Bar...
    @State var titleBarHeight: CGFloat = 0
    
    // to adopt for dark mode...
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ZStack(alignment: .top){
            
            // moving the search bar to the top if user starts typing...
            
            VStack{
                
                
                VStack{
                    
                    // Divider Line...
                    HStack{
                        
                        Text("WHAT DELIVERY SERVICE DO YOU REQUIRE?")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("bag1"))
                        
                        Rectangle()
                            .fill(Color("bag1").opacity(0.6))
                            .frame(height: 0.5)
                    }
                    .padding()
                    
                }
                
            }
            .zIndex(1)
            
            .background(
                
                ZStack{
                    
                    let color = scheme == .dark ? Color.black : Color.white
                    
                    LinearGradient(gradient: .init(colors: [color,color,color,color,color.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                }
                .ignoresSafeArea()
            )
            
            
            VStack(spacing: 15){
                
                // dont use this filter method...
                // its just for tutorial...
                
                ForEach(BusinessServiceTypes){ServiceType in
                    // housetype Card Row View.....
                    ServiceTypeRowView(serviceType: ServiceType)
                }
            }
            .frame( height: 420)
            .padding(.top,10)
            
        }
    }
    
    
}

struct OriginBusinessAddress: View {
    
    // Search Text...
    @State var searchQuery = ""
    
    // Offsets...
    @State var offset: CGFloat = 0
    // Start Offset...
    @State var startOffset: CGFloat = 0
    
    // to move title to center were getting the title Width...
    @State var titleOffset: CGFloat = 0
    
    // to get the scrollview padded from the top were going to get the height of the title Bar...
    @State var titleBarHeight: CGFloat = 0
    
    // to adopt for dark mode...
    @Environment(\.colorScheme) var scheme
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        ZStack(alignment: .top){
            
            // moving the search bar to the top if user starts typing...
            
            VStack{
                
                
                VStack{
                    
                    // Divider Line...
                    HStack{
                        
                        if !viewRouter.existingBusinessAccount {
                        Text("WHAT ADDRESS ARE YOU SHIPPING FROM?")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("bag1"))
                        }else{
                            Text("DISPATCH ADDRESS")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("bag1"))
                        }
                        
                       
                        
                        
                        
                        Rectangle()
                            .fill(Color("bag1").opacity(0.6))
                            .frame(height: 0.5)
                    }
                    .padding()
                    
                    HStack{
                        
                        
                        
                        
                        HStack{
                            
                            if !viewRouter.existingBusinessAccount {
                                Text("\(viewRouter.OriginBusinessAddress)")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 20))
                                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        
                                        if !viewRouter.existingBusinessAccount {
                                            viewRouter.placePickerButton = "so"
                                            print("Address kjhgkj none4: ", self.viewRouter.placePickerButton)
                                            viewRouter.shouldOpenPlacePicker = true
                                        }
                                        
                                    }
                                
                                Spacer()
                            }else{
                                Text("\(viewRouter.OriginBusinessAddress)")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 20))
                                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        
                                        if !viewRouter.existingBusinessAccount {
                                            viewRouter.placePickerButton = "so"
                                            print("Address kjhgkj none4: ", self.viewRouter.placePickerButton)
                                            viewRouter.shouldOpenPlacePicker = true
                                        }
                                        
                                    }
                                
                                Spacer()
                            }
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    if !viewRouter.existingBusinessAccount {
                        HStack{
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.black)
                                .frame(width: 18, height: 18)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                            
                            
                            
                            Text("Once set, you can only change your dispatch address by contacting customer support.")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                    }else{
                        HStack{
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.black)
                                .frame(width: 18, height: 18)
                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                            
                            
                            
                            Text("Contact customer support to change your dispatch address.")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                    }
                    
                    
                }
                
                
            }
            .zIndex(1)
            
            
            .background(
                
                ZStack{
                    
                    let color = scheme == .dark ? Color.black : Color.white
                    
                    LinearGradient(gradient: .init(colors: [color,color,color,color,color.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                }
                .ignoresSafeArea()
            )
            
            
            
            
        }
        
    }
    
    
}



struct BusinessDeliveryCustomers: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var customerID: String
    var customerAddress: String
    var deliveryNotes: String
    var customerAddressPlaceID: String
    
}

var BusinessCustomersList = [
    
    
    BusinessDeliveryCustomers(name: "Placeholder", customerID: "Placeholder", customerAddress:"Placeholder",deliveryNotes:"Placeholder",customerAddressPlaceID: "Placeholder"),
    
    
]

struct StepOneBusiness_Previews: PreviewProvider {
    static var previews: some View {
        StepOneBusiness()
            .environmentObject(ViewRouter())
    }
}

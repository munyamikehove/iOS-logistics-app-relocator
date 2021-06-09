//
//  File.swift
//  Upscale
//
//  Created by Munyaradzi Hove on 2021-05-03.
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

struct StepOne: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingAlert = false
    @State var alertMessage = ""
    @State var userID = Auth.auth().currentUser?.uid
    
    @State var address = ""
    @State var currentPlaceID = ""
    @State var lat = 0.0
    @State var lng = 0.0
    
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @State var functions = Functions.functions()
    
    var body: some View {
        
        VStack{
            
            VStack(spacing: 0){
                
                ZStack{
                    
                    HStack(spacing: 15){
                        
                        Button(action: {
                            self.viewRouter.AboutAppCounter = 1
                            self.viewRouter.currentView = "AboutFilabusi"
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
                
                
                DateSelector()
                
                Spacer().frame(height: 50)
                
                OriginSelector()
                
                //Spacer().frame(height: 50)
                
                DestinationSelector()
                
                //Spacer().frame(height: 50)
                
                OriginAddress()
                
                Spacer().frame(height: 50)
                
                DestinationAddress()
                
                Button(action: {
                    //self.viewRouter.currentView = "TruckView"
                  
                    if viewRouter.OriginSelectorCounter != 0{
                        if viewRouter.DestinationSelectorCounter != 0{
                            if !viewRouter.originAddress.isEmpty{
                                if !viewRouter.destinationAddress.isEmpty{

                                    let formatter = DateFormatter()
                                    formatter.timeStyle = .none
                                    formatter.dateStyle = .full
                                    let dateString = formatter.string(from: viewRouter.Moveday)

                                    ref.child("QuickRef").child("\(viewRouter.userID)").setValue(["originType": "\(viewRouter.OriginSelectorCounter)","destinationType": "\(viewRouter.DestinationSelectorCounter)","moveDate":"\(dateString)"])
                                    
                                    functions.httpsCallable("distanceCalculator").call(["userID":"\(userID ?? "currentUser")","pidO":"\(viewRouter.placeIDOrigin)","pidD":"\(viewRouter.placeIDDestination)"])
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

                                    
                                    functions.httpsCallable("zoneCalculator").call(["userID":"\(userID ?? "currentUser")","pidO":"\(viewRouter.placeIDOrigin)","pidD":"\(viewRouter.placeIDDestination)"])
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

                                    self.viewRouter.currentView = "StepTwo"

                                }else{
                                    alertMessage = "Please enter the address you are moving to"
                                    showingAlert = true
                                }
                            }else{
                                alertMessage = "Please enter the address you are moving from"
                                showingAlert = true
                            }
                        }else{
                            alertMessage = "Please select an option from the 'what house type are moving to' section of the form"
                            showingAlert = true
                        }
                    }else{
                        alertMessage = "Please select an option from the 'what house type are moving from' section of the form"
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
        .sheet(isPresented: $viewRouter.shouldOpenPlacePicker)
            {
            PlacePicker(addressFromInput: $address, placeID: $currentPlaceID, addressLat: $lat, addressLng: $lng)
                .environmentObject(ViewRouter())
                .onDisappear {
                    if viewRouter.placePickerButton == "mo"{
                        viewRouter.originAddress = address
                        viewRouter.originAddressLat = lat
                        viewRouter.originAddressLng = lng
                        viewRouter.placeIDOrigin = currentPlaceID
                        currentPlaceID = ""
                        address = ""
                        lat = 0.0
                        lng = 0.0
                       
                    }else if self.viewRouter.placePickerButton == "mi"{
                        viewRouter.destinationAddress = address
                        viewRouter.destinationAddressLat = lat
                        viewRouter.destinationAddressLng = lng
                        viewRouter.placeIDDestination = currentPlaceID
                        currentPlaceID = ""
                        address = ""
                        lat = 0.0
                        lng = 0.0
                    }
                  
                }
            
        }
        .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Hey there"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
                    }
        .onAppear{
        
            viewRouter.userID = userID ?? "currentUser"
        }
        
    }
    
    
}

struct DateSelector: View {
    
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
        let fiveDaysAgo = Calendar.current.date(byAdding: .day, value: 8, to: Date())!
        
        return fiveDaysAgo...twoDaysAgo
    }
    
    var body: some View {
        ZStack(alignment: .top){
            
            // moving the search bar to the top if user starts typing...
            
            VStack{
                
                
                VStack{
                    
                    // Divider Line...
                    HStack{
                        
                        Text("WHAT DAY ARE YOU MOVING OUT?")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("bag1"))
                        
                        Rectangle()
                            .fill(Color("bag1").opacity(0.6))
                            .frame(height: 0.5)
                    }
                    .padding()
                    
                    HStack{
                        Text("Move Date")
                            .foregroundColor(Color.black)
                            //.font(.system(size: 24))
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        DatePicker("", selection: $viewRouter.Moveday, in: closedRange, displayedComponents: .date)
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
                        
                        
                        
                        Text("All moves start at 9am")
                            .font(.body)
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
            
            
            //                VStack(spacing: 15){
            //
            //                    // dont use this filter method...
            //                    // its just for tutorial...
            //
            //                }
            //                .padding(.top,10)
            
        }
    }
}

struct OriginSelector: View {
    
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
                        
                        Text("WHERE ARE YOU MOVING FROM?")
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
                
                ForEach(MoveInHouseTypes) {HouseType in
                   //  housetype Card Row View.....
                    HouseTypeRowView(houseType: HouseType)
                }
                    
            }
            .frame( height: 450)
            .padding(.top,10)
            
            
        }
    }
    
    
}

struct DestinationSelector: View {
    
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
                        
                        Text("WHERE ARE YOU MOVING TO?")
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
                
                ForEach(MoveOutHouseTypes){HouseType in
                    // housetype Card Row View.....
                    HouseTypeRowView(houseType: HouseType)
                }
            }
            .frame( height: 450)
            .padding(.top,10)
            
        }
    }
    
    
}

struct OriginAddress: View {
    
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
    
    var body: some View {
        ZStack(alignment: .top){
            
            // moving the search bar to the top if user starts typing...
            
            VStack{
                
                
                VStack{
                    
                    // Divider Line...
                    HStack{
                        
                        if viewRouter.OriginSelectorCounter == 6 || viewRouter.OriginSelectorCounter == 7 {
                            Text("WHAT ADDRESS ARE YOU SHIPPING FROM?")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("bag1"))
                            
                        }else{
                            Text("WHAT ADDRESS ARE YOU MOVING FROM?")
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
                        //                        Text("Move-out address")
                        //                            .foregroundColor(Color.black)
                        //                            //.font(.system(size: 24))
                        //                            .fontWeight(.bold)
                        //                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        if viewRouter.OriginSelectorCounter == 6 || viewRouter.OriginSelectorCounter == 7 {
                            TextField("Ship-out address here", text: $viewRouter.originAddress)
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                                .onTapGesture {
                                    
                                    viewRouter.placePickerButton = "mo"
                                    print("Address kjhgkj none4: ", self.viewRouter.placePickerButton)
                                    viewRouter.shouldOpenPlacePicker = true
                                }
                            
                            
                        }else{
                            TextField("Move-out address here", text: $viewRouter.originAddress)
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                                .onTapGesture {
                                    viewRouter.placePickerButton = "mo"
                                    print("Address kjhgkj none4: ", self.viewRouter.placePickerButton)
                                    viewRouter.shouldOpenPlacePicker = true
                                }
                        }
                       
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
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
            
            
            //                VStack(spacing: 15){
            //
            //                    // dont use this filter method...
            //                    // its just for tutorial...
            //
            //                    ForEach(searchQuery == "" ? MoveInHouseTypes : MoveInHouseTypes.filter{$0.name.lowercased().contains(searchQuery.lowercased())}){HouseType in
            //
            //                        // Friend Card Row View.....
            //                        HouseTypeRowView(houseType: HouseType)
            //
            //                    }
            //                }
            //                .padding(.top,10)
            //                .padding(.top,10)
            
        }
    }
    
    
}

struct DestinationAddress: View {
    
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
    
    var body: some View {
        ZStack(alignment: .top){
            
            // moving the search bar to the top if user starts typing...
            
            VStack{
                
                
                VStack{
                    
                    // Divider Line...
                    HStack{
                        
                        if viewRouter.OriginSelectorCounter == 6 || viewRouter.OriginSelectorCounter == 7 {
                            Text("WHAT ADDRESS ARE YOU SHIPPING TO?")
                                .font(.body)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(Color("bag1"))
                            
                        }else{
                            Text("WHAT ADDRESS ARE YOU MOVING TO?")
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
                        //                        Text("Move-in address")
                        //                            .foregroundColor(Color.black)
                        //                            //.font(.system(size: 24))
                        //                            .fontWeight(.bold)
                        //                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        if viewRouter.OriginSelectorCounter == 6 || viewRouter.OriginSelectorCounter == 7 {
                            
                            TextField("Delivery address here", text: $viewRouter.destinationAddress)
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                                .onTapGesture {
                                    viewRouter.placePickerButton = "mi"
                                    print("Address kjhgkj none3: ", self.viewRouter.placePickerButton)
                                    viewRouter.shouldOpenPlacePicker = true
                                }
                            
                        }else{
                            TextField("Move-in address here", text: $viewRouter.destinationAddress)
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                                .onTapGesture {
                                    viewRouter.placePickerButton = "mi"
                                    print("Address kjhgkj none3: ", self.viewRouter.placePickerButton)
                                    viewRouter.shouldOpenPlacePicker = true
                                }
                        }
                        
                     
                        
                        
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Spacer().frame(height: 50)
                    
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
            
            
            //                VStack(spacing: 15){
            //
            //                    // dont use this filter method...
            //                    // its just for tutorial...
            //
            //                    ForEach(searchQuery == "" ? MoveOutHouseTypes : MoveOutHouseTypes.filter{$0.name.lowercased().contains(searchQuery.lowercased())}){HouseType in
            //
            //                        // Friend Card Row View.....
            //                        HouseTypeRowView(houseType: HouseType)
            //                    }
            //                }
            //                .padding(.top,10)
            
        }
    }
    
    
}

struct StepOne_Previews: PreviewProvider {
    static var previews: some View {
        StepOne()
            .environmentObject(ViewRouter())
    }
}

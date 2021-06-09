//
//  Home.swift
//  Upscale
//
//  Created by Munyaradzi Hove on 2021-05-02.
//

import SwiftUI
import AlertToast
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase


struct StepTwo: View {
    
    
    @State var selectedTab = scroll_Tabs[0]
    @Namespace var animation
    @State var show = false
    @State var selectedItem : ItemsModel!
    @EnvironmentObject var viewRouter: ViewRouter
    @State var alertMessage = ""
    @State var showToast = false
    @State var showTruckLoaded = false
    
    
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View {
        
        
        ZStack{
            
            VStack(spacing: 0){
                
                VStack(spacing: 0){
                    
                    ZStack{
                        
                        HStack(spacing: 15){
                            
                            Button(action: {
                                self.viewRouter.currentView = "StepOne"
                                
                            }, label: {
                                
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer(minLength: 0)
                            
                            
                            
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                
                                Button(action: {
                                    if viewRouter.TruckDataPrimary.count >= 1 {
                                        self.viewRouter.currentView = "TruckView"
                                        self.viewRouter.lastView = "StepTwo"
                                    }else{
                                        alertMessage = "Moving truck is empty"
                                        showToast = true
                                    }
                                }, label: {
                                    
                                    Image("truck")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 35.0, height: 25.0)
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5))
                                })
                                
                                if viewRouter.TruckDataPrimary.count >= 1 {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 15, height: 15)
                                        .offset(x: -26, y: -7)
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5))
                                }
                            })
                        }
                        
                        
                        
                        Text("Step 2")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.trailing,10)
                        
                        
                        
                    }
                    .padding()
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                    Divider().background(Color.black).frame(width: 140)
                    
                    HStack{
                        
                        Spacer()
                        
                        Button(action: {
                            self.viewRouter.AboutAppCounter = 2
                            self.viewRouter.currentView = "AboutFilabusi"
                        }, label: {
                            HStack(spacing:0){
                                
                                Text("Tap here for help")
                                    .font(.title3)
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                    .padding(.trailing,10)
                                
                                Image(systemName: "questionmark.circle")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                            }
                        })
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color.white)
                    
                }
                
              
                
                
                //stepTwoBody
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack{
                        
                        // Divider Line...
                        HStack{
                            
                           
                                Text("ADD ITEMS TO THE MOVING TRUCK")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("bag1"))
                                
                           
                            
                    
                            
                            Rectangle()
                                .fill(Color("bag1").opacity(0.6))
                                .frame(height: 0.5)
                        }
                        .padding()
                        
                        
                        //Horizontal Tabs above items
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            
                            HStack(spacing: 15){
                                
                                ForEach(scroll_Tabs,id: \.self){tab in
                                    
                                    // Tab Button...
                                    
                                    TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top,10)
                        })
                        
                        
                        //Recycle hero view of all the items in a category
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 2),spacing: 15){
                            
                            
                            if selectedTab == "All Items" {
                                ForEach(all_items){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                                
                                
                            } else if selectedTab == "Living & Dining" {
                                ForEach(living_dining){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                                
                            } else if selectedTab == "Kitchen & Laundry" {
                                ForEach(kitchen_laundry){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                                
                            } else if selectedTab == "Bedroom" {
                                ForEach(bedroom){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                                
                            } else if selectedTab == "Office & Bedroom" {
                                ForEach(office_bedroom){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                                
                            } else if selectedTab == "Garage & Outside" {
                                ForEach(garage_outside){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                                
                            }else if selectedTab == "Basement & Garage" {
                                ForEach(basement_garage){item in
                                    
                                    ItemView(itemData: item,animation: animation)
                                        .onTapGesture {
                                            
                                            withAnimation(.easeIn){
                                                
                                                selectedItem = item
                                                show.toggle()
                                            }
                                        }
                                }
                            }
                            
                            
                        }
                        .padding()
                        .padding(.top,10)
                        
                        Button(action: {
                            if viewRouter.TruckDataPrimary.count >= 1 {
                                
                                
                                self.viewRouter.currentView = "StepThree"
                                
                            }else{
                                alertMessage = "Moving truck is empty"
                                showToast = true
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
                })
                
            }
            .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
            
            if selectedItem != nil && show{
                
                DetailView(itemData: $selectedItem, show: $show,animation: animation)
            }
        }
        .onAppear{
            
          
            
            if user != nil{
                
                self.viewRouter.userID = user!.uid
                
                if !viewRouter.userID.isEmpty {
                    
                    
                    
                    //Move information
                    ref.child("QuickRef").child("\(viewRouter.userID)").observe(.value) { (DataSnapshot) in
                        
                        if DataSnapshot.exists(){
                            
                            //print("ValueIs: hknujgku \(DataSnapshot)")
                            
                            let value = DataSnapshot.value as? NSDictionary
                            let Distance = value?["distanceFromMidtownToronto"] as? Int ?? 0
                            
                            viewRouter.displayDestinationAddress = value?["destinationAddress"] as? String ?? ""
                            viewRouter.destinationType = value?["destinationType"] as? String ?? ""
                            viewRouter.distanceFromMidtownToronto = value?["distanceFromMidtownToronto"] as? Int ?? 0
                            viewRouter.displayMoveDate = value?["moveDate"] as? String ?? ""
                            viewRouter.displayOriginAddress = value?["originAddress"] as? String ?? ""
                            viewRouter.originToDestinationDistance = value?["originToDestinationDistance"] as? Int ?? 0
                            viewRouter.originType = value?["originType"] as? String ?? ""
                            
                            
                            if Distance > 120000{
                                self.viewRouter.currentView = "NoServiceView"
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
            for item in viewRouter.TruckDataPrimary {
                
                if item.itemName == "Other Items" && item.itemCount == 0{
                    //count = item.itemCount
                    viewRouter.TruckDataPrimary.removeAll(where: { $0.itemName == "Other Items" })
                }
                
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        .toast(isPresenting: $showToast){
            
            // `.alert` is the default displayMode
            AlertToast(displayMode: .hud, type: .regular, title: "\(alertMessage)")
            
            //Choose .hud to toast alert from the top of the screen
            //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
        }
    }
}






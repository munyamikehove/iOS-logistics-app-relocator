//
//  ViewDeliveryList.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-21.
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

struct ViewDeliveryList: View {
    
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
        ZStack{
            
            VStack(spacing: 0){
                
                VStack(spacing: 0){
                    
                    
                    HStack(spacing: 15){
                        
                        Button(action: {
                            
                            if viewRouter.deliveryListOrigin == "stepthree"{
                                self.viewRouter.whatBusinessSectionToShow = "main"
                                self.viewRouter.currentView = "StepThreeBusiness"
                            }else{
                                self.viewRouter.whatBusinessSectionToShow = "main"
                                self.viewRouter.currentView = "UpcomingDeliveryDetails"
                            }
                            
                            
                        }, label: {
                            
                            Image(systemName: "arrow.left")
                                .font(.title)
                                .foregroundColor(.black)
                        })
                        
                        Spacer(minLength: 10)
                        
                        
                        Text("\(viewRouter.displayDeliveryDay)")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .padding(.trailing,10)
                        
                        
                        
                        Spacer(minLength: 0)
                        
//                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
//
//                            Button(action: {
//                                //self.viewRouter.currentView = "AddCustomerStepOne"
//                            }, label: {
//
//                                Image("")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 35.0, height: 25.0)
//                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5))
//                            })
//
//
//                        })
                        
                    }
                    .padding()
                    //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                    
                    
                    
                    
                    
                }
                
                
                
                
                //stepTwoBody
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    VStack{
                        
                        // Divider Line...
                        HStack{
                            
                            
                            Text("CUSTOMERS YOU ARE DELIVERING TO")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("bag1"))
                            
                            
                            
                            
                            
                            Rectangle()
                                .fill(Color("bag1").opacity(0.6))
                                .frame(height: 0.5)
                        }
                        .padding()
                        
                        
                        
                        CustomerViewBusiness()
                        
                        Spacer().frame(height: 30)
                        
                        
                        
                        Divider().background(Color.black.opacity(0.45)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center)
                        
                        
                    }
                })
                //.background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
                
                
                
//                Button(action: {
//
//
//                    //viewRouter.BusinessCustomersList
//                    if viewRouter.selectedCustomers.count > 0{
//
//                        self.viewRouter.currentView = "StepThreeBusiness"
//                    }
//
//                }) {
//
//                    Text("CONTINUE")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 50)
//                        .background(Color("bag1"))
//                        .clipShape(Capsule())
//                }
//                .padding(.top)
//                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                
            }
            .background(Color.white)
            
            
            
        }
        
    }
}

struct CustomerViewBusiness: View {
    
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
        VStack{
            
            
            VStack(spacing: 15){
                
                // dont use this filter method...
                // its just for tutorial...
                
                ForEach(viewRouter.BusinessCustomersList) {BusinessCustomer in
                    //  housetype Card Row View.....
                    CustomersRowView(businessCustomer: BusinessCustomer)
                }
                
            }
            //.frame( height: 450)
            .padding(.top,10)
           
        }
    }
    
    
}

struct CustomersRowView: View {
    
    @State var businessCustomer: BusinessDeliveryCustomers
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        HStack(spacing:15){
            
            if viewRouter.selectedCustomers.keys.contains(businessCustomer.customerID)
            {
                VStack(alignment: .leading, spacing: 8, content: {
                    
                    Text(businessCustomer.name)
                        .fontWeight(.bold)
                    
                    Text(businessCustomer.customerID)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(businessCustomer.customerAddress)
                        .font(.caption)
                        .foregroundColor(.gray)
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Text("$ \(String(format: "%.2f", viewRouter.deliveryCostPerCustomer[businessCustomer.customerID]!)) CAD")
                    .fontWeight(.bold)
            }
            
         
//            Button(action: {
//                if viewRouter.selectedCustomers.keys.contains(businessCustomer.customerID)
//                {
//                    viewRouter.selectedCustomers.removeValue(forKey: businessCustomer.customerID)
//                }else{
//                    viewRouter.selectedCustomers[businessCustomer.customerID] = [businessCustomer.customerID:businessCustomer.customerAddressPlaceID]
//                }
//            }, label: {
//
//                if viewRouter.selectedCustomers.keys.contains(businessCustomer.customerID){
//                    Image("")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .foregroundColor(Color.green)
//                        .padding()
//                        .background(Color.green)
//                        .clipShape(Circle())
//                        .frame(width: 25.0, height: 25.0)
//                }else{
//                    Image("")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .foregroundColor(Color.black)
//                        .padding()
//                        .background(Color.gray.opacity(0.2))
//                        .clipShape(Circle())
//                        .frame(width: 25.0, height: 25.0)
//                }
                
                
//            })
            
            
            
            
            
        }
        .onAppear{
            print("jhkwegbjyec BC2: \(businessCustomer.customerID)")
              print("jhkwegbjyec DC2: \(viewRouter.deliveryCostPerCustomer)")
            print("jhkwegbjyec VRBC2: \(viewRouter.BusinessCustomersList)")
            
        }
        .padding(.horizontal)
        
        
        
    }
}

struct ViewDeliveryList_Previews: PreviewProvider {
    static var previews: some View {
        ViewDeliveryList().environmentObject(ViewRouter())
    }
}

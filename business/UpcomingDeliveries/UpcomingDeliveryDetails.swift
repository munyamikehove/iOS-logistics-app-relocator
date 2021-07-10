//
//  UpcomingDeliveryDetails.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-07-07.
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

struct UpcomingDeliveryDetails: View {
    
    @State var user = Auth.auth().currentUser
    @State var db = Firestore.firestore()
    @State var functions = Functions.functions()
    @EnvironmentObject var viewRouter: ViewRouter
    @State var allMoves : individualMoves = movesDataPrimary[0]
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    var body: some View {
        
        VStack{
            
            ZStack{
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        self.viewRouter.AboutAppCounter = 1
                        self.viewRouter.currentView = "UpcomingDeliveries"
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
                
                
                
                Text("\(viewRouter.displayDeliveryDay)")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.trailing,10)
                
                
                
            }
            .padding()
            //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack{
                    upcomingDeliveryDetailsViews()
                    
                    Spacer().frame(height: 30)
                    
                    upcomingDeliveryQuoteViews()
                    
                    //Spacer().frame(height: 20)
                    
                    upcomingDeliveryPaidSumView()
                    
                    //Spacer().frame(height: 20)
                    
                    upcomingDeliveryProjectManagerView()
                    
                    Spacer().frame(height: 100)
                }
            }).background(Color.black.opacity(0.09))
            
            
        }
        .onAppear{
            
            viewRouter.deliveryListOrigin = "upcoming"
            
            db.collection("userData").document("\(viewRouter.userID)").collection("confirmedBusinessMoves").document("\(viewRouter.currentMoveID)").addSnapshotListener{ (document, error) in
                
                if let document = document, document.exists {
                    let resultingData : [String: Any] = document.data()!
                    
                    //
                    
                    viewRouter.totalDeliveryCost = resultingData["moveWithoutHst"] as! Double
                    viewRouter.displayDeliveryDay  = resultingData["deliveryDate"] as! String
                    viewRouter.serviceTypeMovers  = resultingData["manPower"] as! String
                    viewRouter.serviceTypeVehicle  = resultingData["truckFeet"] as! String
                    viewRouter.ServiceSelectorCounter = resultingData["ServiceSelectorCounter"] as! Int
                    viewRouter.inspectionDay  = resultingData["inspectionDate"] as! String
                    viewRouter.businessPickupDisplayAddress = resultingData["originAddress"] as! String
                    let customersOnDeliveryRoute = resultingData["selectedCustomers"] as! [String:Any]
                    for (key,value) in customersOnDeliveryRoute {
                        viewRouter.selectedCustomers[key] = value
                    }
                    let customerDeliveryCosts = resultingData["deliveryCostPerCustomer"] as! [String:Double]
                    for (key,value) in customerDeliveryCosts {
                        viewRouter.deliveryCostPerCustomer[key] = value
                    }
                    switch resultingData["ServiceSelectorCounter"] as! Int{
                    case 1:
                        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").addSnapshotListener{ (querySnapshot, error) in
                            if let error = error {
                                print("Error getting documents: \(error)")
                            } else {
                                
                                viewRouter.BusinessCustomersList.removeAll()
                                
                                for document in querySnapshot!.documents {
                                    
                                   
                                    let customerInfo : [String: Any] = document.data()
                                  
                                        
                                        viewRouter.BusinessCustomersList.append(BusinessDeliveryCustomers(name:"\(customerInfo["customerName"]as? String ?? "")",customerID:customerInfo["customerPhoneNumber"] as? String ?? "",customerAddress:customerInfo["currentCustomerAddress"] as? String ?? "Loading Address...",deliveryNotes:customerInfo["customerDeliveryNotes"] as? String ?? "",customerAddressPlaceID:customerInfo["customerAddressPlaceID"] as? String ?? ""))
                                        
                                        //viewRouter.businessPickupDisplayAddress
                                        viewRouter.businessPickupDisplayAddress = customerInfo["currentBusinessAddress"] as? String ?? "Loading Address..."
                                            
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                    
                                    
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
                                    
                                  
                                   
                                    
                                        viewRouter.BusinessCustomersList.append(BusinessDeliveryCustomers(name:"\(customerInfo["customerName"]as? String ?? "")",customerID:customerInfo["customerPhoneNumber"] as? String ?? "",customerAddress:customerInfo["currentCustomerAddress"] as? String ?? "Loading Address...",deliveryNotes:customerInfo["customerDeliveryNotes"] as? String ?? "",customerAddressPlaceID:customerInfo["customerAddressPlaceID"] as? String ?? ""))
                                        
                                        //viewRouter.businessPickupDisplayAddress
                                        viewRouter.businessPickupDisplayAddress = customerInfo["currentBusinessAddress"] as? String ?? "Loading Address..."
                                            
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                    
                                    
                                    
                                    
                                    
                                    
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
                                    
                                  
                                    
                                        viewRouter.BusinessCustomersList.append(BusinessDeliveryCustomers(name:"\(customerInfo["customerName"]as? String ?? "")",customerID:customerInfo["customerPhoneNumber"] as? String ?? "",customerAddress:customerInfo["currentCustomerAddress"] as? String ?? "Loading Address...",deliveryNotes:customerInfo["customerDeliveryNotes"] as? String ?? "",customerAddressPlaceID:customerInfo["customerAddressPlaceID"] as? String ?? ""))
                                        
                                        //viewRouter.businessPickupDisplayAddress
                                        viewRouter.businessPickupDisplayAddress = customerInfo["currentBusinessAddress"] as? String ?? "Loading Address..."
                                            
                                        
                                        print("totalCustomersAre: \(viewRouter.BusinessCustomersList)")
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            
                            
                        }
                    default:
                        ()
                        
                    }
                    
                } else {
                    //Deal with error &/ document doesn't exist here
                }
                
                
            }
            
            
            
        }
    }
}

struct upcomingDeliveryDetailsViews : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // deliveries
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("journey")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        if Int(viewRouter.selectedCustomers.count) == 1 {
                            Text("\(viewRouter.selectedCustomers.count) Delivery")
                                .font(.custom("Gill Sans Light", size: 18))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                //.frame(width: 280, height: 50)
                                //.fixedSize(horizontal: false, vertical: true)
                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                        }else{
                            Text("\(viewRouter.selectedCustomers.count) Deliveries")
                                .font(.custom("Gill Sans Light", size: 18))
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                //.frame(width: 280, height: 50)
                                //.fixedSize(horizontal: false, vertical: true)
                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                        }
                        
                       
                        Spacer()
                        
                        
                    }
                    
                    
                    Spacer()
                    
                }
                
            }
            
            // addresses
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("location")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        Text("From \(viewRouter.businessPickupDisplayAddress)")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                        
                        Spacer()
                        
                        
                    }
                    
                    
                    Spacer()
                    
                }
                
            }
            
            // date
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("calendar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        Text("\(viewRouter.displayDeliveryDay)")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            //.fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 10))
                        
                        Spacer()
                        
                        
                    }
                    
                    
                    Spacer()
                    
                }
                
                
            }
            
            //time
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("clock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        Text("Delivery pick-up at 11:30 AM")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            //.fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 10))
                        
                        Spacer()
                        
                        
                    }
                    
                    Spacer()
                    
                }
                
                
            }
            
            //truck size
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("deliverytruck")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        Text("\(viewRouter.serviceTypeMovers)")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            //.fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 10))
                        
                        Spacer()
                        
                        
                    }
                    
                    Spacer()
                    
                }
                
                
            }
            
            //number of movers
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("profilemover")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        
                        
                        Text("\(viewRouter.serviceTypeVehicle)")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            //.fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 10))
                        
                        Spacer()
                        
                        
                    }
                    
                    Spacer()
                    
                }
                
                
            }
            
            
            
            //inspection
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("inspection")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        
                        
                        Text("If it's your first delivery, there will be a pre-move visitation on \(viewRouter.inspectionDay) between 11 AM and 3 PM")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 10))
                        
                        Spacer()
                        
                        
                    }
                    
                    Spacer()
                    
                }
                
                
            }
            
            Button(action: {
                
                self.viewRouter.currentView = "ViewDeliveryList"
                //self.viewRouter.lastView = "StepThree"
                
            }) {
                
                Text("View customer delivery list")
                    .font(.custom("Gill Sans Light", size: 20))
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                    .background(Color.gray.opacity(0.15))
                    .padding(EdgeInsets(top: 15, leading: 30, bottom: 15, trailing: 30))
                
                //.fixedSize(horizontal: false, vertical: true)
                
            }
            //.padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(cardStrokeColor,lineWidth: 0.5)
                .shadow(color: .black, radius: 10.0)
        )
        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        
    }
}

struct upcomingDeliveryQuoteViews : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        
        VStack(spacing: 0){
            
            
            // duration
            VStack(spacing: 0){
                
                HStack{
                    
                    Text("Quote")
                        .font(.custom("Gill Sans Light", size: 25))
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(EdgeInsets(top: 10, leading: 29, bottom: 5, trailing: 0))
                    
                    Spacer()
                }
                
                
                
                
                //                HStack(spacing: 0){
                //
                //                    Text("Move Duration")
                //                        .font(.custom("Gill Sans Light", size: 18))
                //                        .fontWeight(.regular)
                //                        .multilineTextAlignment(.leading)
                //                        //.frame(width: 280, height: 50)
                //                        //.fixedSize(horizontal: false, vertical: true)
                //                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 0))
                //
                //                    Spacer()
                //
                //                    Text("\(viewRouter.movingDurationDisplay)")
                //                        .font(.custom("Gill Sans Light", size: 18))
                //                        .fontWeight(.regular)
                //                        .multilineTextAlignment(.leading)
                //                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                //
                //                }
                
                
                
                
            }
            
            
            //total
            HStack(spacing: 0){
                
                Text("Move cost")
                    .font(.custom("Gill Sans Light", size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    //.frame(width: 280, height: 50)
                    //.fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 0))
                
                Spacer()
                
                Text ("$ \(String(format: "%.2f", viewRouter.totalDeliveryCost)) CAD")
                    .font(.custom("Gill Sans Light", size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                
            }
            
            //hst
            HStack(spacing: 0){
                
                Text("HST (13%)")
                    .font(.custom("Gill Sans Light", size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    //.frame(width: 280, height: 50)
                    //.fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 0))
                
                Spacer()
                
                Text("$ \(String(format: "%.2f", (viewRouter.totalDeliveryCost*0.13))) CAD")
                    .font(.custom("Gill Sans Light", size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                
            }
            
            //total
            HStack(spacing: 0){
                
                Text("Move total")
                    .font(.custom("Gill Sans Light", size: 18))
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    //.frame(width: 280, height: 50)
                    //.fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 0))
                
                Spacer()
                
                VStack(spacing:0){
                    
                    Divider().background(Color.black).frame(width: 80)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    
                    Text("$ \(String(format: "%.2f", (viewRouter.totalDeliveryCost*1.13))) CAD")
                        .font(.custom("Gill Sans Light", size: 18))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    
                    Divider().background(Color.black).frame(width: 80)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                    
                    Divider().background(Color.black).frame(width: 80)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                }
            }
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(cardStrokeColor,lineWidth: 0.5)
                .shadow(color: .black, radius: 10.0)
        )
        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        
    }
}

struct upcomingDeliveryPaidSumView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        VStack(spacing: 0){
            
            //stepThreeProjectManagerView()
            
            Spacer().frame(height: 30)
            
            VStack(spacing: 0){
                
                //total
                HStack(spacing: 0){
                    
                    Text("Amount Paid")
                        .font(.custom("Gill Sans Light", size: 25))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        //.frame(width: 280, height: 50)
                        //.fixedSize(horizontal: false, vertical: true)
                        .padding(EdgeInsets(top: 15, leading: 30, bottom: 10, trailing: 0))
                    
                    Spacer()
                    
                    VStack(spacing:0){
                        
                        Divider().background(Color.black).frame(width: 80)
                            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 10))
                        
                        Text("$ \(String(format: "%.2f", (viewRouter.totalDeliveryCost*1.13))) CAD")
                            .font(.custom("Gill Sans Light", size: 25))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                        Divider().background(Color.black).frame(width: 80)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                        Divider().background(Color.black).frame(width: 80)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 5))
                
               
            }
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(cardStrokeColor,lineWidth: 0.5)
                    .shadow(color: .black, radius: 10.0)
            )
            .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        }
    }
}

struct upcomingDeliveryProjectManagerView: View{
    
    @State var user = Auth.auth().currentUser
    @State var db = Firestore.firestore()
    @State var functions = Functions.functions()
    @EnvironmentObject var viewRouter: ViewRouter
    @State var allMoves : individualMoves = movesDataPrimary[0]
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    var body: some View {
        
        VStack{
            HStack{
                
                Spacer().frame(width: 16)
                
                WebImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/filabusi-moving.appspot.com/o/WhatsApp%20Image%202021-06-12%20at%2009.21.51.jpeg?alt=media&token=4208b730-9aa4-4276-a863-67902574b012"))
                    // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
                    .onSuccess { image, data, cacheType in
                        // Success
                        // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                    }
                    .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
                    .placeholder(Image(systemName: "profilemover")) // Placeholder Image
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 80.0, height: 80.0)
                    .padding(EdgeInsets(top: 20, leading: 5, bottom: 0, trailing: 0))
                
                
                
                VStack{
                    
                    
                    Text("Your project manager")
                        .font(.custom("Gill Sans Light", size: 30))
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 5, trailing: 20))
                    
                    Spacer()
                    
                    
                    
                    
                }
                
                Spacer()
            }
            
            Text("Muny is the project manager for your upcoming move. He will conduct any pre-move visitations and address any questions you may have.")
                .font(.custom("Gill Sans Light", size: 18))
                .foregroundColor(.black)
                .fontWeight(.regular)
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            
            Button(action: {
                
                
                if let phoneCallURL = URL(string: "tel://6479157325") {
                    let application:UIApplication = UIApplication.shared
                    if (application.canOpenURL(phoneCallURL)) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    }
                }
                
                
            }) {
                
                Text("Call Muny")
                    .font(.custom("Gill Sans Light", size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 30))
                
                
                
            }
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(cardStrokeColor,lineWidth: 0.5)
                .shadow(color: .black, radius: 10.0)
        )
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
    
}

struct UpcomingDeliveryDetails_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingDeliveryDetails()
    }
}

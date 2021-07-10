//
//  UpcomingMoveDetails.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-10.
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


struct UpcomingMoveDetails: View {
    
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
                        self.viewRouter.currentView = "UpcomingMoves"
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
                
                
                
                Text("\(viewRouter.displayMoveDate)")
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
                    upcomingMoveDetailsViews()
                    
                    Spacer().frame(height: 30)
                    
                    upcomingMoveQuoteViews()
                    
                    //Spacer().frame(height: 20)
                    
                    upcomingDueTodayView()
                    
                    //Spacer().frame(height: 20)
                    
                    projectManagerView()
                    
                    Spacer().frame(height: 100)
                }
            }).background(Color.black.opacity(0.09))
            
            
        }
        .onAppear{
            
            
            db.collection("userData").document("\(viewRouter.userID)").collection("confirmedMoves").document("\(viewRouter.currentMoveID)").addSnapshotListener{ (document, error) in
                
                if let document = document, document.exists {
                    let resultingData : [String: Any] = document.data()!
                    
                    viewRouter.TruckDataPrimary.removeAll()
                    
                    viewRouter.inspectionDay = resultingData["inspectionDate"] as! String
                    viewRouter.displayOriginAddress = resultingData["originAddress"] as! String
                    viewRouter.displayDestinationAddress = resultingData["destinationAddress"] as! String
                    viewRouter.userID = resultingData["userID"] as! String
                    viewRouter.displayMoveDate = resultingData["moveDate"] as! String
                    viewRouter.movingDurationDisplay = resultingData["moveDuration"] as! String
                    viewRouter.movingCost = resultingData["moveWithoutHst"] as! String
                    viewRouter.totalCost = resultingData["moveWithHst"] as! String
                    viewRouter.hst = resultingData["moveHst"] as! String
                    viewRouter.manPowerReq = resultingData["manPower"] as! String
                    viewRouter.truckSizeInFeet = resultingData["truckFeet"] as! String
                    viewRouter.dueOnMoveDay = resultingData["moveAmountOutstanding"] as! String
                    viewRouter.displayEndTime = resultingData["moveEndTime"] as! String
                    
                    let itemsInTruck = resultingData["itemsInTruck"] as! [String:Any]
                    print("jbjkhb \(itemsInTruck)")
                    for (item, count) in itemsInTruck {
                        viewRouter.TruckDataPrimary.append(TruckPrimary(itemName: item, itemCount: count as! Int))
                    }
                    
                    
                } else {
                    //Deal with error &/ document doesn't exist here
                }
                
                
            }
            
            
            
        }
    }
}

struct upcomingMoveDetailsViews : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        
        VStack(spacing: 0){
            
            // addresses
            VStack(spacing: 0){
                
                HStack{
                    
                    Text("Summary")
                        .font(.custom("Gill Sans Light", size: 25))
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(EdgeInsets(top: 10, leading: 29, bottom: 5, trailing: 0))
                    
                    Spacer()
                }
                
                HStack(spacing: 0){
                    
                    Image("fromto")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 100)
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0))
                    
                    VStack(spacing: 0){
                        
                        Text("\(viewRouter.displayOriginAddress)")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .frame(width: 250, height: 50)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        
                        
                        Text("\(viewRouter.displayDestinationAddress)")
                            .font(.custom("Gill Sans Light", size: 18))
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            .frame(width: 250, height: 50)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    
                }
                //.frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxWidth: .infinity, maxHeight: 250, alignment: .leading)
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
                        
                        Text("\(viewRouter.displayMoveDate)")
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
                        
                        Text("9:00 AM - \(viewRouter.displayEndTime)")
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
                        
                        Text("\(viewRouter.truckSizeInFeet)' Truck")
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
                        
                        
                        
                        Text("\(viewRouter.manPowerReq) Movers")
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
            
            //disassembly
            VStack(spacing: 0){
                
                
                HStack(spacing: 0){
                    
                    Image("tools")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25,height: 50)
                        .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 0))
                    
                    HStack(spacing: 0){
                        
                        
                        
                        Text("Disassembly and reassembly of furniture included")
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
                        
                        
                        
                        Text("Pre-move visitation on \(viewRouter.inspectionDay) between 6 PM and 9 PM")
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
            
            Button(action: {
                
                self.viewRouter.currentView = "TruckView"
                self.viewRouter.lastView = "UpcomingMoveDetails"
                
            }) {
                
                Text("View items in moving truck")
                    .font(.custom("Gill Sans Light", size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.gray.opacity(0.15))
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 15, trailing: 30))
                
                //.fixedSize(horizontal: false, vertical: true)
                
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

struct upcomingMoveQuoteViews : View {
    
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
                
                
                
                
                HStack(spacing: 0){
                    
                    Text("Move Duration")
                        .font(.custom("Gill Sans Light", size: 18))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        //.frame(width: 280, height: 50)
                        //.fixedSize(horizontal: false, vertical: true)
                        .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 0))
                    
                    Spacer()
                    
                    Text("\(viewRouter.movingDurationDisplay)")
                        .font(.custom("Gill Sans Light", size: 18))
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                    
                }
                
                
                
                
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
                
                Text("$\(viewRouter.movingCost) CAD")
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
                
                Text("$\(viewRouter.hst) CAD")
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
                    
                    Text("$\(viewRouter.totalCost) CAD")
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
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        
    }
}

struct upcomingDueTodayView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        
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
                    
                    Text("$\(viewRouter.totalCost) CAD")
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
            
//            //total
//            HStack(spacing: 0){
//
//                Spacer()
//
//                Text("$\(viewRouter.dueOnMoveDay) CAD is Due on \(viewRouter.displayMoveDate)")
//                    .font(.custom("Gill Sans Light", size: 16))
//                    .fontWeight(.regular)
//                    .multilineTextAlignment(.leading)
//                    //.frame(width: 280, height: 50)
//                    //.fixedSize(horizontal: false, vertical: true)
//                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0))
//
//                Spacer()
//            }
            
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


struct projectManagerView: View{
    
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

struct UpcomingMoveDetails_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingMoveDetails()
            .environmentObject(ViewRouter())
    }
}

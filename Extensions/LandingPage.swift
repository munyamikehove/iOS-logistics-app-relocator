//
//  landingPage.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-13.
//

import SwiftUI
import AlertToast
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

struct LandingPage: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showingAlert = false
    @State var alertMessage = ""
    
    @State var user = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    @State var functions = Functions.functions()
    
    var body: some View {
        Home()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hey there"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
            }.onAppear{
                
                viewRouter.userID = user!
                
                db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS1").addSnapshotListener{ (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        
                        
                    
                        for document in querySnapshot!.documents {
                            
                           
                            let customerInfo : [String: Any] = document.data()
                            viewRouter.existingBusinessAccount = true
                            viewRouter.currentBusinessAddress = customerInfo["currentBusinessAddress"]as? String ?? ""
                            viewRouter.OriginBusinessAddress = customerInfo["currentBusinessAddress"]as? String ?? ""
                            viewRouter.placeIDBusiness = customerInfo["businessAddressPlaceID"]as? String ?? ""
                            
                        }
                    }
                    
                    
                }
                
                db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS2").addSnapshotListener{ (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        
                        
                    
                        for document in querySnapshot!.documents {
                            
                           
                            let customerInfo : [String: Any] = document.data()
                            viewRouter.existingBusinessAccount = true
                            viewRouter.currentBusinessAddress = customerInfo["currentBusinessAddress"]as? String ?? ""
                            viewRouter.OriginBusinessAddress = customerInfo["currentBusinessAddress"]as? String ?? ""
                            viewRouter.placeIDBusiness = customerInfo["businessAddressPlaceID"]as? String ?? ""
                            
                        }
                    }
                    
                    
                }
                
                db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS3").addSnapshotListener{ (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        
                        
                    
                        for document in querySnapshot!.documents {
                            
                           
                            let customerInfo : [String: Any] = document.data()
                            viewRouter.existingBusinessAccount = true
                            viewRouter.currentBusinessAddress = customerInfo["currentBusinessAddress"]as? String ?? ""
                            viewRouter.OriginBusinessAddress = customerInfo["currentBusinessAddress"]as? String ?? ""
                            viewRouter.placeIDBusiness = customerInfo["businessAddressPlaceID"]as? String ?? ""
                            
                        }
                    }
                    
                    
                }
            }
    }
}

struct HomePage : View {
    
    @Binding var x : CGFloat
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color("bag1")
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View{
        
        if viewRouter.appSectionOnDisplay == "House Moves"{
            // Home View With CUstom Nav bar...
            VStack{
                
                HStack(spacing: 0){
                    
                    Button(action: {
                        withAnimation{
                            
                            x = 0
                        }
                    }, label: {
                        
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
                            .resizable()
                            .foregroundColor(Color("bag1"))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28.0, height: 18.0)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 15))
                    })
                    
                    //               Image("logo") // line.horizontal.3.decrease.circle.fill
                    //                    .resizable()
                    //                    .aspectRatio(contentMode: .fit)
                    //                    .frame(width: 55.0, height: 35.0)
                    //                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    
                    Text("Welcome to Relocator")
                        .foregroundColor(strokeColor)
                        .font(.title)
                        .fontWeight(.ultraLight)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    // Spacer()
                    
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Image("slide1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 350)
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                
                
                Text("Moving made easy")
                    .font(.custom("Gill Sans Light", size: 25))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                
                Text("Relocator takes care of all your moving needs. Let's schedule your move in three easy steps.")
                    .font(.custom("Courier New", size: 20))
                    .foregroundColor(.black)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                
                
                
                
                Button(action: {
                    //self.viewRouter.AboutAppCounter = 2
                    self.viewRouter.currentView = "StepOne"
                }) {
                    
                    Text("SCHEDULE A MOVE")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .background(Color("bag1"))
                        .clipShape(Capsule())
                }
                //.padding(.top)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                
                
                Button(action: {
                    
                    
                    
                    self.viewRouter.currentView = "UpcomingMoves"
                    
                }) {
                    
                    Text("Tap here to view upcoming moves")
                        .font(.custom("Gill Sans Light", size: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.gray.opacity(0.15))
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 5, trailing: 30))
                    
                    //.fixedSize(horizontal: false, vertical: true)
                    
                }
                
            }
            // for drag gesture...
            .contentShape(Rectangle())
            .background(Color.white)
            .padding(.bottom,20)
            .onAppear{
                if user != nil{
                    
                    self.viewRouter.userID = user!.uid
                    
                    if !viewRouter.userID.isEmpty {
                        
                        ref.child("businessQuickRef").child("\(viewRouter.userID)").setValue(["distanceFromMidtownToronto": nil])
                        ref.child("businessQuickRef").child("\(viewRouter.userID)").setValue(["customerDistanceFromBusiness": nil])
                        
                    }
                    
                }
            }
        }else{
            // Home View With CUstom Nav bar...
            VStack{
                
                HStack(spacing: 0){
                    
                    Button(action: {
                        withAnimation{
                            
                            x = 0
                        }
                    }, label: {
                        
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
                            .resizable()
                            .foregroundColor(Color("bag1"))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 28.0, height: 18.0)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 15))
                    })
                    
                    //               Image("logo") // line.horizontal.3.decrease.circle.fill
                    //                    .resizable()
                    //                    .aspectRatio(contentMode: .fit)
                    //                    .frame(width: 55.0, height: 35.0)
                    //                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    
                    Text("Relocator for business")
                        .foregroundColor(strokeColor)
                        .font(.title)
                        .fontWeight(.ultraLight)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    
                    // Spacer()
                    
                    
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Image("businessdeliveries")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 350)
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                
                
                Text("Local deliveries made easy")
                    .font(.custom("Gill Sans Light", size: 25))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                
                Text("Relocator takes care of all your business delivery needs. Schedule your business delivery in three easy steps.")
                    .font(.custom("Courier New", size: 20))
                    .foregroundColor(.black)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                
                
                
                
                Button(action: {
                    //self.viewRouter.AboutAppCounter = 2
                    self.viewRouter.currentView = "StepOneBusiness"
                }) {
                    
                    Text("SCHEDULE A DELIVERY")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                        .background(Color("bag1"))
                        .clipShape(Capsule())
                }
                //.padding(.top)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                
                
                
                Button(action: {
                    
                    self.viewRouter.currentView = "UpcomingDeliveries"
                    
                }) {
                    
                    Text("Tap here to view upcoming deliveries")
                        .font(.custom("Gill Sans Light", size: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.gray.opacity(0.15))
                        .padding(EdgeInsets(top: 20, leading: 30, bottom: 5, trailing: 30))
                    
                    //.fixedSize(horizontal: false, vertical: true)
                    
                }
                
            }
            // for drag gesture...
            .contentShape(Rectangle())
            .background(Color.white)
            .padding(.bottom,20)
            .onAppear{
                if user != nil{
                    
                    self.viewRouter.userID = user!.uid
                    
                    if !viewRouter.userID.isEmpty {
                        
                        ref.child("QuickRef").child("\(viewRouter.userID)").setValue(["distanceFromMidtownToronto": nil])
                        ref.child("QuickRef").child("\(viewRouter.userID)").setValue(["originToDestinationDistance": nil])
                        
                    }
                    
                }
            }
        }
        
        
        
        
        
    }
}

struct Home : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            HomePage(x: $viewRouter.x)
            
            SlideMenu()
                .shadow(color: Color.black.opacity(viewRouter.x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: viewRouter.x)
                .background(Color.black.opacity(viewRouter.x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture {
                    
                    // hiding the view when back is pressed...
                    
                    withAnimation{
                        
                        viewRouter.x = -viewRouter.width
                    }
                })
        }
        // adding gesture or drag feature...
        .gesture(DragGesture().onChanged({ (value) in
            
            withAnimation{
                
                if value.translation.width > 0{
                    
                    // disabling over drag...
                    
                    if viewRouter.x < 0{
                        
                        viewRouter.x = -viewRouter.width + value.translation.width
                    }
                }
                else{
                    
                    if viewRouter.x != -viewRouter.width{
                        
                        viewRouter.x = value.translation.width
                    }
                }
            }
            
        }).onEnded({ (value) in
            
            withAnimation{
                
                // checking if half the value of menu is dragged means setting x to 0...
                
                if -viewRouter.x < viewRouter.width / 2{
                    
                    viewRouter.x = 0
                }
                else{
                    
                    viewRouter.x = -viewRouter.width
                }
            }
        }))
    }
}

struct SlideMenu : View {
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color("bag1")
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    
    
    var body: some View{
        
        
        HStack(spacing: 0){
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    Text("Relocator")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    
                    
                }
                
                Divider()
                    .padding(.top)
                
                // Different Views When up or down buttons pressed....
                
                VStack(alignment: .leading){
                    
                    // Menu Buttons....
                    
                    ForEach(menuButtons,id: \.self){menu in
                        
                        Button(action: {
                            // switch your actions or work based on title....
                           
                            
                            switch menu{
                            case "Moving - Residential":
                                viewRouter.appSectionOnDisplay = "House Moves"
                                viewRouter.x = -viewRouter.width
                            case "Deliveries - Commercial":
                                viewRouter.appSectionOnDisplay = "Business Deliveries"
                                viewRouter.x = -viewRouter.width
                            case "Staging - Residential\n(Coming Soon)":
                                // viewRouter.appSectionOnDisplay = "Business Deliveries"
                                //viewRouter.x = -viewRouter.width
                                ()
                            case "Cleaning - Residential\n(Coming Soon)":
                                // viewRouter.appSectionOnDisplay = "Business Deliveries"
                                //viewRouter.x = -viewRouter.width
                                ()
                            case "Landscaping - Residential\n(Coming Soon)":
                                // viewRouter.appSectionOnDisplay = "Business Deliveries"
                                //viewRouter.x = -viewRouter.width
                                ()
                            default:
                                viewRouter.appSectionOnDisplay = "House Moves"
                                viewRouter.x = -viewRouter.width
                            }
                            
                        }) {
                            
                            VStack(spacing:0){
                                MenuButton(title: menu)
                                
                                
                            }
                            
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Divider()
                        .padding(.top)
                    
                    Button(action: {
                        // switch your actions or work based on title....
                        viewRouter.currentView = "MoverSignUp"
                        
                    }) {
                        
                        MenuButton(title: "Relocator for movers")
                    }
                    
                    Divider()
                    
                    Button(action: {
                        // switch your actions or work based on title....
                        if let url = URL(string: "https://www.instagram.com/relocator_/") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        
                        MenuButton(title: "Relocator on IG")
                    }
                    
                    
                }
                // hiding this view when down arrow pressed...
                .opacity(show ? 1 : 0)
                .frame(height: show ? nil : 0)
                
                
                
            }
            .padding(.horizontal,20)
            // since vertical edges are ignored....
            .padding(.top,edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges?.bottom)
            // default width...
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .vertical)
            
            Spacer(minLength: 0)
        }
        
        
        
        
    }
}


var menuButtons = ["Moving - Residential","Deliveries - Commercial","Staging - Residential\n(Coming Soon)","Cleaning - Residential\n(Coming Soon)","Landscaping - Residential\n(Coming Soon)"]

struct MenuButton : View {
    
    var title : String
    @State var show = true
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color("bag1")
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View{
        
        HStack(spacing: 15){
            
            // both title and image names are same....
            switch title{
            case "Moving - Residential":
                
                Image("home")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            
            case "Deliveries - Commercial":
                //viewRouter.menuItemSelection = "Business Deliveries"
                Image("shuttle")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            
            case "Staging - Residential\n(Coming Soon)":
                //viewRouter.menuItemSelection = "Relocator on IG"
                Image("sold")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            case "Cleaning - Residential\n(Coming Soon)":
                //viewRouter.menuItemSelection = "Relocator on IG"
                Image("clean")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            case "Landscaping - Residential\n(Coming Soon)":
                //viewRouter.menuItemSelection = "Relocator on IG"
                Image("landscape")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            case "Relocator for movers":
                //viewRouter.menuItemSelection = "Relocator for movers"
                Image("insurance")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            case "Relocator on IG":
                //viewRouter.menuItemSelection = "Relocator on IG"
                Image("instagram")
                    .resizable()
                    //.renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            default:
                //viewRouter.menuItemSelection = "House Moves"
                Image("home")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 24, height: 24)
            //.foregroundColor(.gray)
            }
            
            if title == "House Staging\n(Coming Soon)"{
                Text(title)
                    .foregroundColor(.gray)
            }else{
                Text(title)
                    .foregroundColor(.black)
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical,12)
    }
    
    
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
            .environmentObject(ViewRouter())
    }
}

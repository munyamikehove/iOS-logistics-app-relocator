//
//  StepThree.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-31.
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

struct StepThree: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var truckItems : TruckPrimary = TruckDataPrimary[0]
    @State var DatabaseItemList : [String:Int] = [:]
    @State var backgroundColor: Color = Color(red: 0.92, green: 0.95, blue: 0.98)
    
    @State var showingAlert = false
    @State var alertMessage = ""
    
    @State var totalForTwo = 0
    @State var totalForThree = 0
    @State var totalInTruck = 0
    @State var loopCounterFigure = 0
    @State var movingCost = ""
    @State var hst = ""
    
    @State var user = Auth.auth().currentUser
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    @State var functions = Functions.functions()
    
    @State var totalCost = ""
    @State var movingDuration = 0
    @State var movingDurationDisplay = ""
    @State var minutes:String = ""
    @State var hours:String = ""
    @State var a = 0.0
    @State var m = "00"
    @State var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack(spacing:0){
            
            if viewRouter.whatSectionToShow == "main"{
                
                ZStack{
                    
                    VStack(spacing: 0){
                        
                        VStack(spacing: 0){
                            
                            ZStack{
                                
                                HStack(spacing: 15){
                                    
                                    Button(action: {
                                        
                                        viewRouter.movingDurationDisplay = ""
                                        viewRouter.movingCost = "0.0"
                                        viewRouter.hst = ""
                                        viewRouter.totalCost = ""
                                        
                                        viewRouter.displayDestinationAddress = ""
                                        viewRouter.destinationType = ""
                                        viewRouter.distanceFromMidtownToronto = 0
                                        viewRouter.displayMoveDate = ""
                                        viewRouter.displayOriginAddress =  ""
                                        viewRouter.originToDestinationDistance =  0
                                        viewRouter.originType = ""
                                        self.viewRouter.currentView = "StepTwo"
                                        
                                    }, label: {
                                        
                                        Image(systemName: "arrow.left")
                                            .font(.title)
                                            .foregroundColor(.black)
                                    })
                                    
                                    Spacer(minLength: 0)
                                    
                                    
                                    
                                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            
                                            Image("")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 35.0, height: 25.0)
                                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5))
                                        })
                                        
                                        
                                    })
                                }
                                
                                
                                
                                Text("Step 3")
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                    .padding(.trailing,10)
                                
                                
                                
                            }
                            .padding()
                            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                            .background(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        //stepTwoBody
                        ScrollView(.vertical, showsIndicators: false, content: {
                            
                            VStack{
                                
                                // Divider Line...
                                HStack{
                                    
                                    
                                    Text("SUMMARY AND QUOTE")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("bag1"))
                                    
                                    
                                    
                                    
                                    
                                    Rectangle()
                                        .fill(Color("bag1").opacity(0.6))
                                        .frame(height: 0.5)
                                }
                                .padding()
                                
                                
                                
                                moveDetailsViews()
                                
                                Spacer().frame(height: 30)
                                
                                moveQuoteViews()
                                
                                Spacer().frame(height: 30)
                                
                                dueTodayView()
                                
                                Divider().background(Color.black.opacity(0.45)).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0, alignment: .center)
                                
                                HStack(spacing:0){
                                    
                                    switch viewRouter.cdIssuer {
                                    case "unionpay":
                                        Image("unionpay")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    case "jcb":
                                        Image("jcb")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    case "mastercard":
                                        Image("mastercard")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    case "discover":
                                        Image("discover")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    case "diners_club":
                                        Image("diners")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    case "amex":
                                        Image("americanexpress")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    case "visa":
                                        Image("visa")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    default:
                                        Image("defaultcard")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 45.0, height: 45.0)
                                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    }
                                    
                                    Text("•••• \(viewRouter.lastFour)")
                                        .font(.custom("Gill Sans Light", size: 20))
                                        .fontWeight(.regular)
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                                    
                                    Spacer()
                                    
                                    if viewRouter.doesPaymentMethodExist == false{
                                        
                                        Button(action: {
                                            
                                            viewRouter.viewBeforePaymentIntent = "realty"
                                            self.viewRouter.currentView = "StripeSetupView"
                                            
                                        }) {
                                            
                                            Text("ADD CARD")
                                                .font(.custom("Gill Sans Light", size: 18))
                                                .frame(minWidth: 0, maxWidth: 120, minHeight: 0, maxHeight: 45)
                                                .background(Color.gray.opacity(0.15))
                                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                                            
                                            
                                        }
                                    }
                                }
                                
                                
                                Button(action: {
                                    
                                    let str = String(format: "%.2f", (Double(viewRouter.movingCost)!*1.13))
                                    let array = str.components(separatedBy: ".")
                                    let a = Int(array[0])!*100
                                    let b = Int(array[1])!
                                    let c = a+b
                                    
                                    if viewRouter.doesPaymentMethodExist != false{
                                        
                                    
                                        
                                       
                                        functions.httpsCallable("captureResidentialPayment").call(["cus": "\(viewRouter.cust)","pm": "\(viewRouter.pm)","userID": "\(viewRouter.userID)","amount": "\(c)"]) { (result, error) in
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
                                        
                                        for item in viewRouter.TruckDataPrimary {
                                            viewRouter.itemsInTruckDBPush[item.itemName] = item.itemCount
                                        }
                                       
                                        viewRouter.fromPaymentTrigger = true
                                        viewRouter.whatSectionToShow = "loading"
                                        
                                    }else{
                                        alertMessage = "Please add a payment method to proceed."
                                        showingAlert = true
                                    }
                                   
                                    
                                }) {
                                    
                                    Text("PAY $ \(String(format: "%.2f", (Double(viewRouter.movingCost)!*1.13))) CAD")
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
                                
                                Spacer().frame(height: 75)
                                
                            }
                        })
                        
                    }
                    .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
                    
                    
                }
                
                .onAppear(perform: cTT)
                .ignoresSafeArea(.all, edges: .top)
                
            }else if viewRouter.whatSectionToShow == "success" {
                Payment_Status_Success()
            }else if viewRouter.whatSectionToShow == "failure"{
                Payment_Status_Failure()
            }else if viewRouter.whatSectionToShow == "loading"{
                VStack{
                    
                    Text("Please Wait...")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    
                    ProgressView("Processing Payment")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(EdgeInsets(top: 50, leading: 10, bottom: 250, trailing: 10))
                    
                }.padding(EdgeInsets(top: 280, leading: 20, bottom: 0, trailing: 20))
            }else if viewRouter.whatSectionToShow == "loadView"{
                VStack{
                    
                    Text("Please Wait...")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    
                    ProgressView("Generating Quote")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(EdgeInsets(top: 50, leading: 10, bottom: 250, trailing: 10))
                    
                }
                .onReceive(timer) { time in
                    if self.counter == 5 {
                                       self.timer.upstream.connect().cancel()
                        viewRouter.whatSectionToShow = "main"
                        
                                   }

                                   self.counter += 1
                    }
                .padding(EdgeInsets(top: 280, leading: 20, bottom: 0, trailing: 20))
            }
            
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Important"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
        
        
        
    }
    
    func cTT(){
        
        
        viewRouter.fromPaymentTrigger = false
        //DatabaseItemList.removeAll()
        //print("DatabaseItemListCount \(DatabaseItemList.count)")
        //print("TruckDataPrimaryCount \(viewRouter.TruckDataPrimary.count)")
       
        
        //Move information
        ref.child("QuickRef").child("\(viewRouter.userID)").observe(.value) { (DataSnapshot) in
            
            if DataSnapshot.exists(){
                
                //print("ValueIs: hknujgku \(DataSnapshot)")
                
                let value = DataSnapshot.value as? NSDictionary
                let Distance = value?["distanceFromMidtownToronto"] as? Int ?? 0
                
                viewRouter.displayDestinationAddress = value?["destinationAddress"] as? String ?? "Loading..."
                viewRouter.destinationType = value?["destinationType"] as? String ?? ""
                viewRouter.distanceFromMidtownToronto = value?["distanceFromMidtownToronto"] as? Int ?? 0
                viewRouter.displayMoveDate = value?["moveDate"] as? String ?? ""
                viewRouter.displayOriginAddress = value?["originAddress"] as? String ?? "Loading..."
                viewRouter.originToDestinationDistance = value?["originToDestinationDistance"] as? Int ?? 0
                viewRouter.originType = value?["originType"] as? String ?? ""
                
                
                if Distance > 120000{
                    self.viewRouter.currentView = "NoServiceView"
                }
                
                
            }
            
            
        }
        
        if user != nil{
            self.viewRouter.userID = user!.uid
            if !viewRouter.userID.isEmpty {
                
                db.collection("userData")
                    .document(viewRouter.userID)
                    .collection("allUserDocuments")
                    .document("depositPaymentRef").addSnapshotListener{ (document, error) in
                        if let document = document, document.exists {
                            let userInfo : [String: Any] = document.data()!
                            
                            let statusCode = userInfo["status"] as? String ?? "Unpaid"
                            if statusCode == "success" && viewRouter.fromPaymentTrigger{
                                
                                var ref: DocumentReference? = nil
                                
                                let docData: [String: Any] = [
                                    
                                    "inspectionDate":viewRouter.inspectionDay,
                                    "originAddress": viewRouter.displayOriginAddress,
                                    "destinationAddress": viewRouter.displayDestinationAddress,
                                    "userID": viewRouter.userID,
                                    "moveDate": viewRouter.displayMoveDate,
                                    "moveDuration": viewRouter.movingDurationDisplay,
                                    "moveWithoutHst": viewRouter.movingCost,
                                    "moveWithHst": viewRouter.totalCost,
                                    "moveHst": viewRouter.hst,
                                    "moveDepositPaid": "100",
                                    "manPower": viewRouter.manPowerReq,
                                    "truckFeet": viewRouter.truckSizeInFeet,
                                    "moveAmountOutstanding": viewRouter.dueOnMoveDay,
                                    "moveStartTime": "9:00 AM",
                                    "assignmentStatus": "Unassigned",
                                    "itemsInTruck":viewRouter.itemsInTruckDBPush,
                                    "originType": viewRouter.originType,
                                    "destinationType": viewRouter.destinationType,
                                    "originToDestinationDistance": viewRouter.originToDestinationDistance,
                                    
                                ]
                                
                               
                                
                                
                                ref = db.collection("confirmedMovesUnassigned").document("\(viewRouter.displayMoveDate)").collection("\(viewRouter.userID)").addDocument(data: docData){ err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                                
                                let docDataTwo: [String: Any] = [
                                    
                                    "inspectionDate":viewRouter.inspectionDay,
                                    "originAddress": viewRouter.displayOriginAddress,
                                    "destinationAddress": viewRouter.displayDestinationAddress,
                                    "userID": viewRouter.userID,
                                    "moveDate": viewRouter.displayMoveDate,
                                    "moveDuration": viewRouter.movingDurationDisplay,
                                    "moveID": "\(ref!.documentID)",
                                    "moveWithoutHst": viewRouter.movingCost,
                                    "moveWithHst": viewRouter.totalCost,
                                    "moveHst": viewRouter.hst,
                                    "moveDepositPaid": "100",
                                    "manPower": viewRouter.manPowerReq,
                                    "truckFeet": viewRouter.truckSizeInFeet,
                                    "moveAmountOutstanding": viewRouter.dueOnMoveDay,
                                    "moveStartTime": "9:00 AM",
                                    "itemsInTruck":viewRouter.itemsInTruckDBPush,
                                    "assignmentStatus": "Unassigned",
                                    "originType": viewRouter.originType,
                                    "destinationType": viewRouter.destinationType,
                                    "originToDestinationDistance": viewRouter.originToDestinationDistance,
                                    "moveEndTime":viewRouter.displayEndTime,
                                    
                                ]
                                
                                
                                
                                db.collection("confirmedMovesUnassigned").document("\(viewRouter.displayMoveDate)").collection("\(viewRouter.userID)").document("\(ref!.documentID)").setData(docDataTwo){ err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                                
                                db.collection("userData").document("\(viewRouter.userID)").collection("confirmedMoves").document("\(ref!.documentID)").setData(docDataTwo){ err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                                
                                
                                viewRouter.itemsInTruckDBPush.removeAll()
                                viewRouter.fromPaymentTrigger = false
                                self.viewRouter.whatSectionToShow = "success"
                                
                            }else if statusCode == "Unpaid" {
                                self.viewRouter.whatSectionToShow = "main"
                            }else if statusCode == "failure"{
                                self.viewRouter.whatSectionToShow = "failure"
                            }
                            
                        }
                    }
                
                db.collection("userData")
                    .document(self.viewRouter.userID)
                    .collection("allUserDocuments")
                    .document("stripeCustomerPaymentProfile").getDocument{ (document, error) in
                        if let document = document, document.exists {
                            let resultingData : [String: Any] = document.data()!
                            let userInfo : [String: Any] = resultingData["resultingData"] as! [String : Any]
                            let cardInfo : [String: Any] = userInfo["card"] as! [String : Any]
                            
                            viewRouter.pm = userInfo["id"] as! String
                            viewRouter.cust = userInfo["customer"] as! String
                            viewRouter.cdIssuer = cardInfo["brand"] as! String
                            viewRouter.lastFour = cardInfo["last4"] as! String
                            
                            viewRouter.doesPaymentMethodExist = true
                            
                        } else {
                            //Deal with error &/ document doesn't exist here
                            viewRouter.doesPaymentMethodExist = false
                        }
                    }
                
            }
            
        }
        
        totalInTruck = viewRouter.TruckDataPrimary.count
        
        for item in viewRouter.TruckDataPrimary {
            
            loopCounterFigure += 1
            DatabaseItemList[item.itemName] = item.itemCount
            print("khgcjegwcquy: Loop is at \(loopCounterFigure) and totalInTruck is\(totalInTruck)")
            
            switch item.itemName {
            
            
            case "Sofas & Couches":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Carpets and rugs":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Book Shelves, Hutches & Display Cases":
                totalForTwo = totalForTwo + (item.itemCount*5)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Chairs & Stools":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Stoves":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Refrigerators":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Dish Washers":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Microwaves":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Clothes Dryers":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Clothes Washers":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "King Sized Beds":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Queen Sized Beds":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Double Sized Beds":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Twin Sized Beds":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Cribs & Change Tables":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "Dressers & Drawers":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "TV Stands, Tables & Desks":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            case "TVs & Computer Monitors":
                totalForTwo = totalForTwo + (item.itemCount*3)
                totalForThree = totalForThree + (item.itemCount*3)
            case "Desktops & Printers":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Boxes, Totes & Containers":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Suitcases":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "BBQ Grills":
                totalForTwo = totalForTwo + (item.itemCount*3)
                totalForThree = totalForThree + (item.itemCount*3)
            case "Lawn mowers & Wheelbarrows":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Bicycles":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Strollers":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Snow blowers":
                totalForTwo = totalForTwo + (item.itemCount*2)
                totalForThree = totalForThree + (item.itemCount*2)
            case "Table Tennis":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Treadmills":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Ellipticals":
                totalForTwo = totalForTwo + (item.itemCount*15)
                totalForThree = totalForThree + (item.itemCount*10)
            case "Workout Weights & Bench":
                totalForTwo = totalForTwo + (item.itemCount*1)
                totalForThree = totalForThree + (item.itemCount*1)
            case "Rowing Machines":
                totalForTwo = totalForTwo + (item.itemCount*1)
                totalForThree = totalForThree + (item.itemCount*1)
            case "Other Items":
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
            default:
                print("Error: could not find item")
                totalForTwo = totalForTwo + (item.itemCount*10)
                totalForThree = totalForThree + (item.itemCount*5)
                
                
            }
            
            
            
        }
        
        if totalInTruck >= loopCounterFigure {
            
            print("ValueOfB11Is: hknujgku \(totalForTwo)")
            print("ValueOfB12Is: hknujgku \(totalForThree)")
            setRateAndTime()
        }
        
        
    }
    
    func setRateAndTime(){
        
        
        
        
        if totalForTwo >= 220{
            
            if viewRouter.originToDestinationDistance < 50000{
                a = Double((2*totalForThree))/Double(60)
            }else{
                a = (Double((2*totalForThree))/Double(60)) + ((Double((2*viewRouter.originToDestinationDistance)))/Double(100000))
            }
            viewRouter.manPowerReq = "3"
            viewRouter.truckSizeInFeet = "20"
            let b: String = String(a)
            
            let array = b.components(separatedBy: ".")
            
            let c: Int = Int(array[1]) ?? 0
            if c != 0{
                let d = Double("0.\(c)")
                let e = Int(d!*60)
                minutes = "\(e) mins"
                if e > 9{
                    m = "\(e)"
                }else{
                    m = "0\(e)"
                }
                
            }else{
                minutes = "0 mins"
                m = "00"
            }
            
            let f = Int(array[0])
            if f != 0{
                hours = "\(f ?? 0) hrs"
                
                switch f {
                case 1:
                    viewRouter.displayEndTime = "10:\(m) AM"
                case 2:
                    viewRouter.displayEndTime = "11:\(m) AM"
                case 3:
                    viewRouter.displayEndTime = "12:\(m) PM"
                case 4:
                    viewRouter.displayEndTime = "1:\(m) PM"
                case 5:
                    viewRouter.displayEndTime = "2:\(m) PM"
                case 6:
                    viewRouter.displayEndTime = "3:\(m) PM"
                case 7:
                    viewRouter.displayEndTime = "4:\(m) PM"
                case 8:
                    viewRouter.displayEndTime = "5:\(m) PM"
                case 9:
                    viewRouter.displayEndTime = "6:\(m) PM"
                case 10:
                    viewRouter.displayEndTime = "7:\(m) PM"
                case 11:
                    viewRouter.displayEndTime = "8:\(m) PM"
                case 12:
                    viewRouter.displayEndTime = "9:\(m) PM"
                case 13:
                    viewRouter.displayEndTime = "10:\(m) PM"
                case 14:
                    viewRouter.displayEndTime = "11:\(m) PM"
                case 15:
                    viewRouter.displayEndTime = "12:\(m) AM"
                case 16:
                    viewRouter.displayEndTime = "1:\(m) AM"
                case 17:
                    viewRouter.displayEndTime = "2:\(m) AM"
                case 18:
                    viewRouter.displayEndTime = "3:\(m) AM"
                case 19:
                    viewRouter.displayEndTime = "4:\(m) AM"
                case 20:
                    viewRouter.displayEndTime = "5:\(m) AM"
                case 21:
                    viewRouter.displayEndTime = "6:\(m) AM"
                case 22:
                    viewRouter.displayEndTime = "7:\(m) AM"
                case 23:
                    viewRouter.displayEndTime = "8:\(m) AM"
                case 24:
                    viewRouter.displayEndTime = "9:\(m) AM"
                default:
                    viewRouter.displayEndTime = "4:\(m) PM"
                    
                }
            }else{
                hours = "1 hr"
                viewRouter.displayEndTime = "10:\(m) AM"
            }
            
            
            
            
            viewRouter.movingDurationDisplay = "\(hours) \(minutes)"
            if a < 60{
                viewRouter.movingCost = String(format: "%.2f", (2.17 * Double((a*60)+60)))
            }else{
                viewRouter.movingCost = String(format: "%.2f", (2.17 * Double((a*60))))
            }
            viewRouter.hst = String(format: "%.2f", (Double(viewRouter.movingCost)! * 0.13))
            viewRouter.totalCost = String(format: "%.2f", ((Double(viewRouter.movingCost)! + Double(viewRouter.hst)!)))
            viewRouter.dueOnMoveDay = String(format: "%.2f", ((Double(viewRouter.totalCost)! - 100.00)))
            viewRouter.dueToday = "100.00"
            
        }else{
            
            if viewRouter.originToDestinationDistance < 50000{
                a = Double((2*totalForTwo))/Double(60)
            }else{
                a = (Double((2*totalForTwo))/Double(60)) + (Double((2*viewRouter.originToDestinationDistance))/Double(100000))
                
            }
            
            viewRouter.manPowerReq = "2"
            viewRouter.truckSizeInFeet = "16"
            let b: String = String(a)
            let array = b.components(separatedBy: ".")
            
            let c: Int = Int(array[1]) ?? 0
            if c != 0{
                let d = Double("0.\(c)")
                let e = Int(d!*60)
                minutes = "\(e) mins"
                if e > 9{
                    m = "\(e)"
                }else{
                    m = "0\(e)"
                }
            }else{
                minutes = "0 mins"
                m = "00"
            }
            
            let f = Int(array[0])
            if f != 0{
                
                hours = "\(f ?? 0) hrs"
                
                
                switch f {
                case 1:
                    viewRouter.displayEndTime = "10:\(m) AM"
                case 2:
                    viewRouter.displayEndTime = "11:\(m) AM"
                case 3:
                    viewRouter.displayEndTime = "12:\(m) PM"
                case 4:
                    viewRouter.displayEndTime = "1:\(m) PM"
                case 5:
                    viewRouter.displayEndTime = "2:\(m) PM"
                case 6:
                    viewRouter.displayEndTime = "3:\(m) PM"
                case 7:
                    viewRouter.displayEndTime = "4:\(m) PM"
                case 8:
                    viewRouter.displayEndTime = "5:\(m) PM"
                case 9:
                    viewRouter.displayEndTime = "6:\(m) PM"
                case 10:
                    viewRouter.displayEndTime = "7:\(m) PM"
                case 11:
                    viewRouter.displayEndTime = "8:\(m) PM"
                case 12:
                    viewRouter.displayEndTime = "9:\(m) PM"
                case 13:
                    viewRouter.displayEndTime = "10:\(m) PM"
                case 14:
                    viewRouter.displayEndTime = "11:\(m) PM"
                case 15:
                    viewRouter.displayEndTime = "12:\(m) AM"
                case 16:
                    viewRouter.displayEndTime = "1:\(m) AM"
                case 17:
                    viewRouter.displayEndTime = "2:\(m) AM"
                case 18:
                    viewRouter.displayEndTime = "3:\(m) AM"
                case 19:
                    viewRouter.displayEndTime = "4:\(m) AM"
                case 20:
                    viewRouter.displayEndTime = "5:\(m) AM"
                case 21:
                    viewRouter.displayEndTime = "6:\(m) AM"
                case 22:
                    viewRouter.displayEndTime = "7:\(m) AM"
                case 23:
                    viewRouter.displayEndTime = "8:\(m) AM"
                case 24:
                    viewRouter.displayEndTime = "9:\(m) AM"
                default:
                    viewRouter.displayEndTime = "4:\(m) PM"
                    
                }
            }else{
                hours = "1 hr"
                viewRouter.displayEndTime = "10:\(m) AM"
            }
            
            
            viewRouter.movingDurationDisplay = "\(hours) \(minutes)"
            if a < 60{
                viewRouter.movingCost = String(format: "%.2f", (1.7 * Double((a*60)+60)))
            }else{
                viewRouter.movingCost = String(format: "%.2f", (1.7 * Double((a*60))))
            }
            
            
            viewRouter.hst = String(format: "%.2f", (Double(viewRouter.movingCost)! * 0.13))
            viewRouter.totalCost = String(format: "%.2f", ((Double(viewRouter.movingCost)! + Double(viewRouter.hst)!)))
            
            viewRouter.dueOnMoveDay = String(format: "%.2f", ((Double(viewRouter.totalCost)! - 100.00)))
            viewRouter.dueToday = "100.00"
            
            
            
            
            
            
        }
    }
}

struct moveDetailsViews : View {
    
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
                        
                        
                        
                        Text("Disassembly and reassembly of beds, tables and couches included")
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
                self.viewRouter.lastView = "StepThree"
                
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
        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        
    }
}

struct moveQuoteViews : View {
    
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
        .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        
    }
}

struct dueTodayView : View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        VStack(spacing: 0){
            
            stepThreeProjectManagerView()
            
            Spacer().frame(height: 30)
            
            VStack(spacing: 0){
                
                //total
                HStack(spacing: 0){
                    
                    Text("Due Today")
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
                        
                        Text("$\(String(format: "%.2f", (Double(viewRouter.movingCost)!*1.13))) CAD")
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
                
//                //total
//                HStack(spacing: 0){
//                    
//                    Spacer()
//                    
//                    Text("$\(viewRouter.dueOnMoveDay) CAD is Due on \(viewRouter.displayMoveDate)")
//                        .font(.custom("Gill Sans Light", size: 16))
//                        .fontWeight(.regular)
//                        .multilineTextAlignment(.leading)
//                        //.frame(width: 280, height: 50)
//                        //.fixedSize(horizontal: false, vertical: true)
//                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0))
//                    
//                    Spacer()
//                }
                
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

struct stepThreeProjectManagerView: View{
    
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

struct Payment_Status_Success: View{
    
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
                .padding(EdgeInsets(top: 150, leading: 10, bottom: 5, trailing: 10))
            
            
            Text("Payment successful.\n\n $\(String(format: "%.2f", (Double(viewRouter.movingCost)!*1.13))) CAD was charged to your card.")
                .font(.custom("Courier New", size: 20))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10))
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                .fixedSize(horizontal: false, vertical: true)
            
            
            Button(action: {
                
   
               
                self.viewRouter.currentView = "UpcomingMoves"
                
            }) {
                
                Text("Continue")
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

struct Payment_Status_Failure: View{
    
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
            
            Image("wrong")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 160.0, height: 160.0)
                .padding(EdgeInsets(top: 150, leading: 10, bottom: 5, trailing: 10))
            
            
            Text("Error processing payment.\n\nTry again or contact Relocator support for further assistance.")
                .font(.custom("Courier New", size: 20))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 5, trailing: 10))
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                .fixedSize(horizontal: false, vertical: true)
            
            
            Button(action: {
                
                let docData: [String: Any] = [
                    
                    "status": FieldValue.delete(),
                    
                ]
                db.collection("userData")
                    .document(viewRouter.userID)
                    .collection("allUserDocuments")
                    .document("depositPaymentRef").updateData(docData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                
                self.viewRouter.whatSectionToShow = "main"
                
                
            }) {
                
                Text("Try again")
                    .font(.custom("Gill Sans Light",size: 30))
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .foregroundColor(Color.white)
                    .background(buttonBackgroundColor)
                    .cornerRadius(25)
                    .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    .padding(EdgeInsets(top: 50, leading: 20, bottom: 150, trailing: 20))
                
            }
        }
    }
    
}

struct StepThree_Previews: PreviewProvider {
    static var previews: some View {
        StepThree()
            .environmentObject(ViewRouter())
    }
}

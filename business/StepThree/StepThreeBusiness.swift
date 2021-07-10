//
//  StepThreeBusiness.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-19.
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

struct StepThreeBusiness: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var truckItems : TruckPrimary = TruckDataPrimary[0]
    @State var DatabaseItemList : [String:Int] = [:]
    @State var backgroundColor: Color = Color(red: 0.92, green: 0.95, blue: 0.98)
    
    @State var showingAlert = false
    @State var alertMessage = ""
    
    @State var testCounter = 0
    
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
            
            if viewRouter.whatBusinessSectionToShow == "main"{
                
                ZStack{
                    
                    VStack(spacing: 0){
                        
                        VStack(spacing: 0){
                            
                            ZStack{
                                
                                HStack(spacing: 15){
                                    
                                 
                                    
                                    Button(action: {
                                        
                                        //viewRouter.deliveryCostPerCustomer
                                        self.viewRouter.totalDeliveryCost = 0.0
                                        self.viewRouter.stepThreePricingTriggered = false
                                        self.viewRouter.whatBusinessSectionToShow = "loadView"
                                        self.viewRouter.currentView = "StepTwoBusiness"
                                        
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
                                
                                
                                
                                moveDetailsBusinessViews()
                                
                                Spacer().frame(height: 30)
                                
                                moveQuoteBusinessViews()
                                
                                Spacer().frame(height: 30)
                                
                                dueTodayBusinessView()
                                
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
                                            
                                            viewRouter.viewBeforePaymentIntent = "business"
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
                                    
                                    let str = String(format: "%.2f", viewRouter.totalDeliveryCost*1.13)
                                    let array = str.components(separatedBy: ".")
                                    let a = Int(array[0])!*100
                                    let b = Int(array[1])!
                                    let c = a+b
                                    
                                   
                                    if viewRouter.totalDeliveryCost > viewRouter.minimumOrderAmount{
                                    if viewRouter.doesPaymentMethodExist != false {
                                        
                                       

                                        functions.httpsCallable("captureBusinessPayment").call(["cus": "\(viewRouter.cust)","pm": "\(viewRouter.pm)","userID": "\(viewRouter.userID)","amount": "\(c)"]) { (result, error) in
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
                                        
                                        viewRouter.fromPaymentTrigger = true
                                        viewRouter.whatBusinessSectionToShow = "loading"
                                        
                                    }else{
                                        alertMessage = "Please add a payment method to proceed."
                                        showingAlert = true
                                    }
                                    }else{
                                        alertMessage = "The pre-tax minimum order amount is $\(String(format: "%.0f", (viewRouter.minimumOrderAmount))) CAD"
                                        showingAlert = true
                                    }
                                    
                                    
                                }) {
                                    
                                    Text("PAY $ \(String(format: "%.2f", viewRouter.totalDeliveryCost*1.13)) CAD")
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
                .onAppear(perform: updateViewData)
                .ignoresSafeArea(.all, edges: .top)
                
            }else if viewRouter.whatBusinessSectionToShow == "success" {
                BusinessPayment_Status_Success()
            }else if viewRouter.whatBusinessSectionToShow == "failure"{
                BusinessPayment_Status_Failure()
            }else if viewRouter.whatBusinessSectionToShow == "loading"{
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
            }else if viewRouter.whatBusinessSectionToShow == "loadView"{
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
                    if self.counter == 8 {
                                       self.timer.upstream.connect().cancel()
                        viewRouter.whatBusinessSectionToShow = "main"
                        
                                   }

                                   self.counter += 1
                    }
                .padding(EdgeInsets(top: 280, leading: 20, bottom: 0, trailing: 20))
            }
            
            
        }
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Important"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    func updateViewData(){
        
        viewRouter.fromPaymentTrigger = false
        viewRouter.deliveryListOrigin = "stepthree"
        
        db.collection("userData")
            .document(viewRouter.userID)
            .collection("allUserDocuments")
            .document("businessPaymentRef").addSnapshotListener{ (document, error) in
                if let document = document, document.exists {
                    let userInfo : [String: Any] = document.data()!
                    
                    testCounter += 1
                    print("ilykugnwuvy: \(testCounter)")
                    
                    let statusCode = userInfo["status"] as? String ?? "Unpaid"
                    if statusCode == "success" && viewRouter.fromPaymentTrigger{
                        
                        
                       
                        var ref: DocumentReference? = nil
                        
                        let docData: [String: Any] = [
                            
                            "inspectionDate": viewRouter.inspectionDay,
                            "originAddress": viewRouter.businessPickupDisplayAddress,
                            "userID": viewRouter.userID,
                            "numberOfDeliveries": "\(viewRouter.selectedCustomers.count)",
                            "moveWithoutHst": viewRouter.totalDeliveryCost,
                            "moveWithHst": "\(String(format: "%.2f",(viewRouter.totalDeliveryCost*1.13)))",
                            "moveHst": "\(String(format: "%.2f",(viewRouter.totalDeliveryCost*0.13)))",
                            "selectedCustomers": viewRouter.selectedCustomers,
                            "deliveryCostPerCustomer": viewRouter.deliveryCostPerCustomer,
                            "deliveryDate": viewRouter.displayDeliveryDay,
                            "manPower": viewRouter.serviceTypeVehicle,
                            "truckFeet": viewRouter.serviceTypeMovers,
                            "moveStartTime": "11:30 AM",
                            "assignmentStatus": "Unassigned",
                            "ServiceSelectorCounter" : viewRouter.ServiceSelectorCounter,
                           
                            
                        ]
                        
                        
                        
                        ref = db.collection("confirmedBusinessMovesUnassigned").document("\(viewRouter.displayDeliveryDay)").collection("\(viewRouter.userID)").addDocument(data: docData){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        let docDataTwo: [String: Any] = [
                            
                            "moveID": "\(ref!.documentID)",
                            "inspectionDate": viewRouter.inspectionDay,
                            "originAddress": viewRouter.businessPickupDisplayAddress,
                            "userID": viewRouter.userID,
                            "numberOfDeliveries": "\(viewRouter.selectedCustomers.count)",
                            "moveWithoutHst": viewRouter.totalDeliveryCost,
                            "moveWithHst": "\(String(format: "%.2f",(viewRouter.totalDeliveryCost*1.13)))",
                            "moveHst": "\(String(format: "%.2f",(viewRouter.totalDeliveryCost*0.13)))",
                            "selectedCustomers": viewRouter.selectedCustomers,
                            "deliveryCostPerCustomer": viewRouter.deliveryCostPerCustomer,
                            "deliveryDate": viewRouter.displayDeliveryDay,
                            "manPower": viewRouter.serviceTypeMovers,
                            "truckFeet": viewRouter.serviceTypeVehicle,
                            "moveStartTime": "11:30 AM",
                            "assignmentStatus": "Unassigned",
                            "ServiceSelectorCounter" : viewRouter.ServiceSelectorCounter,
                        
                            
                        ]
                        
                        db.collection("confirmedBusinessMovesUnassigned").document("\(viewRouter.displayDeliveryDay)").collection("\(viewRouter.userID)").document("\(ref!.documentID)").setData(docDataTwo){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        db.collection("userData").document("\(viewRouter.userID)").collection("confirmedBusinessMoves").document("\(ref!.documentID)").setData(docDataTwo){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        
                        self.viewRouter.whatBusinessSectionToShow = "success"
                        viewRouter.fromPaymentTrigger = false
                        
                    }else if statusCode == "Unpaid" {
                        self.viewRouter.whatBusinessSectionToShow = "main"
                    }else if statusCode == "failure"{
                        self.viewRouter.whatBusinessSectionToShow = "failure"
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
        
        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS\(viewRouter.ServiceSelectorCounter)").getDocuments(){ (querySnapshot, error) in
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
        
        if viewRouter.stepThreePricingTriggered == false{
            
            
            
        db.collection("userData").document("\(viewRouter.userID)").collection("businessCustomersS\(viewRouter.ServiceSelectorCounter)").addSnapshotListener(){ (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                
                viewRouter.totalDeliveryCost = 0.0
                
                for document in querySnapshot!.documents {
                    
                   
                    let customerInfo : [String: Any] = document.data()
                    
                  
                  
                    viewRouter.stepThreePricingTriggered = true
                    
                    print("Pricing function was triggered: Again")
                        
                        if viewRouter.selectedCustomers.keys.contains(customerInfo["customerPhoneNumber"]as? String ?? "")
                        {
                            if viewRouter.ServiceSelectorCounter == 1{
                                viewRouter.totalDeliveryCost = viewRouter.totalDeliveryCost + (Double(customerInfo["businessToCustomerDistance"]as? Int ?? 10000) * 0.0019)
                                viewRouter.deliveryCostPerCustomer[customerInfo["customerPhoneNumber"]as? String ?? ""] = (Double(customerInfo["businessToCustomerDistance"]as? Int ?? 10000) * 0.0019)
                            }else if viewRouter.ServiceSelectorCounter == 2{
                                viewRouter.totalDeliveryCost =  viewRouter.totalDeliveryCost + (Double(customerInfo["businessToCustomerDistance"]as? Int ?? 10000) * 0.0046)
                                viewRouter.deliveryCostPerCustomer[customerInfo["customerPhoneNumber"]as? String ?? ""] = (Double(customerInfo["businessToCustomerDistance"]as? Int ?? 10000) * 0.0046)
                            }else if viewRouter.ServiceSelectorCounter == 3{
                                viewRouter.totalDeliveryCost =  viewRouter.totalDeliveryCost + (Double(customerInfo["businessToCustomerDistance"]as? Int ?? 10000) * 0.00691)
                                viewRouter.deliveryCostPerCustomer[customerInfo["customerPhoneNumber"]as? String ?? ""] = (Double(customerInfo["businessToCustomerDistance"]as? Int ?? 10000) * 0.00691)
                            }
                           
                            
                        }
                        
                   
                    
                    
                    
                    
                    
                }
            }
            
            
        }
            
        }
        
        for (_,value) in viewRouter.selectedCustomers{
            
            for ( customerID,customerAddressPlaceID) in (value as![String:String]){
                
                functions.httpsCallable("businessDistanceCalculator").call(["customerID":customerID,"userID":"\(viewRouter.userID)","pidO":"\(viewRouter.placeIDBusiness)","pidD":customerAddressPlaceID])
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
                
            }
        }
        
       
        
    }
}

struct moveDetailsBusinessViews : View {
    
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
                
               
                  print("jhkwegbjyec DC: \(viewRouter.deliveryCostPerCustomer)")
                print("jhkwegbjyec VRBC: \(viewRouter.BusinessCustomersList)")
                
                self.viewRouter.currentView = "ViewDeliveryList"
                self.viewRouter.lastView = "StepThree"
                
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

struct moveQuoteBusinessViews : View {
    
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

struct dueTodayBusinessView : View {
    
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
                
                
                //minimumOrderValue
                if viewRouter.totalDeliveryCost < viewRouter.minimumOrderAmount{
                    Divider().background(Color.black).frame(width: 120)
                    HStack(spacing: 0){
                        
                        Spacer()
                        
                        Text("The pre-tax minimum order amount is $\(String(format: "%.0f", (viewRouter.minimumOrderAmount))) CAD")
                            .font(.custom("Gill Sans Light", size: 16))
                            .foregroundColor(.red)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.leading)
                            //.frame(width: 280, height: 50)
                            //.fixedSize(horizontal: false, vertical: true)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0))
                        
                        Spacer()
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
}

struct stepThreeProjectManagerBusinessView: View{
    
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

struct BusinessPayment_Status_Success: View{
    
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
            
            
            Text("Payment successful.\n\n$\(String(format: "%.2f",(viewRouter.totalDeliveryCost*1.13))) CAD was charged to your card.")
                .font(.custom("Courier New", size: 20))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 50, trailing: 10))
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                .fixedSize(horizontal: false, vertical: true)
            
            
            Button(action: {
                
                self.viewRouter.currentView = "UpcomingDeliveries"
                
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

struct BusinessPayment_Status_Failure: View{
    
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
                    .document("businessPaymentRef").updateData(docData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                
                self.viewRouter.whatBusinessSectionToShow = "main"
                
                
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

struct StepThreeBusiness_Previews: PreviewProvider {
    static var previews: some View {
        StepThreeBusiness()
            .environmentObject(ViewRouter())
    }
}

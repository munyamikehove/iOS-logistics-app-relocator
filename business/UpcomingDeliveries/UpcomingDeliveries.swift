//
//  UpcomingDeliveries.swift
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

struct UpcomingDeliveries: View {
    
    @State var user = Auth.auth().currentUser
    @State var db = Firestore.firestore()
    @State var functions = Functions.functions()
    @EnvironmentObject var viewRouter: ViewRouter
    @State var allDeliveries : individualDeliveries = deliveriesDataPrimary[0]
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var cardStrokeColor: Color = Color(red: 0.11, green: 0.15, blue: 0.15)
    
    
    var body: some View {
        VStack{
            
            ZStack{
                
                HStack(spacing: 15){
                    
                    Button(action: {
                        viewRouter.appSectionOnDisplay = "Business Deliveries"
                        self.viewRouter.currentView = "LandingPage"
                        //self.viewRouter.TruckDataPrimary.removeAll()
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
                
                
                
                Text("Your Deliveries")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.trailing,10)
                
                
                
            }
            .padding()
            //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            
            
            ScrollView{
                
                ForEach(viewRouter.userDeliveries) { item in
                    
                    
                    //singleMoveView(item: item)
                    VStack(spacing: 0){
                        
                        HStack{
                            
                            Spacer()
                            
                            Text("\(item.deliveryDate)")
                                .font(.custom("Gill Sans Light", size: 20))
                                .fontWeight(.regular)
                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                            
                            Spacer()
                        }
                        
                        Divider().background(Color.black).frame(width: 140)
                        
                        
                        // deliveries
                        VStack(spacing: 0){
                            
                            
                            HStack(spacing: 0){
                                
                                Image("journey")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25,height: 50)
                                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 0))
                                
                                HStack(spacing: 0){
                                    
                                    if Int(item.numberOfDeliveries) == 1 {
                                        Text("\(item.numberOfDeliveries) Delivery")
                                            .font(.custom("Gill Sans Light", size: 18))
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                            //.frame(width: 280, height: 50)
                                            //.fixedSize(horizontal: false, vertical: true)
                                            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                                    }else{
                                        Text("\(item.numberOfDeliveries) Deliveries")
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
                                    
                                    Text("From \(item.originAddress)")
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
                                    
                                    Text("\(item.deliveryDate)")
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
                        
                        Button(action: {
                            
                            self.viewRouter.currentView = "UpcomingDeliveryDetails"
                            self.viewRouter.currentMoveID = "\(item.documentID)"
                            
                        }) {
                            
                            Text("View Details")
                                .font(.custom("Gill Sans Light", size: 20))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
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
                
                Spacer().frame(height: 100)
            }.background(Color.black.opacity(0.09))
           
        }
        .onAppear{
            
            self.viewRouter.BusinessCustomersList.removeAll()
            viewRouter.selectedCustomers.removeAll()
            viewRouter.userDeliveries.removeAll()
            
            for item in viewRouter.userDeliveries {
                
                if item.documentID == "test"{
                    //count = item.itemCount
                    viewRouter.userDeliveries.removeAll(where: { $0.documentID == "test" })
                }
                
            }
            
            db.collection("userData")
                .document(viewRouter.userID)
                .collection("allUserDocuments")
                .document("businessPaymentRef").updateData([
                    "status": FieldValue.delete()
                ]);
            
            db.collection("userData").document("\(viewRouter.userID)").collection("confirmedBusinessMoves").getDocuments(){ (querySnapshot, error) in
                if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            let moveInfo : [String: Any] = document.data()
                          
                               
                            viewRouter.userDeliveries.append(individualDeliveries(documentID:"\(moveInfo["moveID"]as? String ?? "")",originAddress:moveInfo["originAddress"] as? String ?? "",numberOfDeliveries:moveInfo["numberOfDeliveries"] as? String ?? "",deliveryTime:"Delivery pick-up at 11:30 AM",deliveryDate:moveInfo["deliveryDate"] as? String ?? ""))
                                
                            
                            print("totalMovesAre: \(viewRouter.userDeliveries)")
                            
                            
                            
                        }
                    }

                
            }
            
            if viewRouter.userDeliveries.count > 0{
                
                allDeliveries = viewRouter.userDeliveries[0]
                
            }
            
        }
    }
}

// For upcoming moves....
struct individualDeliveries: Identifiable {
    let id = UUID()
    let documentID: String
    let originAddress : String
    let numberOfDeliveries: String
    let deliveryTime: String
    let deliveryDate: String
    
    
}

var deliveriesDataPrimary = [individualDeliveries( documentID:"test",originAddress:"test",numberOfDeliveries:"test",deliveryTime:"test",deliveryDate:"test")]

struct UpcomingDeliveries_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingDeliveries()
            .environmentObject(ViewRouter())
    }
}

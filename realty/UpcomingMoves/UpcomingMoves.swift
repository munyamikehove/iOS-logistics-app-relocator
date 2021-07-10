//
//  UpcomingMoves.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-09.
//

import SwiftUI
import AlertToast
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

struct UpcomingMoves: View {
    
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
                        viewRouter.appSectionOnDisplay = "House Moves"
                        self.viewRouter.currentView = "LandingPage"
                        self.viewRouter.TruckDataPrimary.removeAll()
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
                
                
                
                Text("Your Moves")
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
                
                ForEach(viewRouter.userMoves) { item in
                    
                    
                    //singleMoveView(item: item)
                    VStack(spacing: 0){
                        
                        HStack{
                            
                            Spacer()
                            
                            Text("\(item.moveDate)")
                                .font(.custom("Gill Sans Light", size: 20))
                                .fontWeight(.regular)
                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 10))
                            
                            Spacer()
                        }
                        
                        Divider().background(Color.black).frame(width: 140)
                        
                        // addresses
                        VStack(spacing: 0){
                            
                            
                            
                            HStack(spacing: 0){
                                
                                Image("fromto")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 100)
                                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0))
                                
                                VStack(spacing: 0){
                                    
                                    Text("\(item.originAddress)")
                                        .font(.custom("Gill Sans Light", size: 16))
                                        .fontWeight(.regular)
                                        .multilineTextAlignment(.leading)
                                        .frame(width: 250, height: 50)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                    
                                    
                                    
                                    Text("\(item.destinationAddress)")
                                        .font(.custom("Gill Sans Light", size: 16))
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
                        
                        //time
                        VStack(spacing: 0){
                            
                            
                            HStack(spacing: 0){
                                
                                Image("clock")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20,height: 50)
                                    .padding(EdgeInsets(top: 0, leading: 18, bottom: 10, trailing: 0))
                                
                                HStack(spacing: 0){
                                    
                                    Text("9:00 AM - \(item.moveEndTime)")
                                        .font(.custom("Gill Sans Light", size: 16))
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
                            
                            self.viewRouter.currentView = "UpcomingMoveDetails"
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
            
            viewRouter.TruckDataPrimary.removeAll()
            viewRouter.userMoves.removeAll()
            
            for item in viewRouter.userMoves {
                
                if item.documentID == "test"{
                    //count = item.itemCount
                    viewRouter.userMoves.removeAll(where: { $0.documentID == "test" })
                }
                
            }
            
            db.collection("userData")
                .document(viewRouter.userID)
                .collection("allUserDocuments")
                .document("depositPaymentRef").updateData([
                    "status": FieldValue.delete()
                ]);
            
            db.collection("userData").document("\(viewRouter.userID)").collection("confirmedMoves").getDocuments(){ (querySnapshot, error) in
                if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            let moveInfo : [String: Any] = document.data()
                          
                               
                            viewRouter.userMoves.append(individualMoves(documentID:"\(moveInfo["moveID"]as? String ?? "")",originAddress:moveInfo["originAddress"] as? String ?? "",destinationAddress:moveInfo["destinationAddress"] as? String ?? "",moveEndTime:moveInfo["moveEndTime"] as? String ?? "",moveDate:moveInfo["moveDate"] as? String ?? ""))
                                
                            
                            print("totalMovesAre: \(viewRouter.userMoves)")
                            
                            
                            
                        }
                    }

                
            }
            
            if viewRouter.userMoves.count > 0{
                
                allMoves = viewRouter.userMoves[0]
                
            }
            
        }
    }
}

// For upcoming moves....
struct individualMoves: Identifiable {
    let id = UUID()
    let documentID: String
    let originAddress : String
    let destinationAddress: String
    let moveEndTime: String
    let moveDate: String
    
    
}

var movesDataPrimary = [individualMoves( documentID:"test",originAddress:"test",destinationAddress:"test",moveEndTime:"test",moveDate:"test")]

struct UpcomingMoves_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingMoves()
            .environmentObject(ViewRouter())
    }
}

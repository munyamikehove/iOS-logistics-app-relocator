//
//  TruckView.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-26.
//

import SwiftUI
import Foundation
import Combine

struct TruckView: View {
    var body: some View {
        Body_TruckView()
    }
}

struct Body_TruckView: View {
    
    // Offset Value...
    // SInce were going to fetch offset for both vertical and horizontal so were using CGPoint....
    //@State var offset: CGPoint = .zero
    @EnvironmentObject var viewRouter: ViewRouter
    @State var truckItems : TruckPrimary = TruckDataPrimary[0]
    
    var body: some View{
        
        VStack(spacing: 0){
            

            VStack(spacing: 0){
                
                ZStack{
                    
                    HStack(spacing: 15){
                        
                        Button(action: {
                            if self.viewRouter.lastView == "StepTwo"{
                                self.viewRouter.currentView = "StepTwo"
                            }else if self.viewRouter.lastView == "StepThree"{
                                self.viewRouter.currentView = "StepThree"
                            }else if self.viewRouter.lastView == "UpcomingMoveDetails"{
                                self.viewRouter.currentView = "UpcomingMoveDetails"
                            }
                            
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
                            
                            //                            Circle()
                            //                                .fill(Color.red)
                            //                                .frame(width: 15, height: 15)
                            //                                .offset(x: -26, y: -7)
                            //                                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5))
                        })
                    }
                    
                    
                    
                    Text("Items in Moving Truck")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.trailing,10)
                    
                    
                    
                }
                .padding()
                //.padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                
                
                
                
                
                
            }
            
            // General Ssroll View Content....
            VStack(spacing: 15){
                
                //Spacer()
                ScrollView{
                    ForEach(viewRouter.TruckDataPrimary) { item in

                        HStack(spacing: 25){

                            VStack(alignment: .leading, spacing: 8, content: {

                                Text(item.itemName)
                                    .font(.title3)
                                    .fontWeight(.regular)


                            })
                            .frame(maxWidth: .infinity, alignment: .leading)

                            Text("\(item.itemCount)")
                                .font(.title3)
                                .fontWeight(.regular)
                                .padding(.trailing, 20)

                        }
                        .padding(.horizontal)

                        Divider().background(Color.black).frame(width: 240)
                    }
                }
                
                
                Spacer()
                
                if self.viewRouter.lastView != "UpcomingMoveDetails"{
                Button(action: {
                    self.viewRouter.currentView = "StepThree"
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
                .padding(.top,10)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                }
            }
            .padding(.top)
            
      
        }
        .onAppear{
            truckItems = viewRouter.TruckDataPrimary[0]
            
        }
    }
}




struct TruckView_Previews: PreviewProvider {
    static var previews: some View {
        TruckView()
            .environmentObject(ViewRouter())
    }
}

struct TruckPrimary: Identifiable {
    let id = UUID()
    let itemName: String
    let itemCount: Int
}

var TruckDataPrimary = [
    
    TruckPrimary(itemName: "Other Items", itemCount: 0),
   
    ]

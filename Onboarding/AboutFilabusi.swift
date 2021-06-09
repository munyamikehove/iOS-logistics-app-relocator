//
//  AboutUpscale.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI
import AlertToast
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

struct AboutFilabusi: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var backgroundColor: Color = Color(red: 0.92, green: 0.95, blue: 0.98)
    
    
    var body: some View {
        VStack{
            
            if viewRouter.AboutAppCounter == 1 {
                FirstView_AboutUpscale()
            }else if viewRouter.AboutAppCounter == 2 {
                SecondView_AboutUpscale()
            }else if viewRouter.AboutAppCounter == 3 {
                ThirdView_AboutUpscale()
            }else if viewRouter.AboutAppCounter == 4 {
                FourthView_AboutUpscale()
            }

        }
    }
}

struct FirstView_AboutUpscale: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color("bag1")
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View {
        VStack{
            
            HStack(spacing: 0){
                
                Button(action: {}, label: {
                    
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
                          
                          //self.viewRouter.currentView = "DashboardView"
                          
                      }) {
                          
                          Text("Tap here to view upcoming moves")
                              .font(.custom("Gill Sans Light", size: 20))
                              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.gray.opacity(0.15))
                            .padding(EdgeInsets(top: 20, leading: 30, bottom: 5, trailing: 30))
                            
                          //.fixedSize(horizontal: false, vertical: true)
                          
                      }
            
        }.onAppear{
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

struct SecondView_AboutUpscale: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var scrollerColor: Color = Color(red: 0.96, green: 0.97, blue: 0.97)
    
    var body: some View {
        VStack{
            
            HStack(spacing: 0){

               Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55.0, height: 35.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                Text("Step 2 instructions")
                    .foregroundColor(strokeColor)
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))


                Spacer()
                
                HStack(spacing: 8){
                    
                  
                   
                    
                }.padding(5)
                .background(Color.black.opacity(0.0))
                .cornerRadius(5)

                Spacer().frame(width: 50)
            
            }
            
            Image("slide2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 350)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            

            
            ScrollView{
                
                            Text("Step 2\nInstructions")
                                .font(.custom("Gill Sans Light", size: 25))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                
                Text("On the next page, select all items that you are moving from your current residence. This will help us decide what size van to bring for the move.\n\nWe provide mattress covers and moving boxes on request.\n\nWe will also disassemble beds, furniture and some exercise equipment.\n\nRemember not to use plastic bags for packing as we have a no plastic-bag policy.")
                    .font(.custom("Courier New", size: 20))
                    .foregroundColor(.black)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(.bottom,5)
                
               
                   
            }
            .background(scrollerColor)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 240, maxHeight: 240, alignment: .top)
            
            Button(action: {
                self.viewRouter.currentView = "StepTwo"
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
            //.padding(.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
         
            
        }
    }
}

struct ThirdView_AboutUpscale: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    
    
    var body: some View {
        VStack{
            
            HStack(spacing: 0){

               Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 55.0, height: 35.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                Text("Using Relocator")
                    .foregroundColor(strokeColor)
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))


                Spacer()
                
                HStack(spacing: 8){
                    
                  
                   
                    
                }.padding(5)
                .background(Color.black.opacity(0.0))
                .cornerRadius(5)

                Spacer().frame(width: 50)
            
            }
            
            Image("slide3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            
            Text("Step 3\nCheck into your hotel ")
                .font(.custom("Gill Sans Light", size: 25))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
            
            Text("We will email your return flight boarding pass once you arrive at your destination and check into your stay.")
                .font(.custom("Courier New", size: 20))
                .foregroundColor(.black)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200, alignment: .top)
            
            
            HStack{
                Button(action: {
                  
                    self.viewRouter.AboutAppCounter = 2
                    
                }) {
                    
                    Text("Back")
                        .font(.system(size: 30))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                    
                    
                }
                .background(buttonBackgroundColor)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                
                Spacer()
                
                Image("bd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Image("bd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Image("pd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Image("bd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                
                Spacer()
                
                Button(action: {
                  
                    self.viewRouter.AboutAppCounter = 4
                    
                }) {
                    
                    Text("Next")
                        .font(.system(size: 30))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                    
                    
                }
                .background(buttonBackgroundColor)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                
            }
            
            
         
            
        }
    }
}

struct FourthView_AboutUpscale: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    
    
    var body: some View {
        VStack{
            
            HStack(spacing: 0){

               Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                .frame(width: 55.0, height: 35.0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))

                Text("Using Relocator")
                    .foregroundColor(strokeColor)
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))


                Spacer()
                
                HStack(spacing: 8){
                    
                  
                   
                    
                }.padding(5)
                .background(Color.black.opacity(0.0))
                .cornerRadius(5)

                Spacer().frame(width: 50)
            
            }
            
            Image("slide4")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            
            Text("Step 4\nRelax, Enjoy, and have fun!")
                .font(.custom("Gill Sans Light", size: 25))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
            
            Text("Use the Zerojet app to find the best your destination has to offer!")
                .font(.custom("Courier New", size: 20))
                .foregroundColor(.black)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 200, alignment: .top)
            
            
            HStack{
                Button(action: {
                  
                    self.viewRouter.AboutAppCounter = 3
                    
                }) {
                    
                    Text("Back")
                        .font(.system(size: 30))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                    
                    
                }
                .background(buttonBackgroundColor)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                
                Spacer()
                
                Image("bd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Image("bd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Image("bd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                Image("pd")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 10, maxWidth: 10, minHeight: 10, maxHeight: 10)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                
                Spacer()
                
                Button(action: {
                  
                    self.viewRouter.currentView = "Home"
                    
                }) {
                    
                    Text("Start")
                        .font(.system(size: 30))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                    
                    
                }
                .background(buttonBackgroundColor)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
                
                
            }
            
            
           
            
        }
    }
}

struct AboutFilabusi_Previews: PreviewProvider {
    static var previews: some View {
        AboutFilabusi().environmentObject(ViewRouter())
    }
}

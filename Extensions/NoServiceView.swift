//
//  NoServiceView.swift
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

struct NoServiceView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var buttonBackgroundColor: Color = Color(red: 0.42, green: 0.41, blue: 1.00)
    @State var strokeColor: Color = Color("bag1")
    @State var scrollerColor: Color = Color(red: 0.96, green: 0.97, blue: 0.97)
    
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View {
        VStack{
            
           
            
            
            Image("unavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 350)
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
            
            
            Text("Service Area Notice")
                .font(.custom("Gill Sans Light", size: 25))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
            
            ScrollView{
                
                Text("We currently only offer service in the Greater Toronto and Hamilton Area.\n\n Service in the following cities will begin on the 1st of September 2021:\nCalgary\nEdmonton\nHalifax\nMontreal\nOttawa\nQuebec City\nVancouver\nWinnipeg")
                    .font(.custom("Courier New", size: 20))
                    .foregroundColor(.black)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                
            }
            .background(scrollerColor)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 380, alignment: .top)
            
          
            
            
            
            
            Button(action: {
             
                if viewRouter.stepOneOrigin == "moving"{
                    ref.child("QuickRef").child("\(viewRouter.userID)").setValue(["distanceFromMidtownToronto": nil])
                    ref.child("QuickRef").child("\(viewRouter.userID)").setValue(["originToDestinationDistance": nil])
                    self.viewRouter.currentView = "StepOne"
                }else{
                    ref.child("businessQuickRef").child("\(viewRouter.userID)").setValue(["distanceFromMidtownToronto": nil])
                    viewRouter.whatBusinessStepOneSectionToShow = "main"
                    self.viewRouter.currentView = "StepOneBusiness"
                }
     
            }) {
                
                Text("CHANGE ADDRESS")
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

struct NoServiceView_Previews: PreviewProvider {
    static var previews: some View {
        NoServiceView()
            .environmentObject(ViewRouter())
    }
}

//
//  DeliveryRangeExceeded.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-24.
//

import SwiftUI
import AlertToast
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

struct DeliveryRangeExceeded: View {
    
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
            
            
            Text("Delivery Range Exceeded")
                .font(.custom("Gill Sans Light", size: 25))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
            
            ScrollView{
                
                switch viewRouter.ServiceSelectorCounter{
                case 1:
                    Text("The customer address is outside the 5 km service delivery range. Please change the service delivery type by returning to step one or contact customer support for further assistance.")
                        .font(.custom("Courier New", size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                case 2:
                    Text("The customer address is outside the 25 km service delivery range. Please change the service delivery type by returning to step one or contact customer support for further assistance.")
                        .font(.custom("Courier New", size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                case 3:
                    Text("The customer address is outside the 50 km service delivery range. Please change the service delivery type by returning to step one or contact customer support for further assistance.")
                        .font(.custom("Courier New", size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                default:
                    Text("The customer address is outside the service delivery range. Please change the service delivery type by returning to step one or contact customer support for further assistance.")
                        .font(.custom("Courier New", size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 15, trailing: 10))
                        //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .top)
                    
                }
                
                
                
            }
            .background(scrollerColor)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 10))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 380, alignment: .top)
            
          
            
            
            
            
            Button(action: {
             
                ref.child("businessQuickRef").child("\(viewRouter.userID)").setValue(["customerDistanceFromBusiness": nil])
                viewRouter.whatBusinessCustomerCreationSectionToShow = "main"
                viewRouter.placeIDCustomer = ""
                viewRouter.customerDeliveryAddress = "Customer address here"
                self.viewRouter.currentView = "AddCustomerStepOne"
                
     
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

struct DeliveryRangeExceeded_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryRangeExceeded()
            .environmentObject(ViewRouter())
    }
}

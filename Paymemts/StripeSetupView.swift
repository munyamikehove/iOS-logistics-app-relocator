//
//  StripeSetupView.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-06.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth
import FirebaseFunctions

struct StripeSetupView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var purpleCardColor: Color = Color(red: 0.35, green: 0.30, blue: 0.73)
    @State var showingAlert = false
    @State var alertMessage = ""
    let db = Firestore.firestore()
    @State var functions = Functions.functions()
    @State var userID = Auth.auth().currentUser?.uid
    
    func makeUIView(){
  
        if !self.viewRouter.firstName.isEmpty {
            if !self.viewRouter.lastName.isEmpty {
                if !self.viewRouter.email.isEmpty {
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = viewRouter.firstName
                    changeRequest?.commitChanges { (error) in
                        // ...
                        print("Error with user name capture : \(String(describing: error))")
                    }
                    
                    Auth.auth().currentUser?.updateEmail(to: viewRouter.email) { (error) in
                        // ...
                        print("Error with email capture : \(String(describing: error))")
                    }
                    
                    functions.httpsCallable("createCustomer").call(["userName": "\(viewRouter.firstName) \(viewRouter.lastName)","userEmail": "\(viewRouter.email)","userID": "\(viewRouter.userID)"]) { (result, error) in
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
                    
                    let docData: [String: Any] = [
                        "firstName": viewRouter.firstName,
                        "lastName": viewRouter.lastName,
                        "userEmail": viewRouter.email,
                        "userDOB": viewRouter.birthday,
                        "joinDate": String(describing:Date())
                    ]
                    db.collection("userData").document(viewRouter.userID).collection("allUserDocuments").document("identification").setData(docData) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    db.collection("userData")
                        .document(self.viewRouter.userID)
                        .collection("allUserDocuments")
                        .document("stripeCustomerProfile").addSnapshotListener{ (document, error) in
                            if let document = document, document.exists {
                                let resultingData : [String: Any] = document.data()!
                                let userInfo : [String: Any] = resultingData["resultingData"] as! [String : Any]


                                let halfCode = userInfo["id"] as! String
                                viewRouter.paymentAuthCode = "\(halfCode)}{\(viewRouter.userID)";


                            } else {
                                //Deal with error &/ document doesn't exist here
                            }
                        }

                    self.viewRouter.currentView = "PaymentsSetupView"
                    
                    
                    
                }else{
                    alertMessage = "Please enter your email address"
                    showingAlert = true
                }
            }else{
                alertMessage = "Please enter your last name"
                showingAlert = true
            }
        }else{
            alertMessage = "Please enter your first name"
            showingAlert = true
        }
        
        // self.viewRouter.currentView = "DashboardView"
    }
    
    var body: some View {
        
        
        VStack{
            
            ScrollView {
                
                BodyView_StripeSetup()
                
                Button(action: {
                    
                    // What to perform
                    makeUIView()
                   
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
                .padding(.top)
                .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                
              
                
                Button(action: {
                    
                    self.viewRouter.currentView = "StepThree"
                    
                }) {
                    
                    Text("Back to Quote")
                        .font(.custom("Gill Sans Light", size: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                      .background(Color.gray.opacity(0.15))
                      .padding(EdgeInsets(top: 20, leading: 30, bottom: 5, trailing: 30))
                      
                    
                }
                
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Important"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
        }
        .onAppear{
            
            viewRouter.userID = userID ?? "currentUser"
            
        }
        
    }
    
    
}

struct BodyView_StripeSetup: View {
    
    
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var backgroundColor: Color = Color(red: 0.92, green: 0.95, blue: 0.98)
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                
                
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45.0, height: 25.0)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 0))
                
                Text("Account Setup")
                    .foregroundColor(strokeColor)
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0))
                
              
                Spacer()
                
            }
            
            ViewHolder_StripeSetup()
            
            
            
            Spacer()
        }
        
    }
}

struct ViewHolder_StripeSetup: View {
    
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var backgroundColor: Color = Color(red: 0.92, green: 0.95, blue: 0.98)
    @State var purpleCardColor: Color = Color(red: 0.35, green: 0.30, blue: 0.73)
    @EnvironmentObject var viewRouter: ViewRouter
    
    
    var body: some View {
        VStack(spacing: 0){
            
            Image("logistics")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity , minHeight: 0, maxHeight: 220)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
               
            
            MemberDetailsView_StripeSetup()
            
      
            
            
            
            Spacer()
            
        }
        
        
        
        
        
        
    }
}

struct MemberDetailsView_StripeSetup: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State var purpleCardColor: Color = Color(red: 0.35, green: 0.30, blue: 0.73)
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    
    
    
    var closedRange: ClosedRange<Date> {
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -6570, to: Date())!
        let fiveDaysAgo = Calendar.current.date(byAdding: .day, value: -32850, to: Date())!
        
        return fiveDaysAgo...twoDaysAgo
    }
    
    var body: some View{
        
        VStack(spacing: 0){
            
            VStack(spacing: 0){
                
                HStack{
                    Text("Account setup info")
                        .foregroundColor(Color.black)
                        .font(.custom("Menlo Regular",size: 22.5))
                        .fontWeight(.semibold)
                    
                    
                    Spacer()
                }.padding(EdgeInsets(top: 20, leading: 25, bottom: 10, trailing: 0))
                
                HStack{
                    
                    
                    TextField("Legal First Name", text: $viewRouter.firstName)
                        .foregroundColor(Color.black)
                        .font(.system(size: 24))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                
                HStack{
                    
                    
                    TextField("Legal last Name", text: $viewRouter.lastName)
                        .foregroundColor(Color.black)
                        .font(.system(size: 24))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                
                HStack{
                    
                    
                    TextField("Email Address", text: $viewRouter.email)
                        .foregroundColor(Color.black)
                        .font(.system(size: 24))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                HStack{
                    Text("Birth Date")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 24))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                    
                    DatePicker("", selection: $viewRouter.birthday, in: closedRange, displayedComponents: .date)
                        .background(Color.white)
                    
                    
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15.0)
                        .stroke(Color.black,lineWidth: 0.5)
                        .shadow(color: .white, radius: 0.5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                
                

            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            Spacer()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 600)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .gray, radius: 5, x: 2, y: 2)
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        
    }
    
}

struct FooterView_StripeSetup: View{
    
    
    var body: some View{
        VStack(spacing: 0){
            
            
            Text("By tapping Continue, you agree to all Relocator Terms of Service")
                .font(.custom("Courier New", size: 20))
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct StripeSetupView_Previews: PreviewProvider {
    static var previews: some View {
        StripeSetupView()
    }
}

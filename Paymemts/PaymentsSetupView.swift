//
//  PaymentsSetupView.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-07.
//

import SwiftUI
import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import AVKit
import SDWebImageSwiftUI
import ToastSwiftUI
import WebKit
import UIKit

struct PaymentsSetupView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isPresentingToast = false
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var user = Auth.auth().currentUser
    @State var userID = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @State var alertMessage = "This will allow you to pay for goods and services on Relocator."
    @State var showingAlert = false
    
    var body: some View {
        VStack(spacing: 0){
            
            
               
                    
           HStack(spacing: 0){
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45.0, height: 25.0)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        Text("Relocator Pay Setup")
                            .foregroundColor(strokeColor)
                            .font(.title)
                            .fontWeight(.ultraLight)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        
                        Spacer()
                    }
                 
                    
            Spacer().frame(height:30)
                 
                
            if viewRouter.RelocatorPayCurrentView == "Relocator Pay Setup"{
                

            
                Button(action: {

                    db.collection("userData")
                        .document(self.viewRouter.userID)
                        .collection("allUserDocuments")
                        .document("stripeCustomerProfile").addSnapshotListener{ (document, error) in
                            if let document = document, document.exists {
                                let resultingData : [String: Any] = document.data()!
                                let userInfo : [String: Any] = resultingData["resultingData"] as! [String : Any]


                                let halfCode = userInfo["id"] as! String
                                viewRouter.paymentAuthCode = "\(halfCode)}{\(viewRouter.userID)";

                                print("hgwcfjbegj DOC1 \(String(describing: resultingData))")
                                print("hgwcfjbegj DOC2 \(String(describing: viewRouter.paymentAuthCode))")

                            } else {
                                //Deal with error &/ document doesn't exist here
                                print("hgwcfjbegj DOC3 does not exist")
                            }
                        }

                    UIPasteboard.general.string = "\(viewRouter.paymentAuthCode)"
                    self.isPresentingToast = true

                }) {
                    HStack{

                        Image("copy")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45.0, height: 25.0)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))


                        Text("Tap here to copy Auth Code")
                            .font(.custom("Gill Sans Light", size: 20))
                            .fontWeight(.regular)
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
//                                    .frame(minWidth: 0, maxWidth: 350, minHeight: 0, maxHeight: 50, alignment: .leading)

                    }

                }
                .background(Color.black.opacity(0.07))
                .cornerRadius(1)
                .padding(EdgeInsets(top: 30, leading: 30, bottom: 20, trailing: 30))
                
            }
            
            Spacer().frame(height:10)
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
                ZStack{
                    

                        if viewRouter.RelocatorPayCurrentView == "Relocator Pay Setup" {
                            HStack{
                                WebView_Payments_Setup()
                            }
                            .ignoresSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-396)
                        }else{
                            HStack{
                                Successful_Setup()
                            }
                            .ignoresSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-278)
                        }
                        
                        //WebView_Shopping(state: $viewRouter.currentView)

                  

                   




                }

            }.padding()
            
            
            
            if viewRouter.RelocatorPayCurrentView == "Relocator Pay Setup" {
                
                
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
            
            Spacer()
            
            
        }.onAppear{
            
           
                
                viewRouter.userID = userID ?? "currentUser"
                
           
            
            db.collection("userData")
                .document(self.viewRouter.userID)
                .collection("allUserDocuments")
                .document("stripeCustomerProfile").getDocument{ (document, error) in
                    if let document = document, document.exists {
                        let resultingData : [String: Any] = document.data()!
                        let userInfo : [String: Any] = resultingData["resultingData"] as! [String : Any]


                        let halfCode = userInfo["id"] as! String
                        viewRouter.paymentAuthCode = "\(halfCode)}{\(viewRouter.userID)";


                    } else {
                        //Deal with error &/ document doesn't exist here
                    }
                }
            

            
          
            
            
            
            db.collection("userData")
                .document(self.viewRouter.userID)
                .collection("allUserDocuments")
                .document("PaymentsQuickRef").addSnapshotListener{ (document, error) in
                    if let document = document, document.exists {
                        let userInfo : [String: Any] = document.data()!

                        let statusCode = userInfo["status"] as! String
                        if statusCode == "success"{
                            viewRouter.RelocatorPayCurrentView = "Relocator Pay"

                        }else{
                            viewRouter.RelocatorPayCurrentView = "Relocator Pay Setup"

                        }

                    }
                }
            
            
            
        }.toast(isPresenting: $isPresentingToast, message: "Auth Code Copied", icon: .success, textColor: Color.green)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("About Relocator Pay"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
        }
    }
}

struct WebView_Payments_Setup: UIViewRepresentable {
    
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    func makeUIView(context: UIViewRepresentableContext<WebView_Payments_Setup>) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        //self.state = viewRouter.currentView
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    
    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView_Payments_Setup>) {
        
        view.scrollView.isScrollEnabled = false;
        view.scrollView.bounces = false;
        if let url = URL(string: "https://filabusi-moving.web.app/") {
            view.load(URLRequest(url: url))
        }
        
    }
    
    func makeCoordinator() -> WebView_Payments_Setup.Coordinator {
        Coordinator(view: self)
    }
    
    class Coordinator :  NSObject, WKNavigationDelegate  {
        
        
        
        let view: WebView_Payments_Setup
        
        init(view: WebView_Payments_Setup) {
            self.view = view
        }
        
        
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            
            
            if (navigationAction.request.url?.host) != nil {
                
                
                decisionHandler(.allow)
                return
                
                
                
            }
            
            decisionHandler(.allow)
            
            
            
        }
    }
    
    
    ///////////////
    
}

struct Successful_Setup: View{
    
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isPresentingToast = false
    @State var buttonText = ""
    @State var strokeColor: Color = Color(red: 0.45, green: 0.58, blue: 0.61)
    @State var user = Auth.auth().currentUser
    let ref = Database.database().reference()
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var body: some View{
        VStack(spacing:0){
            
            Image("correct")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 85.0, height: 85.0)
                
            
            Text("Card saved successfully.\nNo money was charged to your card.")
                .font(.custom("Courier New", size: 20))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
               
            
            Button(action: {

                if viewRouter.viewBeforePaymentIntent == "business"{
                    self.viewRouter.currentView = "StepThreeBusiness"
                }else{
                    self.viewRouter.currentView = "StepThree"
                }
                
                
            }) {
                
                
                Text("Back to Quote")
                    .font(.custom("Gill Sans Light", size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                  .background(Color.gray.opacity(0.15))
                  .padding(EdgeInsets(top: 20, leading: 30, bottom: 5, trailing: 30))
                
                
           
            }
        }
    }
    
}

struct PaymentsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsSetupView().environmentObject(ViewRouter())
    }
}

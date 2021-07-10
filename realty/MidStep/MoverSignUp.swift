//
//  moverSignUp.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-13.
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

struct MoverSignUp: View {
    
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
                        
                        Text("Mover Registration")
                            .foregroundColor(strokeColor)
                            .font(.title)
                            .fontWeight(.ultraLight)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        
                        Spacer()
                    }
                 
                    
            //Spacer().frame(height:20)
                 
               
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
                ZStack{
                    

                            HStack{
                                WebView_Mover_Registration()
                            }
                            .ignoresSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-260)
                        

                  

                   




                }

            }.padding()
            
            
            
        Spacer()
                
                
                Button(action: {
                    
                    self.viewRouter.currentView = "LandingPage"
                    
                }) {
                    
                    Text("Back to Home Page")
                        .font(.custom("Gill Sans Light", size: 20))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                      .background(Color.gray.opacity(0.15))
                      .padding(EdgeInsets(top: 20, leading: 30, bottom: 5, trailing: 30))
                      
                    
                }
                
                

                
         
            
            Spacer()
            
            
        }
    }
}

struct WebView_Mover_Registration: UIViewRepresentable {
    
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    func makeUIView(context: UIViewRepresentableContext<WebView_Mover_Registration>) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        //self.state = viewRouter.currentView
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    
    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView_Mover_Registration>) {
        
        view.scrollView.isScrollEnabled = true;
        view.scrollView.bounces = false;
        view.loadHTMLString( """
                            <!doctype html>
                            <html lang="en">
                            <head>
                            <meta charset="utf-8">
                            <meta name="viewport" content="width=device-width, initial-scale=0.80, shrink-to-fit=yes user-scalable=no">
                            </head>
                            <body>
                            <script type="text/javascript" src="https://form.jotform.com/jsform/211637172029250"></script>
                            </body></html>
                            """, baseURL: nil)
        
    }
    
    func makeCoordinator() -> WebView_Mover_Registration.Coordinator {
        Coordinator(view: self)
    }
    
    class Coordinator :  NSObject, WKNavigationDelegate  {
        
        
        
        let view: WebView_Mover_Registration
        
        init(view: WebView_Mover_Registration) {
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

struct MoverSignUp_Previews: PreviewProvider {
    static var previews: some View {
        MoverSignUp().environmentObject(ViewRouter())
    }
}

//
//  Login.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI
import AuthenticationServices

struct Login: View {
    
    //@StateObject var loginData = LoginViewModel()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        ZStack{
            
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
                .overlay(Color.black.opacity(0.35))
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                
                Spacer().frame(height: 100)
                
                Text("Relocator")
                    //.font(.system(size: 55))
                    .font(.custom("Avenir Next Ultra Light", size: 55))
                    //.fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                
                Text("The Realtor Swiss Army Knife")
                    .font(.custom("Avenir Next Regular", size: 18))
                    //.font(.footnote)
                    //.fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Spacer().frame(height: 80)
                
                Text("Relocator takes care of all staging, landscaping, renovation, cleaning and moving needed to sell a property.")
                    .font(.custom("Avenir Next Regular", size: 25))
                    //.fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.all,10)
                    
                
                Spacer()
                
                // Login Button....
                
                SignInWithAppleButton()
                .signInWithAppleButtonStyle(.white)
                .frame(height: 55)
                .clipShape(Capsule())
                .padding(.horizontal,40)
                .offset(y: -70)
                .onTapGesture{

                        viewRouter.startSignInWithAppleFlow()
                       
                       
                    }

            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(ViewRouter())
    }
}


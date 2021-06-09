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
                
                Spacer().frame(height: 150)
                
                Text("Relocator")
                    .font(.system(size: 55))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                
                Text("by Upscale.plus")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                Spacer().frame(height: 150)
                
                Text("Relocator takes care of all your moving needs. All you have to do is pack and we will do the rest.")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                
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


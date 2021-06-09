//
//  SignInWithAppleButton.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI
import AuthenticationServices
import Foundation

struct SignInWithAppleButton: UIViewRepresentable{
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton{
        return ASAuthorizationAppleIDButton(type:.signIn, style:.white)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
    
}

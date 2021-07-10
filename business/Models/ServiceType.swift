//
//  ServiceType.swift
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
import FirebaseDatabase

struct ServiceType: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var detail: String
    
}

var BusinessServiceTypes = [


    ServiceType(name: "Express Courier", detail: "One mover\nSedan trunk space\n5km delivery radius"),
    ServiceType(name: "Standard Courier", detail: "Two movers\n16 foot cube van\n25km delivery radius"),
    ServiceType(name: "Freight Courier", detail: "Three movers\n20 foot box truck\n50km delivery radius"),
 
]

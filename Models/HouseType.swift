//
//  HouseType.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI

// House Model....

struct HouseType: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var detail: String
    var inOrOut: String
}

// Model Data....

var MoveInHouseTypes = [

    
    HouseType(name: "Single-Family House", detail: "Detached and Semi-detached houses", inOrOut: "moveIn"),
    HouseType(name: "Town House", detail: "All types", inOrOut: "moveIn"),
    HouseType(name: "Apartment", detail: "Including Condos", inOrOut: "moveIn"),
    HouseType(name: "Basement", detail: "All types", inOrOut: "moveIn"),
    HouseType(name: "Storage Unit", detail: "Including Warehouses", inOrOut: "moveIn"),
    HouseType(name: "Business deliveries", detail: "Including FB/Kijiji Marketplace deliveries", inOrOut: "moveIn"),

]

var MoveOutHouseTypes = [

    HouseType(name: "Single-Family House", detail: "Detached and Semi-detached houses", inOrOut: "moveOut"),
    HouseType(name: "Town House", detail: "All types", inOrOut: "moveOut"),
    HouseType(name: "Apartment", detail: "Including Condos", inOrOut: "moveOut"),
    HouseType(name: "Basement", detail: "All types", inOrOut: "moveOut"),
    HouseType(name: "Storage Unit", detail: "Including Warehouses", inOrOut: "moveOut"),
    HouseType(name: "Customer", detail: "Your FB/Kijiji marketplace and business customers", inOrOut: "moveOut"),

]


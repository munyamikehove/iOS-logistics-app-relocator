//
//  ModelData.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-05-21.
//

import SwiftUI

struct ItemsModel: Codable, Identifiable {
    var id = UUID().uuidString
    var backgroundColor: String
    var image : String
    var title: String
    var description: String
    var mA2: Int
    var mA3: Int
    
}

var all_items = [
    
    //Living & Dining
    ItemsModel(backgroundColor: "bag1", image: "sofa", title: "Sofas & Couches", description: "Add each sofa and couch to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "carpet", title: "Carpets and rugs", description: "Add any carpets and rugs that are larger than a doormat.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag6", image: "hutch", title: "Book Shelves, Hutches & Display Cases", description: "Add each book shelf, display case and hutch to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag2", image: "chair", title: "Chairs & Stools", description: "Add each chair and stool to the counter below.\n\nThis includes arm chairs, lounge chairs, living room chairs, desk chairs, barber chairs, executive chairs, garden chairs, folding chairs, deck chairs, patio chairs and wheelchairs.",mA2: 2, mA3: 2),

   
    //Kitchen & Laundry
    ItemsModel(backgroundColor: "bag1", image: "stove", title: "Stoves", description: "Add each stove to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "fridge", title: "Refrigerators", description: "Add each refrigerator to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag6", image: "dishwasher", title: "Dish Washers", description: "Add each dish washer to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag2", image: "microwave", title: "Microwaves", description: "Add each microwave to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag3", image: "dryer", title: "Clothes Dryers", description: "Add each clothes dryers to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "washer", title: "Clothes Washers", description: "Add each clothes washers to the counter below.",mA2: 15, mA3: 10),
    
    //Bedroom
    ItemsModel(backgroundColor: "bag4", image: "king", title: "King Sized Beds", description: "Add each king sized bed to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag6", image: "queen", title: "Queen Sized Beds", description: "Add each queen sized bed to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag2", image: "double", title: "Double Sized Beds", description: "Add each double sized bed to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag3", image: "twin", title: "Twin Sized Beds", description: "Add each twin sized bed to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "crib", title: "Cribs & Change Tables", description: "Add each crib and change table to the counter below.",mA2: 10, mA3: 5),
    ItemsModel(backgroundColor: "bag1", image: "dresser", title: "Dressers & Drawers", description: "Add each dresser, nightstand, and drawer to the counter below.",mA2: 10, mA3: 5),
    
    
    
    //Bedroom & Office
    ItemsModel(backgroundColor: "bag1", image: "table", title: "TV Stands, Tables & Desks", description: "Add each table and desk to the counter below.\n\nThis includes TV stands, office desks, dining tables, end tables, coffee tables, patio tables, poker tables, and picnic table." ,mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "tv", title: "TVs & Computer Monitors", description: "Add each tv and computer monitor to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag2", image: "printer", title: "Desktops & Printers", description: "Add each printer to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag3", image: "box", title: "Boxes, Totes & Containers", description: "Add each box,tote and container to the counter below.If you have not yet packed, enter an estimate and we will adjust the number when we come to deliver the moving boxes.",mA2: 3, mA3: 3),
    ItemsModel(backgroundColor: "bag1", image: "suitcase", title: "Suitcases", description: "Add each suitcase to the counter below. If you have not yet packed, enter an estimate and we will adjust the number when we come to deliver the moving boxes.",mA2: 3, mA3: 3),
    
    
    //Garage & Outside
    ItemsModel(backgroundColor: "bag1", image: "bbq", title: "BBQ Grills", description: "Add each BBQ grill to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag4", image: "mower", title: "Lawn mowers & Wheelbarrows", description: "Add each lawn mower and wheelbarrow to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag6", image: "bike", title: "Bicycles", description: "Add each bicycle to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag2", image: "stroller", title: "Strollers", description: "Add each strollers to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag3", image: "blower", title: "Snow blowers", description: "Add each snow blower to the counter below.",mA2: 2, mA3: 2),
    
    //Basement & Garage
    ItemsModel(backgroundColor: "bag1", image: "ttennis", title: "Table Tennis", description: "Add each table-tennis table to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "tread", title: "Treadmills", description: "Add each treadmill to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag6", image: "ellipt", title: "Ellipticals", description: "Add each elliptical to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag2", image: "weights", title: "Workout Weights & Bench", description: "Add each workout bench and each weight/weight-plate to the counter below. For example, a 20LBS dumbbell and a 50LBS weight-plate count as two items.",mA2: 10, mA3: 5),
    ItemsModel(backgroundColor: "bag3", image: "rowing", title: "Rowing Machines", description: "Add each rowing machine to the counter below.",mA2: 10, mA3: 5),
    ItemsModel(backgroundColor: "bag4", image: "other", title: "Other Items", description: "Add items like workout equipment, large items and any furniture to the counter below.\n\nDo not add boxes of clothing and kitchenware, or vacuum cleaners to the counter below.",mA2: 10, mA3: 5)
    
    

]

var living_dining = [

   
    //Living & Dining
    ItemsModel(backgroundColor: "bag1", image: "sofa", title: "Sofas & Couches", description: "Add each sofa and couch to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "carpet", title: "Carpets and rugs", description: "Add any carpets and rugs that are larger than a doormat.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag6", image: "hutch", title: "Book Shelves, Hutches & Display Cases", description: "Add each book shelf, display case and hutch to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag2", image: "chair", title: "Chairs & Stools", description: "Add each chair and stool to the counter below.\n\nThis includes arm chairs, lounge chairs, living room chairs, desk chairs, barber chairs, executive chairs, garden chairs, folding chairs, deck chairs, patio chairs and wheelchairs.",mA2: 3, mA3: 3),
    ItemsModel(backgroundColor: "bag1", image: "table", title: "TV Stands, Tables & Desks", description: "Add each table and desk to the counter below.\n\nThis includes TV stands, office desks, dining tables, end tables, coffee tables, patio tables, poker tables, and picnic table.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "tv", title: "TVs & Computer Monitors", description: "Add each tv and computer monitor to the counter below.",mA2: 5, mA3: 5),

]

var kitchen_laundry = [

   
    //Kitchen & Laundry
    ItemsModel(backgroundColor: "bag1", image: "stove", title: "Stoves", description: "Add each stove to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "fridge", title: "Refrigerators", description: "Add each refrigerator to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag6", image: "dishwasher", title: "Dish Washers", description: "Add each dish washer to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag2", image: "microwave", title: "Microwaves", description: "Add each microwave to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag3", image: "dryer", title: "Clothes Dryers", description: "Add each clothes dryers to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "washer", title: "Clothes Washers", description: "Add each clothes washers to the counter below.",mA2: 15, mA3: 10),

]

var bedroom = [

   
    //Bedroom
    ItemsModel(backgroundColor: "bag4", image: "king", title: "King Sized Beds", description: "Add each king sized bed to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag6", image: "queen", title: "Queen Sized Beds", description: "Add each queen sized bed to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag2", image: "double", title: "Double Sized Beds", description: "Add each double sized bed to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag3", image: "twin", title: "Twin Sized Beds", description: "Add each twin sized bed to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag4", image: "crib", title: "Cribs & Change Tables", description: "Add each crib and change table to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag1", image: "dresser", title: "Dressers & Drawers", description: "Add each dresser, nightstand, and drawer to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag2", image: "chair", title: "Chairs & Stools", description: "Add each chair and stool to the counter below.\n\nThis includes arm chairs, lounge chairs, living room chairs, desk chairs, barber chairs, executive chairs, garden chairs, folding chairs, deck chairs, patio chairs and wheelchairs.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag4", image: "other", title: "Other Items", description: "Add items like workout equipment, large items and any furniture to the counter below.\n\nDo not add boxes of clothing and kitchenware, or vacuum cleaners to the counter below.",mA2: 10, mA3: 5)
   

]

var office_bedroom   = [

    //Office & Bedroom
    ItemsModel(backgroundColor: "bag1", image: "table", title: "TV Stands, Tables & Desks", description: "Add each table and desk to the counter below.\n\nThis includes TV stands, office desks, dining tables, end tables, coffee tables, patio tables, poker tables, and picnic table.",mA2: 10, mA3: 5),
    ItemsModel(backgroundColor: "bag4", image: "tv", title: "TVs & Computer Monitors", description: "Add each tv and computer monitor to the counter below.",mA2: 3, mA3: 3),
    ItemsModel(backgroundColor: "bag2", image: "printer", title: "Desktops & Printers", description: "Add each printer to the counter below.",mA2: 3, mA3: 3),
    ItemsModel(backgroundColor: "bag3", image: "box", title: "Boxes, Totes & Containers", description: "Add each box,tote and container to the counter below. If you have not yet packed, enter an estimate and we will adjust the number when we come to deliver the moving boxes.",mA2: 3, mA3: 3),
    ItemsModel(backgroundColor: "bag1", image: "suitcase", title: "Suitcases", description: "Add each suitcase to the counter below. If you have not yet packed, enter an estimate and we will adjust the number when we come to deliver the moving boxes.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag4", image: "other", title: "Other Items", description: "Add items like workout equipment, large items and any furniture to the counter below.\n\nDo not add boxes of clothing and kitchenware, or vacuum cleaners to the counter below.",mA2: 10, mA3: 5)
     

]

var garage_outside = [

    //Garage & Outside
    ItemsModel(backgroundColor: "bag1", image: "bbq", title: "BBQ Grills", description: "Add each BBQ grill to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag4", image: "mower", title: "Lawn mowers & Wheelbarrows", description: "Add each lawn mower and wheelbarrow to the counter below.",mA2: 5, mA3: 5),
    ItemsModel(backgroundColor: "bag6", image: "bike", title: "Bicycles", description: "Add each bicycle to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag2", image: "stroller", title: "Strollers", description: "Add each strollers to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag3", image: "blower", title: "Snow blowers", description: "Add each snow blower to the counter below.",mA2: 2, mA3: 2),
    ItemsModel(backgroundColor: "bag4", image: "other", title: "Other Items", description: "Add items like workout equipment, large items and any furniture to the counter below.\n\nDo not add boxes of clothing and kitchenware, or vacuum cleaners to the counter below.",mA2: 10, mA3: 5)

]

var basement_garage = [

    //Basement & Garage
    ItemsModel(backgroundColor: "bag1", image: "ttennis", title: "Table Tennis", description: "Add each table-tennis table to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag4", image: "tread", title: "Treadmills", description: "Add each treadmill to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag6", image: "ellipt", title: "Ellipticals", description: "Add each elliptical to the counter below.",mA2: 20, mA3: 15),
    ItemsModel(backgroundColor: "bag2", image: "weights", title: "Workout Weights & Bench", description: "Add each workout bench and each weight/weight-plate to the counter below. For example, a 20LBS dumbbell and a 50LBS weight-plate count as two items.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag3", image: "rowing", title: "Rowing Machines", description: "Add each rowing machine to the counter below.",mA2: 15, mA3: 10),
    ItemsModel(backgroundColor: "bag4", image: "other", title: "Other Items", description: "Add items like workout equipment, large items and any furniture to the counter below.\n\nDo not add boxes of clothing and kitchenware, or vacuum cleaners to the counter below.",mA2: 10, mA3: 5)
    
]



// For Top Scrolling Tab Buttons....

var scroll_Tabs = ["All Items","Living & Dining","Kitchen & Laundry","Bedroom","Office & Bedroom","Garage & Outside","Basement & Garage"]



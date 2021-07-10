//
//  AddressView.swift
//  Upscale
//
//  Created by Munyaradzi Hove on 2021-05-16.
//

import Foundation
import UIKit
import SwiftUI
import GooglePlaces
import Combine
import GoogleMaps
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase
import FirebaseFunctions




struct PlacePicker: UIViewControllerRepresentable {

   
    @Environment(\.presentationMode) var presentationMode
    @Binding var addressFromInput: String
    @Binding var placeID: String
    @Binding var addressLat: Double
    @Binding var addressLng: Double
    @EnvironmentObject var viewRouter: ViewRouter
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewRouter: viewRouter)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator


        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
          UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "CA"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

        var parent: PlacePicker
        @State var viewRouter: ViewRouter

        init(_ parent: PlacePicker, viewRouter: ViewRouter) {
            self.parent = parent
            self.viewRouter = viewRouter
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                print("wjvuhviwjk \(place.description.description as Any)")
                self.parent.addressFromInput =  place.name!
                //self.geoLocate(address: place.name!)
                self.parent.placeID = place.placeID ?? "none"
                
                
                
                print("kljbvkerhv \(place.coordinate.latitude) and \(place.coordinate.longitude)")
                self.parent.presentationMode.wrappedValue.dismiss()
            }
            
        }
        
        func geoLocate(address:String!){
                let gc:CLGeocoder = CLGeocoder()
                gc.geocodeAddressString(address) { (placemarks, error) in
                    if ((placemarks?.count)! > 0){
                        let p = placemarks![0]
                        
                        self.parent.addressLat = p.location?.coordinate.latitude ?? 0.0
                        self.parent.addressLng = p.location?.coordinate.longitude ?? 0.0
                        print("Lat: \(String(describing: p.location?.coordinate.latitude)) Lon: \(String(describing: p.location?.coordinate.longitude))")
                    }

            }
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
             //viewRouter.placePickerButton = "none"
            self.parent.addressFromInput =  ""
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
           //viewRouter.placePickerButton = "none"
            self.parent.addressFromInput =  ""
            parent.presentationMode.wrappedValue.dismiss()
        }
        


    }
}


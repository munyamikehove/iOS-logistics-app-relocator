//
//  ServiceTypeRowView.swift
//  Filabusi
//
//  Created by Munyaradzi Hove on 2021-06-14.
//

import SwiftUI

struct ServiceTypeRowView: View {
    
    @State var serviceType: ServiceType
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
     
        HStack(spacing:15){
            

            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(serviceType.name)
                    .fontWeight(.bold)
                
                Text(serviceType.detail)
                    .font(.caption)
                    .foregroundColor(.gray)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
          
            
            
                
                            switch serviceType.name  {
                            case "Express Courier":
                                if viewRouter.ServiceSelectorCounter == 1 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.minimumOrderAmount = 50.00
                                        viewRouter.ServiceSelectorCounter = 1
                                        viewRouter.serviceTypeMovers = "1 Mover to pick up and drop-off delivery"
                                        viewRouter.serviceTypeVehicle = "Sedan - back seat and trunk"
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                               
                
                            case "Standard Courier":
                                if viewRouter.ServiceSelectorCounter == 2 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.minimumOrderAmount = 200.00
                                        viewRouter.ServiceSelectorCounter = 2
                                        viewRouter.serviceTypeMovers = "2 Movers to load and offload van"
                                        viewRouter.serviceTypeVehicle = "16' Cube Van"
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                
                            case "Freight Courier":
                                if viewRouter.ServiceSelectorCounter == 3 {
                                    Button(action: {}, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.green)
                                            .padding()
                                            .background(Color.green)
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }else{
                                    Button(action: {
                                        viewRouter.minimumOrderAmount = 300.00
                                        viewRouter.ServiceSelectorCounter = 3
                                        viewRouter.serviceTypeMovers = "20' Box Truck"
                                        viewRouter.serviceTypeVehicle = "3 Movers to load and offload truck"
                                    }, label: {
                                        Image("")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.black)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .clipShape(Circle())
                                            .frame(width: 25.0, height: 25.0)
                                    })
                                }
                                
                           
                            default:
                                Button(action: {}, label: {
                                    Image("")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color.black)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                        .frame(width: 25.0, height: 25.0)
                                })
                                
                            }
                
            }
        .padding(.horizontal)
            
            //viewRouter.OriginSelectorCounter
            

            
            // Buttons...
           
            

        }
    
    }




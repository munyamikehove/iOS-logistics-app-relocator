//
//  DetailView.swift
//  Upscale
//
//  Created by Munyaradzi Hove on 2021-05-02.
//

import SwiftUI
import AlertToast

struct DetailView: View {
    
    @Binding var itemData : ItemsModel!
    @Binding var show: Bool
    var animation: Namespace.ID
    // Initialization....
    @State var selectedColor = Color.red
    
    @State var count = 0
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showToast = false
    @State var alertMessage = ""
    @State var isSmallDevice = UIScreen.main.bounds.height < 750
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                VStack(alignment: .leading,spacing: 5){
                    
                    Button(action: {
                        
                        withAnimation(.easeOut){show.toggle()}
                        
                    }) {
                        
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Text("How many")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    Text(itemData.title)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("do you want moved to your new place?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        //.padding(.top)
                }
                
                Spacer(minLength: 0)
                
//                Button(action: {}) {
//
//                    Image(systemName: "cart")
//                        .font(.title)
//                        .foregroundColor(.white)
//                }
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            HStack(spacing: 10){
                
//                VStack(alignment: .leading, spacing: 6) {
//
//                    Text("Price")
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//
//                    Text(bagData.price)
//                        .font(.largeTitle)
//                        .fontWeight(.heavy)
//                        .foregroundColor(.white)
//                }
                
                Image(itemData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                // Hero Animation...
                    .matchedGeometryEffect(id: itemData.image, in: animation)
            }
            .padding()
            .padding(.top,10)
            .zIndex(1)

            VStack{
                
                ScrollView(isSmallDevice ? .vertical : .init(), showsIndicators: false) {
                    
//                    HStack{
//
//                        VStack(alignment: .leading, spacing: 8) {
//
//                            Text("Color")
//                                .fontWeight(.bold)
//                                .foregroundColor(.gray)
//
//                            HStack(spacing: 15){
//
//                                ColorButton(color: Color(bagData.image), selectedColor: $selectedColor)
//
//                                ColorButton(color: Color.yellow, selectedColor: $selectedColor)
//
//                                ColorButton(color: Color.green, selectedColor: $selectedColor)
//                            }
//                        }
//
//                        Spacer(minLength: 0)
//
//                        VStack(alignment: .leading, spacing: 8) {
//
//                            Text("Size")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.black)
//
//                            Text("12 cm")
//                                .fontWeight(.heavy)
//                                .foregroundColor(.black)
//                        }
//                    }
//                    .padding(.horizontal)
                    
                    Text("\(itemData.description)")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    HStack(spacing: 20){
                        
                        Button(action: {
                            if count > 0{count -= 1}
                        }) {
                            
                            Image(systemName: "minus")
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1))
                        }
                        
                       
                            Text("\(count)")
                                .font(.title2)
                                .foregroundColor(.black)
                        
                        
                        Button(action: {count += 1}) {
                            
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 35, height: 35)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 1))
                        }
                        
                        Spacer()
                        
                        if count >= 1{
                            Button(action: {
                                for item in viewRouter.TruckDataPrimary {
                                    
                                    if item.itemName == itemData.title {
                                        //count = item.itemCount
                                        viewRouter.TruckDataPrimary.removeAll(where: { $0.itemName == itemData.title })
                                    }
                                   
                                }
                                count = 0
                                alertMessage = "Removed from truck"
                                showToast = true
                            }) {

                                Image(systemName: "xmark.bin.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                                    .padding(10)
                                    //.background(Color.green)
                                    .clipShape(Circle())
                            }
                        }
                       
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 0)
                    
                    
                    Button(action: {
                        
                        if count == 0{
                            
                            //viewRouter.truckItemList[itemData.title] = nil
                           
                            for item in viewRouter.TruckDataPrimary {
                                
                                if item.itemName == itemData.title {
                                    //count = item.itemCount
                                    viewRouter.TruckDataPrimary.removeAll(where: { $0.itemName == itemData.title })
                                }
                               
                            }
                            count = 0
                            alertMessage = "Removed from truck"
                            showToast = true
                        }else{
                            for item in viewRouter.TruckDataPrimary {
                                
                                if item.itemName == itemData.title {
                                    //count = item.itemCount
                                    viewRouter.TruckDataPrimary.removeAll(where: { $0.itemName == itemData.title })
                                }
                               
                            }
                            
                            //viewRouter.truckItemList[itemData.title] = count
                            viewRouter.TruckDataPrimary.append(TruckPrimary(itemName: itemData.title, itemCount: count))
                            alertMessage = "Added to truck"
                            showToast = true
                        }
                        
                       
                       
                    }) {
                        
                        Text("ADD TO TRUCK")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("bag1"))
                            .clipShape(Capsule())
                    }
                    .padding(.top)
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : 0)
                }
                .padding(.top,isSmallDevice ? 0 : -20)
            }
            .background(
                Color.white
                    .clipShape(CustomCorner())
                    .padding(.top,isSmallDevice ? -60 : -100)
            )
            .zIndex(0)
        }
        .background(Color(itemData.backgroundColor).ignoresSafeArea(.all, edges: .top))
        .background(Color.white.ignoresSafeArea(.all, edges: .bottom))
        .onAppear {
            
            for item in viewRouter.TruckDataPrimary {
                
                if item.itemName == itemData.title {
                    count = item.itemCount
                    //viewRouter.truckItemList[itemData.title]!
                }
               
            }
            
            
            
//            if viewRouter.truckItemList.contains(where: { $0.itemName == itemData.title }) {
//                 // found
//
//                count = viewRouter.truckItemList
//            } else {
//                 // not
//            }
            
//            if viewRouter.truckItemList[itemData.title] != nil {
//                count = viewRouter.truckItemList[itemData.title]!
//            }
            
            
            // First Color Is Image Or Bag Color...
            //selectedColor = Color(itemData.image)
            
            //Color for all, no variance...
            selectedColor = Color(itemData.backgroundColor)
        }
        .toast(isPresenting: $showToast){

                   // `.alert` is the default displayMode
                   AlertToast(displayMode: .hud, type: .regular, title: "\(alertMessage)")
                   
                   //Choose .hud to toast alert from the top of the screen
                   //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
               }
    }
}


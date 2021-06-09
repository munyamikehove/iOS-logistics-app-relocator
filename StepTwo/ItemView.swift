//
//  ItemView.swift
//  Upscale
//
//  Created by Munyaradzi Hove on 2021-05-02.
//

import SwiftUI

struct ItemView: View {
    
    var itemData : ItemsModel
    var animation : Namespace.ID
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            ZStack{
                
                // both image and color name are same....
                Color(itemData.backgroundColor)
                    .cornerRadius(15)
                
                Image(itemData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .matchedGeometryEffect(id: itemData.image, in: animation)
            }
            
            Text(itemData.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .padding(.bottom,10)
            
            
//            Text(bagData.price)
//                .fontWeight(.heavy)
//                .foregroundColor(.black)
        }
    }
}


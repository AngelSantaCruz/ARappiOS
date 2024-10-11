//
//  IMAGEChange.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 6/10/24.
//

import SwiftUI
import SwiftData
struct IMAGEChange: View {
   
    
    @Query var imageData: [ImageAnalisis]

    var body: some View {
            HStack{
                Spacer()
                VStack{
                    if !imageData.isEmpty{
                        ForEach(imageData, id:\.self){ data in
                            Image(uiImage: UIImage(data:data.image)!).resizable().scaledToFit()
                        }
                        
                    }
                    
                    
            
                    
                }.frame(width: 100, height: 150).cornerRadius(15).background(.black.opacity(0.5)).padding(20)
                
            }
        
    }
}


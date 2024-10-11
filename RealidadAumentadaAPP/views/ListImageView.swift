//
//  ListImageView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 3/10/24.
//

import SwiftUI
import SwiftData
import UIKit

struct ListImageView: View {
    
    
    @Query var imageData: [ImageData]
    let gridItem = [GridItem(.fixed(100)),GridItem(.fixed(100)), GridItem(.fixed(100))]
    @State private var isShowingSheet = false
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: gridItem,alignment: .leading, spacing: 20){
                
                ForEach(imageData, id: \.self){ image in
                    
                    
                    Button(action:{
                        self.isShowingSheet = true
                    }){
                        let imagen = UIImage(data: image.image!)
                        Image(uiImage: imagen!).resizable()
                            .scaledToFit()
                        
                    }.frame(width: 80, height: 80).padding(10).background(.black.opacity(0.5)).cornerRadius(10).sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
                        VStack{
                            HStack{
                                Spacer()
                                Button(action:{
                                    self.isShowingSheet = false
                                }){
                                    Text("Cerrar").font(.headline)
                                    Image(systemName: "x.square.fill").font(.headline)
                                }.bold().foregroundStyle(.black.opacity(0.7))
                            }
                            let imagen = UIImage(data: image.image!)
                            Image(uiImage: imagen!).resizable()
                                .scaledToFit().background(.black.opacity(0.5))
                        }.padding(20)
                    }
                    
                    
                    
                }
                
                
            }
            
        }.padding(20)
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

#Preview {
    ListImageView()
}

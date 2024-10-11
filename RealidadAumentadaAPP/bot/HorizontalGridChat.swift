//
//  HorizontalGridChat.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 30/09/24.
//

import SwiftUI
import UIKit

struct HorizontalGridChat:View {

    @Binding var buttonOpenChat:Bool
    @EnvironmentObject var placementSettings: PlacementSettings
    var tittle:String
    var messageRes:String
    var items:[Model]
    
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading){
            
            if messageRes != "" {
                Text(messageRes)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 10)
                
            }
            Text(tittle).font(.title2).bold().padding(.leading,22)
                            .padding(.top,10)
            
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows:gridItemLayout, spacing:20){
                    
                  
                    ForEach(0...items.count-1,id: \.self){ item in
                            ButtonModelsItems(model: items[item]) {
                            items[item].LoadModelEntity()
                            self.placementSettings.selectedModel = items[item]
                            print("item presionado")
                            self.buttonOpenChat.toggle()
                        }
                    }
                }.padding(.horizontal,22).padding(.vertical,12)


            }
            
            
        }
    }
}

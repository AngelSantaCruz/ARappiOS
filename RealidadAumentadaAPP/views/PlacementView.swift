//
//  placementView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 29/09/24.
//

import SwiftUI

struct PlacementView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                PlacementButton(systemIcon: "x.circle.fill") {
                    self.placementSettings.selectedModel = nil
                }
                Spacer()
                PlacementButton(systemIcon: "checkmark.circle.fill") {
                    self.placementSettings.confirmedModel =  self.placementSettings.selectedModel
                    self.placementSettings.selectedModel = nil
                }
                Spacer()
            }
        }
        
        
    }
}

struct  PlacementButton:View {
    let systemIcon:String
    let action:()->Void
    
    var body : some View{
        Button(action:{
            self.action()
        }){
            Image(systemName: systemIcon).font(.system(size: 50,weight: .light,design: .default)).foregroundStyle(.white).buttonStyle(.plain)
        }.frame(width: 75, height: 75)
    }
}

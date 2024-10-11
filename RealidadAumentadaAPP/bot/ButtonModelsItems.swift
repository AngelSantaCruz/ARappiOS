//
//  ButtonModelsItems.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 30/09/24.
//

import SwiftUI
import UIKit



struct ButtonModelsItems:View{
    
    let model: Model
    let action: ()->Void
    
    var body: some View{
        Button(action: {
            self.action()
        }){
            Image(uiImage:self.model.img).resizable().frame(width: 100, height: 100).aspectRatio(1/1,contentMode: .fit).background( Color(UIColor.secondarySystemFill)).cornerRadius(10)
        }
    }
}


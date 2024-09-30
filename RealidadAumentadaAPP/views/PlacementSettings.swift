//
//  PlacementSettings.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 29/09/24.
//

import SwiftUI
import RealityKit
import Combine


class PlacementSettings:ObservableObject{

//cuando se selecciona el modelo
    @Published var selectedModel : Model?{
        willSet(newValue){
            
            print("setting select model \(String(describing:newValue?.name)) ")
            
        }
    }

//cuando se confirmael modelo 
    @Published var confirmedModel:Model?{
        willSet(newValue){
            guard let model = newValue else {
                print("limpio ")
                return
            }
            print("modelo confirmado \(model)")
        }
    }
    
    var sceneObserver: Cancellable?
    
}



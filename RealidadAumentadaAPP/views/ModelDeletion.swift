//
//  ModelDeletion.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 2/12/24.
//

import SwiftUI
import RealityKit

class ModelDeletion:ObservableObject{
    @Published var entitySelectedForDeletion:ModelEntity? = nil {
        willSet(newValue){
                if self.entitySelectedForDeletion == nil, let newSelectedModelEntity=newValue{
                print("selecting new entity for deletion")
                
                let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)

                newSelectedModelEntity.modelDebugOptions = component
                
                }else if let previuslySelectedModel = self.entitySelectedForDeletion, let
                        newSelectedModelEntity = newValue{
                print("selecting new entity for deletion")
                    previuslySelectedModel.modelDebugOptions = nil
                    
                    let component = ModelDebugOptionsComponent(visualizationMode: .lightingDiffuse)
                    newSelectedModelEntity.modelDebugOptions = component
                    
                }else if  newValue == nil{
                    print("Clearing")
                    self.entitySelectedForDeletion?.modelDebugOptions = nil
                }
            }
    }
    
    
}

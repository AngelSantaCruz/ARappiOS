//
//  DeletionView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 2/12/24.
//

import SwiftUI


struct DeletionView:View{
    
    @EnvironmentObject var sceneManager: SceneManager
    
    @EnvironmentObject var modelDeletionManager :ModelDeletion
    var body: some View {
        HStack{
            DeletionButton(systemIcon: "xmark.circle.fill") {
                print("cancel deletion")
                self.modelDeletionManager.entitySelectedForDeletion = nil
            }
            
            DeletionButton(systemIcon: "trash.circle.fill") {
                print("confirm deletion")
                guard let anchor = self.modelDeletionManager.entitySelectedForDeletion?.anchor else {return}
                
                let anchorIndetifier = anchor.anchorIdentifier
                
                if let index = self.sceneManager.anchorEntities.firstIndex(where: {$0.anchorIdentifier == anchorIndetifier}){
                    print("deleting")
                    self .sceneManager.anchorEntities.remove(at: index)
                
                }
                anchor.removeFromParent()
                self.modelDeletionManager.entitySelectedForDeletion = nil
                
            }
        }
    }
}

struct  DeletionButton:View {
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

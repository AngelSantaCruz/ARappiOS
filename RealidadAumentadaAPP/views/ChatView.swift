//
//  ChatView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//


import SwiftUI
import RealityKit
import ARKit

struct ChatView : View {
    @State private var buttonOpenChat:Bool=false
    @State private var buttonOpenBrowse:Bool=false
    @State private var buttonIsVisible:Bool=true
    @State var modelName : String = "silla#2"
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @EnvironmentObject var modelDeletionManager : ModelDeletion
    

    @State private var modelPosition: SIMD3<Float> = .zero
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer(modelName: $modelName, modelPosition:$modelPosition)
                .ignoresSafeArea(edges: .all)
                .gesture(DragGesture().onChanged{ value in
                    print(value)
                })
            if self.modelDeletionManager.entitySelectedForDeletion != nil{
                DeletionView()
            }else if self.placementSettings.selectedModel==nil{
                ControlView(buttonOpenChat:$buttonOpenChat,buttonIsVisible:$buttonIsVisible,buttonOpenBrowse:$buttonOpenBrowse,modelName:$modelName)
                
            }else{
                
                PlacementView()
            }
            
            
        }
        
        
    }
    
}

struct ARViewContainer : UIViewRepresentable {
    @Binding var modelName: String
    @Binding var modelPosition:  SIMD3<Float>
    
    @EnvironmentObject var sceneManager: SceneManager

    @EnvironmentObject var placementSettings:PlacementSettings
    @EnvironmentObject var modelDeletion: ModelDeletion
    
    func makeUIView(context: Context) -> CustomARView {
        
        ARVariables.arView = CustomARView(frame: .zero, modelDeletion: modelDeletion )
        self.placementSettings.sceneObserver = ARVariables.arView.scene.subscribe(to: SceneEvents.Update.self, { (event) in
            
            self.updateScene(for: ARVariables.arView)
            self.updatePersistenceAvailability(for: ARVariables.arView)
            
        })
    
        return ARVariables.arView
    }
    
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
       
    }
    
    private func updateScene(for arView: CustomARView){
        ARVariables.arView.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        if let confimedModel = self.placementSettings.confirmedModel, let modelEntity = confimedModel.model{
            
            self.place(modelEntity, in:  ARVariables.arView )
            self.placementSettings.confirmedModel = nil
        }
        
    }
    
    private func place(_ modelEntity: ModelEntity, in arView: ARView){
        let cloneEntity = modelEntity.clone(recursive: true)
        
        cloneEntity.generateCollisionShapes(recursive: true)
        
        ARVariables.arView.installGestures([.translation,.rotation], for: cloneEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(cloneEntity)
        
        ARVariables.arView.scene.addAnchor(anchorEntity)
        
        self.sceneManager.anchorEntities.append(anchorEntity)
        
        print("modelo subido")
        
    }
}

class SceneManager: ObservableObject{
    @Published var isPersistenceAvailable:Bool = false
    @Published var anchorEntities :[AnchorEntity] = []
    
}

extension ARViewContainer{
    private func updatePersistenceAvailability(for arView: ARView){
        guard let currentFrame = ARVariables.arView.session.currentFrame else {
            print("no disponible")
            return
        }
        
        switch currentFrame.worldMappingStatus{
        case .mapped, .extending:
            self.sceneManager.isPersistenceAvailable = !self.sceneManager.anchorEntities.isEmpty
        default:
            self.sceneManager.isPersistenceAvailable = false
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ChatView().environmentObject(PlacementSettings())
    }
}
#endif



#Preview {
    ChatView()
}

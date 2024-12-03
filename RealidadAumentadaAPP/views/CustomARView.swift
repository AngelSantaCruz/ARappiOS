//
//  CustomARView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 29/09/24.
//

import FocusEntity
import RealityKit
import ARKit

class CustomARView: ARView{
    var focusEntity:FocusEntity?
    var modelDeletionMnanager: ModelDeletion
    required init(frame frameRect:CGRect, modelDeletion:ModelDeletion){
        
        self.modelDeletionMnanager = modelDeletion
        super.init(frame:frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
        configure()
        
        self.enableObjectDeletion()
        
    }
    @objc required dynamic init?(coder decoder: NSCoder){
        fatalError("ini(coder:) no puede ser implementado")
    }
    
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    
    private func configure(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection=[.horizontal,.vertical]
        session.run(config)
        
    }
}


extension CustomARView{
    func enableObjectDeletion(){
        let longPressGeture = UILongPressGestureRecognizer(target: self, action: #selector( handleLongPress(recognizer:)))
        self.addGestureRecognizer(longPressGeture)
    }
    
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        if let entity = self.entity(at: location) as? ModelEntity {
            modelDeletionMnanager.entitySelectedForDeletion = entity
        }
    }
}


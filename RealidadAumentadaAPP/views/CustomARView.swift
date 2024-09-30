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
    
    required init(frame frameRect:CGRect){
        super.init(frame:frameRect)
        
        focusEntity = FocusEntity(on: self, focus: .classic)
        
    }
    @objc required dynamic init?(coder decoder: NSCoder){
        fatalError("ini(coder:) no puede ser implementado")
    }
    
    private func configure(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection=[.horizontal,.vertical]
        session.run(config)
        
    }
}



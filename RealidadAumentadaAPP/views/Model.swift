//
//  Model.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 29/09/24.
//

import SwiftUI
import RealityKit
import Combine


enum ModelCategory: CaseIterable{
    case mesa
    case silla
    case sofa
    
    var Label: String{
        get{
            switch self{
            case .mesa:
                return "Mesas"
            case .silla:
                return "Sillas"
            case .sofa:
                return "Sofas"
            }
        }
        
    }
    
}

class Model {
    var name:String
    var category:ModelCategory
    var img:UIImage
    var model: ModelEntity?
    var scale: Float
    
    private var cancelable:AnyCancellable?

    init(name:String,category:ModelCategory,scale: Float=1.0){
        
        self.name=name
        self.category=category
        self.img = UIImage(named: name) ?? UIImage(named: "Silla#2")!
        self.scale = scale
    }
    func LoadModelEntity(){
        let filename = self.name
        guard let modelEntity = try? Entity.loadModel(named: filename) else { return }
        self.model=modelEntity
        
       

    }
}


struct Models {
    var all: [Model] = []
    
    init(){
        //sillas
        let silla1 = Model(name: "Silla#1", category: .silla, scale: 1.0)
        let silla2 = Model(name: "Silla#2", category: .silla, scale: 1.0)
        let silla3 = Model(name: "Silla#3", category: .silla, scale: 1.0)
        let silla4 = Model(name: "Silla#4", category: .silla, scale: 1.0)
        let silla5 = Model(name: "Silla#5", category: .silla, scale: 1.0)
        
        self.all += [silla1,silla2,silla3,silla4,silla5]
        
        //mesas
        let mesa1 = Model(name: "Mesa#1", category: .mesa, scale: 0.7)
        let mesa2 = Model(name: "Mesa#2", category: .mesa, scale: 0.7)
        
        self.all += [mesa1,mesa2]
        
        //sofas
        let sofa1 = Model(name: "Sofa#1", category: .sofa, scale: 0.5)
        let sofa2 = Model(name: "Sofa#2", category: .sofa, scale: 0.45)
        
        self.all += [sofa1, sofa2]

    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter({ $0.category == category })
        
    }
}

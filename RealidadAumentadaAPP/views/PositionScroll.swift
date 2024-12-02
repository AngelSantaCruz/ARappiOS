//
//  PositionScroll.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 30/11/24.
//
import SwiftUI
import RealityKit
import Combine


class PositionScroll:ObservableObject{

    @Published var position = ScrollPosition(edge: .bottom)
    
}




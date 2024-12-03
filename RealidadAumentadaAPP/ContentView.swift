//
//  ContentView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//

import SwiftUI
import RealityKit
import SwiftData
import UIKit

struct ContentView : View {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var modelDeletionManager = ModelDeletion()
    @StateObject var sceneManager = SceneManager()
    var body: some View {
        HomeView().modelContainer(for: [ChatModel.self, ImageData.self, ImageAnalisis.self])
            .environmentObject(placementSettings)
            .environmentObject(modelDeletionManager)
            .environmentObject(sceneManager)
        
    }
}



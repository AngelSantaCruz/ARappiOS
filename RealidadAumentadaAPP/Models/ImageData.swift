//
//  ImageData.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 3/10/24.
//
import SwiftData
import Foundation


@Model
class ImageData{
    @Attribute(.unique) var id: UUID
    var image: Data?
    var date:Date
    
    init(image:Data?) {
        self.id = UUID()
        self.image = image
        self.date = Date()
    }
}


@Model
class ImageAnalisis{
    @Attribute(.unique) var id: UUID
    var image: Data
    var title: String
    
    init(image:Data) {
        self.id = UUID()
        self.image = image
        self.title = "analisis"
    }
}


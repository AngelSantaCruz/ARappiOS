//
//  chatModel.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 1/10/24.
//

import SwiftData
import Foundation


@Model
class ChatModel{
    @Attribute(.unique) var id: UUID
    var historialChat: [String]
    var usuario: String
    
    init(id: UUID, historialChat: [String], usuario:String) {
        self.id = id
        self.historialChat = historialChat
        self.usuario = usuario
    }
}

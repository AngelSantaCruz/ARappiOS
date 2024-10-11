//
//  ToggleChat.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//

import SwiftUI
import SwiftData
import SwiftData

struct ToggleChat: View {
    @Query var messages: [ChatModel]
    @Environment(\.modelContext) var modelContext

    @Binding var buttonOpenChat:Bool
    @Binding var modelName: String
    @Binding var position: ScrollPosition
    
    @State var textInput: String = "" 
    
    
    var body: some View {
        
        ZStack{
            Color.black.opacity(0.5).ignoresSafeArea(.all)
            VStack(spacing:10){
                HStack{
                    Button(
                        action:{
                            
                            self.buttonOpenChat.toggle()}
                    ){
                        Image(systemName: "arrow.left").font(.system(size:25)).buttonStyle(PlainButtonStyle())
                        Text("Cerrar").font(.subheadline).bold()
                    }
                    .foregroundColor(.white)
                    Spacer()
                    Button(
                        action:{
                            
                            for msj in messages{
                                modelContext.delete(msj)
                            }
                            try? modelContext.save()
                            let msjBase = ChatModel(id: UUID() as UUID, historialChat: ["Soy un chatbot y estoy aqui para ayudarte. Estas son algunas de las preguntas frecuentes: [BUTTONINIT]"], usuario: "angel")
                            
                            modelContext.insert(msjBase)
                            
                        }
                    ){
                        Image(systemName: "trash.fill").font(.system(size:25)).buttonStyle(PlainButtonStyle()).foregroundStyle(.white)
                        Text("Limpiar Chat").font(.subheadline).bold().foregroundStyle(.white)
                    }
                }
                .padding(30)
                
                ScrolllChatView(buttonOpenChat: $buttonOpenChat, textInput: $textInput, position:$position)
                
            }
        }
    }
    
}


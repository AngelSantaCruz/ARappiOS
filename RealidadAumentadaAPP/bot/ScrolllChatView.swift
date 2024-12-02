//
//  ScrolllChatView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 30/09/24.
//

import SwiftUI
import SwiftData

struct ScrolllChatView: View {

    @Environment(\.modelContext) var modelContext
        
    @Query(filter: #Predicate<ChatModel> { chat in
        chat.usuario == "angel"
    }) var messages: [ChatModel]
    
    
    @Binding var buttonOpenChat : Bool
    
    @Binding var textInput : String
    
    @State private var poScroll = ScrollPosition(edge: .top)
    
    @State var ButtonInits: [String] = ["lista de productos","En cuanto tiempo obtendré mi orden?","Cómo puedo saber el precio de los productos?","Lista de sofas", "Lista de sillas", "Lista de mesas"]
    
    let typeButton = ["[BUTTONSOFA]","[BUTTONMESA]","[BUTTONSILLA]"]

    @Query(filter: #Predicate<ImageAnalisis> { Image in
        Image.title == "analisis"
    }) var imageData: [ImageAnalisis]

  
    
    var body: some View {

        ScrollView {
            ForEach(messages , id: \.self) { chat in
                    
                
                ForEach(chat.historialChat, id: \.self){ messageModel in
                    
                    
                    // messageModel = "hola como esta[USER]"
                    if messageModel.contains("[USER]"){
                        USERChange(messages: messageModel)
                    }else if messageModel.contains("[BOT]"){
                        AIChange(messageModel: messageModel, buttonOpenChat: $buttonOpenChat )
                        //
                    }else if messageModel.contains("[USERIMAGE]"){// valida messageModel = "[USERIMAGE]"
                        IMAGEChange()
                    }else if messageModel.contains("[BUTTONINIT]") {
                        let newMessage = messageModel.replacingOccurrences(of: "[BUTTONINIT]", with: "")
                        INITChange(newMessage: newMessage, messages:messages, poScroll:$poScroll, ButtonInits:$ButtonInits)
                            
                    }else if messageModel.contains("[BUTTONLISTA]") {
                            let newMessage = messageModel.replacingOccurrences(of: "[BUTTONLISTA]", with: "")
                            
                            VStack(spacing:15){
                                //lista
                                ModelsCategoryGridChat(buttonOpenChat: $buttonOpenChat, category: ModelCategory.silla, messageRes: newMessage)
                                ModelsCategoryGridChat(buttonOpenChat: $buttonOpenChat, category: ModelCategory.mesa, messageRes: "")
                                ModelsCategoryGridChat(buttonOpenChat: $buttonOpenChat, category: ModelCategory.sofa, messageRes: "")
                            }
                    }else if messageModel.contains("[BUTTONMESA]"){
                            let newMessage = messageModel.replacingOccurrences(of: "[BUTTONMESA]", with: "")
                            
                            VStack(spacing:15){
                                ModelsCategoryGridChat(buttonOpenChat: $buttonOpenChat, category: ModelCategory.sofa, messageRes: newMessage)
                                
                                
                            }
                    }else if messageModel.contains("[BUTTONSILLA]"){
                            
                            let newMessage = messageModel.replacingOccurrences(of: "[BUTTONSILLA]", with: "")
                            
                            VStack(spacing:15){
                                ModelsCategoryGridChat(buttonOpenChat: $buttonOpenChat, category: ModelCategory.sofa, messageRes: newMessage)
                                
                                
                            }
                    }else if messageModel.contains("[BUTTONSOFA]"){
                            
                            let newMessage = messageModel.replacingOccurrences(of: "[BUTTONSOFA]", with: "")
                            
                            VStack(spacing:15){
                                
                                ModelsCategoryGridChat(buttonOpenChat: $buttonOpenChat, category: ModelCategory.sofa, messageRes: newMessage)
                                
                            }
                    }else{
                        HStack {
                            Text(messageModel)
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .foregroundStyle(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                            
                        }
                    }
                    
                    }
                
            }
        }
        .padding(8)
        .background(.white.opacity(0.4))
        .scrollPosition($poScroll)
        .onAppear {
            poScroll.scrollTo(edge: .bottom)
        }
        
        HStack{
            TextEditor(text:$textInput).padding(10).frame(width: 300,height: 100).background(Color.black.opacity(0.3)).cornerRadius(10).onSubmit{
                
               
            }
            
            Spacer()
            Button(
                action:{
                    print("presionado")
                    Task{
                        await sendMessage(message: textInput)
                    }
                    
                }
            ){
                Image(systemName:"paperplane.fill").font(.system(size:50)).buttonStyle(PlainButtonStyle()).foregroundStyle(.black)
            }
        }
        .padding(30)
    }
    
   
    
    func sendMessage(message: String) async {
        let msjinput = "[USER]" + message
        let GetRes = await getBotResponse(message: message)

        withAnimation {
            self.textInput = ""
            messages.first?.historialChat.append(msjinput)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                   
                    messages.first?.historialChat.append(GetRes)
                    
                    poScroll.scrollTo(edge: .bottom)
                   
                }
            }
            
        }
    }
    
}


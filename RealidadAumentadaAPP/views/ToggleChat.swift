//
//  ToggleChat.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//

import SwiftUI

struct ToggleChat: View {
    @Binding var buttonOpenChat:Bool
    @Binding var modelName: String
    @State private var position = ScrollPosition(edge: .top)
    
    var List: [String] = ["Silla#1","Silla#2","Silla#3","Silla#4","Silla#5","Sofa#1","Sofa#2","Mesa#1","Mesa#2","Mesa#3"]
    
    var ListMesa: [String] = ["Mesa#1","Mesa#2","Mesa#3"]
    var ListSilla: [String] = ["Silla#1","Silla#2","Silla#3","Silla#4","Silla#5"]
    var ListSofa: [String] = ["Sofa#1","Sofa#2"]
    var ButtonInits: [String] = ["lista de productos","En cuanto tiempo obtendré mi orden?","Cómo puedo saber el precio de los productos?"]
    @State var textInput: String = ""
    @State var messages: [String] = ["Soy un chatbot y estoy aqui para ayudarte[BUTTONINIT]"]

    var body: some View {
        NavigationView{
            VStack(spacing:10){
                HStack{
                    Button(
                        action:{
                            self.buttonOpenChat.toggle()}
                    ){
                        Image(systemName: "arrow.left").font(.system(size:25)).buttonStyle(PlainButtonStyle())
                        Text("Cerrar").font(.subheadline).bold()
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding(30)
                
                ScrollView {
                               ForEach(messages, id: \.self) { message in
                                   // If the message contains [USER], that means it's us
                                   if message.contains("[USER]") {
                                       let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                       
                                       // User message styles
                                       HStack {
                                           Spacer()
                                           Text(newMessage)
                                               .padding()
                                               .foregroundColor(Color.white)
                                               .background(Color.blue.opacity(0.8))
                                               .cornerRadius(10)
                                               .padding(.horizontal, 16)
                                               .padding(.bottom, 10)
                                       }
                                   }else if message.contains("[BUTTONINIT]") {
                                       let newMessage = message.replacingOccurrences(of: "[BUTTONINIT]", with: "")
                                                                              
                                      
                                           
                                       VStack(spacing:15){
                                           HStack{
                                               Text(newMessage )
                                                .padding()
                                                .background(Color.gray.opacity(0.35))
                                                .foregroundStyle(Color.white)
                                                .cornerRadius(10)
                                                .padding(.horizontal, 16)
                                                .padding(.bottom, 10)
                                               Spacer()
                                               
                                           }
                                            
                                           HStack{
                                               
                                               VStack(spacing:15){
                                                   ForEach(ButtonInits, id: \.self) { item in
                                                       
                                                       HStack{
                                                           Button(
                                                            action:{
                                                                sendMessage(message: item)
                                                            }
                                                           ){
                                                               Text(item)
                                                           }.padding(10).background(.black.opacity(0.6)).cornerRadius(10).foregroundStyle(.white)
                                                        
                                                           Spacer()
                                                       }
                                                       
                                                   }
                                               }
                                               Spacer()

                                           }
                                                   
                                               
                                        }.padding(.horizontal,20)
                                       
                                   }else if message.contains("[BUTTONLISTA]") {
                                       let newMessage = message.replacingOccurrences(of: "[BUTTONLISTA]", with: "")
                                                                
                                       VStack(spacing:15){
                                           HStack{
                                               Text(newMessage)
                                                   .padding()
                                                   .background(Color.gray.opacity(0.35))
                                                   .foregroundStyle(Color.white)
                                                   .cornerRadius(10)
                                                   .padding(.horizontal, 16)
                                                   .padding(.bottom, 10)
                                               Spacer()
                                               
                                           }
                                           ScrollView(.horizontal){
                                               HStack(spacing:15){
                                                   ForEach(List, id: \.self) { item in
                                                       
                                                       
                                                       Button(
                                                        action:{
                                                            sendMessage(message: item)
                                                            self.modelName=item.lowercased()
                                                        }
                                                       ){
                                                           Image(item).frame(width: 80, height:80) .buttonStyle(PlainButtonStyle()).background(.black.opacity(0.7)).cornerRadius(10)
                                                               .aspectRatio(contentMode: .fit)
                                                       }.padding(10).background(.black.opacity(0.6)).cornerRadius(10).foregroundStyle(.white)
                                                       
                                                       
                                                       
                                                   }
                                               }
                                           }
                                       }
                                   }else if message.contains("[BUTTONMESA]"){
                                       let newMessage = message.replacingOccurrences(of: "[BUTTONMESA]", with: "")
                                                                
                                       VStack(spacing:15){
                                           HStack{
                                               Text(newMessage)
                                                   .padding()
                                                   .background(Color.gray.opacity(0.35))
                                                   .foregroundStyle(Color.white)
                                                   .cornerRadius(10)
                                                   .padding(.horizontal, 16)
                                                   .padding(.bottom, 10)
                                               Spacer()
                                               
                                           }
                                           ScrollView(.horizontal){
                                               HStack(spacing:15){
                                                   ForEach(ListMesa, id: \.self) { item in
                                                       
                                                       
                                                       Button(
                                                        action:{
                                                            sendMessage(message: item)
                                                            self.modelName=item.lowercased()
                                                        }
                                                       ){
                                                           Image(item).frame(width: 80, height:80) .buttonStyle(PlainButtonStyle()).background(.black.opacity(0.7)).cornerRadius(10)
                                                               .aspectRatio(contentMode: .fit)
                                                       }.padding(10).background(.black.opacity(0.6)).cornerRadius(10).foregroundStyle(.white)
                                                       
                                                       
                                                       
                                                       
                                                   }
                                               }
                                           }
                                       }
                                   }else if message.contains("[BUTTONSILLA]"){
                                       
                                       let newMessage = message.replacingOccurrences(of: "[BUTTONSiILLA]", with: "")
                                                                
                                       VStack(spacing:15){
                                           HStack{
                                               Text(newMessage)
                                                   .padding()
                                                   .background(Color.gray.opacity(0.35))
                                                   .foregroundStyle(Color.white)
                                                   .cornerRadius(10)
                                                   .padding(.horizontal, 16)
                                                   .padding(.bottom, 10)
                                               Spacer()
                                               
                                           }
                                           ScrollView(.horizontal){
                                               HStack(spacing:15){
                                                   ForEach(ListSilla, id: \.self) { item in
                                                       
                                                       
                                                       Button(
                                                        action:{
                                                            sendMessage(message: item)
                                                            self.modelName=item.lowercased()
                                                        }
                                                       ){
                                                           Image(item).frame(width: 80, height:80) .buttonStyle(PlainButtonStyle()).background(.black.opacity(0.7)).cornerRadius(10)
                                                               .aspectRatio(contentMode: .fit)
                                                           
                                                       }.padding(10).background(.black.opacity(0.6)).cornerRadius(10).foregroundStyle(.white)
                                                       
                                                       
                                                   }
                                               }
                                           }
                                       }
                                   }else if message.contains("[BUTTONSOFA]"){
                                       
                                       let newMessage = message.replacingOccurrences(of: "[BUTTONSOFA]", with: "")
                                                                
                                       VStack(spacing:15){
                                           HStack{
                                               Text(newMessage)
                                                   .padding()
                                                   .background(Color.gray.opacity(0.35))
                                                   .foregroundStyle(Color.white)
                                                   .cornerRadius(10)
                                                   .padding(.horizontal, 16)
                                                   .padding(.bottom, 10)
                                               Spacer()
                                               
                                           }
                                           ScrollView(.horizontal){
                                               HStack(spacing:15){
                                                   ForEach(ListSofa, id: \.self) { item in
                                                       
                                                       
                                                       Button(
                                                        action:{
                                                            sendMessage(message: item)
                                                            self.modelName=item.lowercased()
                                                        }
                                                       ){
                                                           Image(item).frame(width: 80, height:80) .buttonStyle(PlainButtonStyle()).background(.black.opacity(0.7)).cornerRadius(10)
                                                               .aspectRatio(contentMode: .fit)
                                                       }.padding(10).background(.black.opacity(0.6)).cornerRadius(10).foregroundStyle(.white)
                                                       
                                                       
                                                   }
                                               }
                                           }
                                       }
                                   }
                                   else {
                                       
                                       // Bot message styles
                                       HStack {
                                           Text(message)
                                               .padding()
                                               .background(Color.gray.opacity(0.35))
                                               .foregroundStyle(Color.white)
                                               .cornerRadius(10)
                                               .padding(.horizontal, 16)
                                               .padding(.bottom, 10)
                                           Spacer()
                                        
                                       }
                                   }
                                   
                               }.rotationEffect(.degrees(180))
                }
                .scrollPosition($position)
                .rotationEffect(.degrees(180))
                .background(Color.gray.opacity(0.1))
                
                HStack{
                    TextEditor(text:$textInput).padding(10).frame(width: 300,height: 100).background(Color.black.opacity(0.3)).cornerRadius(10).onSubmit {
                        sendMessage(message: textInput)
                    }
                    Spacer()
                    Button(
                        action:{
                            print("presionado")
                            sendMessage(message: textInput)
                        }
                    ){
                        Image(systemName:"paperplane.fill").font(.system(size:50)).buttonStyle(PlainButtonStyle()).foregroundStyle(.black)
                    }
                }
                .padding(30)
            }
            .background(Color.black.opacity(0.4))
        }
        .navigationTitle("Chat bot")
    }
    
    func sendMessage(message: String) {
           withAnimation {
               messages.append("[USER]" + message)
               self.textInput = ""
               
               DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                   withAnimation {
                        messages.append(getBotResponse(message: message))
                        position.scrollTo(edge: .top)
                   }
               }
           }
    }
    
}




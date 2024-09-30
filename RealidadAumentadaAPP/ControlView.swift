//
//  Untitled.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//

import SwiftUI

struct ControlView:View {
    @Binding var buttonOpenChat:Bool
    @Binding var buttonIsVisible:Bool
    @Binding var buttonOpenBrowse:Bool
    @Binding var modelName: String
    var body: some View{
        VStack{
            TopButton(buttonIsVisible: $buttonIsVisible)
            Spacer()
            if buttonIsVisible{
                FooterBar(buttonOpenChat:$buttonOpenChat, buttonOpenBrowse: $buttonOpenBrowse,modelName:$modelName)
            }
           
        }
    }
}

struct TopButton:View {
    @Binding var buttonIsVisible:Bool

    var body: some View {
        HStack{
            Spacer()
            Button(action:{
                print("alerta boton presionado")
                self.buttonIsVisible.toggle()
            }){
                Image(systemName: "square.split.bottomrightquarter.fill").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }
        }.padding(30)
    }
}

struct FooterBar:View {
    @Binding var buttonOpenChat:Bool
    @Binding var buttonOpenBrowse:Bool
    @Binding var modelName: String
    var body: some View {
        HStack{
            Button(action:{
                print("alerta boton presionado")
                self.buttonOpenChat.toggle()
            }){
                Image(systemName: "ellipsis.message.fill").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.sheet(isPresented: $buttonOpenChat, content: {
                ToggleChat(buttonOpenChat:$buttonOpenChat, modelName:$modelName)
            })
            Spacer()
            
            Button(action:{
                print("alerta boton presionado")
                self.buttonOpenBrowse.toggle()
            }){
                Image(systemName: "list.bullet.circle.fill").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.sheet(isPresented: $buttonOpenBrowse, content: {
                BrowseView(buttonOpenBrowse:$buttonOpenBrowse, modelName:$modelName)
            })
        }.frame(maxWidth: 500).padding(40).background(Color.black.opacity(0.2))
    }
}

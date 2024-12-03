//
//  Untitled.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//

import SwiftUI
import SwiftData

struct ControlView:View {
    @Binding var buttonOpenChat:Bool
    @Binding var buttonIsVisible:Bool
    @Binding var buttonOpenBrowse:Bool
    @State private var buttonEnabled = true
    @StateObject var poScroll = PositionScroll()

    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<ChatModel> { chat in
        chat.usuario == "angel"
    }) var messages: [ChatModel]
    
    
    @Query(filter: #Predicate<ImageAnalisis> { Image in
        Image.title == "analisis"
    }) var imageData: [ImageAnalisis]

    @Binding var modelName: String
    var body: some View{
        VStack(spacing:10){
            TopButton(buttonIsVisible: $buttonIsVisible)
            Spacer()
            if buttonIsVisible{
                //boton de analisis
                HStack{
                        Spacer()
                    Button(action:{
                        self.buttonEnabled = false
                        if imageData.isEmpty{
                            //toma el capture para que sea analizada por la IA
                            ARVariables.arView.snapshot(saveToHDR:false) { image in
                                let compressedImage = UIImage(data: (image?.pngData())!)
                                UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                                let newImage = ImageAnalisis(image: image!.pngData()!)
                                modelContext.insert(newImage)
                                try? modelContext.save()
                                
                                
                                messages.first?.historialChat.append("[USERIMAGE]")
                                
                                Task{
                                    let msj = await getBotResponse(message: "[IMAGE]")
                                    messages.first?.historialChat.append(msj)
                                    self.buttonOpenChat.toggle()
                                    self.buttonEnabled = true
                                    
                                    poScroll.position.scrollTo(edge: .bottom)
                                }

                            }
                        }else{
                            ARVariables.arView.snapshot(saveToHDR:false) { image in
                                imageData.first?.image = image!.pngData()!
                                try? modelContext.save()
                                
                                messages.first?.historialChat.append("[USERIMAGE]")

                                Task{
                                    let msj = await getBotResponse(message: "[IMAGE]")
                                    messages.first?.historialChat.append(msj)
                                    self.buttonOpenChat.toggle()
                                    self.buttonEnabled = true
                                    
                                    poScroll.position.scrollTo(edge: .bottom)
                                }
                                
                            }
                        }

                        }){
                            Image(systemName: "rectangle.and.text.magnifyingglass").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
                        }.padding(10).background(.gray.opacity(0.5)).cornerRadius(10)
                }.padding(30).disabled(!buttonEnabled).opacity(buttonEnabled ? 1 : 0.5)
                FooterBar(buttonOpenChat:$buttonOpenChat, buttonOpenBrowse: $buttonOpenBrowse,modelName:$modelName)
                
                
            }
           
        }
    }
}

struct TopButton:View {
    @Binding var buttonIsVisible:Bool
    
    @EnvironmentObject var sceneManager:SceneManager

    var body: some View {
        //boton de la parte superior
        HStack(spacing:20){
            Spacer()
            
            Button(action:{
                print("alerta Screenshot presionado")
                
                // esta es la accion que se ejecuta con el boton de screenshot, aqui se crea una imgen de la vista de realidad aumentada y se guarda en la base de datos
                for anchorEntity in self.sceneManager.anchorEntities{
                    print("remove entity")
                    anchorEntity.removeFromParent()
                }

            }){
                Image(systemName: "trash.slash").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.padding(10).cornerRadius(30).background(.gray.opacity(0.7))

            
            Button(action:{
                print("alerta boton presionado")
                self.buttonIsVisible.toggle()
            }){
                Image(systemName: "square.split.bottomrightquarter.fill").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.padding(10).background(.gray.opacity(0.5)).cornerRadius(10)
        }.padding(30)
    }
}

struct FooterBar:View {
    @Binding var buttonOpenChat:Bool
    @Binding var buttonOpenBrowse:Bool
    @Binding var modelName: String
    
    @StateObject var poScroll = PositionScroll()
    
    @Query var messages: [ChatModel]
    
    @Query var imageData: [ImageData]
    
    @Environment(\.modelContext) var modelContext

    var body: some View {
        //seccion de los tres botones Chat, Screenshot y lista
        HStack{
            Spacer()
            Button(action:{
                
                if messages.isEmpty{
                    //Al arribar el chat por primera vez, aqui se valida si en la base de datos el array de chats esta vacio o no, si esta vacio agregar un elemento al array, que seria el modelo ChatModel con el mensaje inicial
                    
                    let msjBase = ChatModel(id: UUID(), historialChat:[ "Soy un chatbot y estoy aqui para ayudarte. Estas son algunas de las preguntas frecuentes: [BUTTONINIT]"], usuario: "angel")
                    modelContext.insert(msjBase)
                    try? modelContext.save()
                    
                }
                //aqui se llama el metodo que intercambia el valor de la varible de true o false o viceversa
                self.buttonOpenChat.toggle()
                
                poScroll.position.scrollTo(edge: .bottom)

            }){
                Image(systemName: "ellipsis.message.fill").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.sheet(isPresented: $buttonOpenChat , content: {
                ToggleChat(buttonOpenChat:$buttonOpenChat, modelName:$modelName)
            })

            Spacer()
            
            
            Button(action:{
                print("alerta Screenshot presionado")
                
                // esta es la accion que se ejecuta con el boton de screenshot, aqui se crea una imgen de la vista de realidad aumentada y se guarda en la base de datos
                
                
                ARVariables.arView.snapshot(saveToHDR:false) { image in
                    let compressedImage = UIImage(data: (image?.pngData())!)
                    UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                    let newImage = ImageData(image: image?.pngData())
                    modelContext.insert(newImage)
                    try? modelContext.save()
                    print(imageData)
                }

            }){
                Image(systemName: "camera.viewfinder").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.padding(10).cornerRadius(30).background(.gray.opacity(0.7))
            Spacer()
            Button(action:{
                print("alerta boton presionado")
                self.buttonOpenBrowse.toggle()
            }){
                Image(systemName: "list.bullet.circle.fill").font(.system(size:40)).foregroundColor(.white).buttonStyle(PlainButtonStyle())
            }.sheet(isPresented: $buttonOpenBrowse, content: {
                
                // los sheet son ventanas emergente
                BrowseView(buttonOpenBrowse:$buttonOpenBrowse, modelName:$modelName)
            })
            Spacer()
        }
        .frame(maxWidth: 500).padding(40).background(Color.black.opacity(0.2))
        .environmentObject(poScroll)
    }
}

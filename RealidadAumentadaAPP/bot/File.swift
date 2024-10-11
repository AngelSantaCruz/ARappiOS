//
//  File.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 23/09/24.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI
import SwiftData


@Query(filter: #Predicate<ChatModel> { chat in
    chat.usuario == "angel"
}) var messages: [ChatModel]


@Query(filter: #Predicate<ImageAnalisis> { Image in
        Image.title == "analisis"
    }) var imageData: [ImageAnalisis]

func getBotResponse(message: String) async -> String {



    
    let tempMessage = message.lowercased()
    let modelAI = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey:"AIzaSyBmlxJn-bSU0qZjdlJ0bJihXosalRkg_ns")

    
    var historialChat: [ModelContent] = []
    
    
    
    for dataChat in messages{
        for msj in dataChat.historialChat{
            
            historialChat.append(ModelContent(role:( msj.contains("[USER]") ? "user" : "model"),  parts: msj))
                  
        }
      
    }
    
    
    if tempMessage.contains("hola"){
        return "hola, en que te puedo ayudar? [BUTTONINIT]"
    }else if tempMessage.contains("gracias"){
        return "Estoy a la orden"
    }else if tempMessage.contains("lista de productos") {
        return "Estos son algunos de los productos mas vendidos: [BUTTONLISTA]"
    }else if tempMessage.contains("en cuanto tiempo obtendré mi orden?") {
        return "El tiempo puede variar dependiendo del producto seleccionado."
    }else if tempMessage.contains("cómo puedo saber el precio de los productos?") {
        return "Necesitas seleccionar un producto para conocer su precio"
    }else if tempMessage.contains("-soporte"){
        return "Pronto te redireccionaremos con alguno de nuestros agente de atencion al cliente."
    }else if tempMessage.contains("lista de sofas") {
        return "Esta es nuestra lista de muebles disponibles: [BUTTONSOFA]"
    }else if tempMessage.contains("lista de mesas") {
        return "Esta rd nuestra lista de mesas disponibles: [BUTTONMESA]"
    }else if tempMessage.contains("lista de sillas") {
        return "Esta es nuestra lista de sillas disponibles: [BUTTONSILLA]"
    }else if tempMessage.contains("silla#1") {
        return "info silla 1[SEEMODEL]"
    }else if tempMessage.contains("silla#2"){
        return "info silla 2[SEEMODEL]"
    }else if tempMessage.contains("silla#3"){
        return "info silla 3[SEEMODEL]"
    }else if tempMessage.contains("silla#4"){
        return "info silla 4[SEEMODEL]"
    }else if tempMessage.contains("silla#5"){
        return "info silla 5[SEEMODEL]"
    }else if tempMessage.contains("sofa#1"){
        return "info sofa 1[SEEMODEL]"
    }else if tempMessage.contains("sofa#2"){
        return "info sofa 2[SEEMODEL]"
    }else if tempMessage.contains("mesa#1"){
        return "info mesa 1[SEEMODEL]"
    }else if tempMessage.contains("mesa#2"){
        return "info mesa 2[SEEMODEL]"
    } else if tempMessage.contains("mesa#3"){
        return "info mesa 3[SEEMODEL]"
    }else if tempMessage.contains("[IMAGEN]"){
       
        let prompt = "si quieres ofrecerle sofas a tus clientes,al texto de tu respuesta agregale: [BUTTONSOFA]. Si quieres ofrecele sillas,agregale a tu respuesta: [BUTTONSILLA]. si quieres ofrecer mesas, agrega al texto de tu respuesta: [BUTTONMESA]. recuerda Responder con las pautas anteriores como vendedor de muebles. Analiza la siguiente imagen y dime que objetos le pueden faltar a la habitacion y que tipo de habitacion es:"
        var ResIA = ""
       
            
        let imagen = UIImage(data:imageData.first!.image)!

            let chat = modelAI.startChat(history: historialChat)
            
            do{
                
                let response = try await chat.sendMessage(prompt, imagen)
                
                guard let text = response.text else {
                    
                    ResIA = "Hubo un error, intente de nuevo "
                    return ResIA
                }
                ResIA = "[BOT]" + text
                return ResIA
            }catch{
                
                ResIA = "\(error)"
                return ResIA
            }

       
        
    }else {
        let prompt = "si quieres ofrecerle sofas a tus clientes,al texto de tu respuesta agregale:[BUTTONSOFA]. Si quieres ofrecele sillas,agregale a tu respuesta:[BUTTONSILLA]. si quieres ofrecer mesas, agrega al texto de tu respuesta:[BUTTONMESA], PERO solo puedes agregar umo a tu respuesta si quieres enviar los tres agrega solamente a tu respuesta: [BUTTONLISTA]. recuerda Responder con las pautas anteriores como vendedor de muebles al siguiente mensaje y tomar en consideracion los mensajes anteriores:" + tempMessage
        var ResIA = ""
        print(historialChat)
      
            let chat = modelAI.startChat(history: historialChat)
            
            do{
                
                let response = try await chat.sendMessage(prompt)
                
                guard let text = response.text else {
                    
                    ResIA = "Hubo un error, intente de nuevo "
                    return ResIA
                }
                ResIA =  "[BOT]" + text
                return ResIA
            }catch{
                
                ResIA = "\(error)"
                return ResIA
            }
      
        
    }
}



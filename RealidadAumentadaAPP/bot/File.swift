//
//  File.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 23/09/24.
//

import Foundation

func getBotResponse(message: String) -> String {
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hola"){
        return "hola, en que te puedo ayudar"
    }else if tempMessage.contains("-gracias"){
        return "Estoy a la orden"
    }else if tempMessage.contains("lista de productos") {
        return "Estos son alguno de los productos mas vendidos: [BUTTONLISTA]"
    }else if tempMessage.contains("en cuanto tiempo obtendré mi orden?") {
        return "El tiempo puede variar dependiendo del producto seleccionado."
    }else if tempMessage.contains("cómo puedo saber el precio de los productos?") {
        return "Necesitas seleccionar un producto para conocer su precio"
    }else if tempMessage.contains("-soporte"){
        return "Pronto te redireccionaremos con alguno de nuestros agente de atencion al cliente."
    }else if tempMessage.contains("lista de mueble") {
        return "Esta es nuestra lista de muebles disponibles: [BUTTONMUEBLE]"
    }else if tempMessage.contains("lista de mesa") {
        return "Esta rd nuestra lista de mesas disponibles: [BUTTONMESA]"
    }else if tempMessage.contains("lista de silla") {
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
    } else {
        return "No puedo ayudarte con eso"
    }
}

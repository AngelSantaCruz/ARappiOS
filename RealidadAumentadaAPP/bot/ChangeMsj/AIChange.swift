//
//  AIChange.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 8/10/24.
//

import SwiftUI

struct AIChange: View {
    
    var messageModel : String
    var buttonOpenChat: Binding<Bool>
    
    var body: some View {
        
        let Message = self.messageModel.replacingOccurrences(of: "[BOT]", with: "")
        
        let delimiters = CharacterSet(charactersIn: "[]")
        let components = Message.components(separatedBy: delimiters)
        
        let filterMsj = components.filter{ ms in
            if ms.contains("\n") && ms.count < 4{
                return false
            }else{
                return true
            }
        }
        
        VStack(alignment: .leading ,spacing:15){
            
            ForEach(filterMsj, id: \.self){ msj in
                if msj.contains("BUTTONLISTA"){
                    ModelsCategoryGridChat(buttonOpenChat: buttonOpenChat, category: ModelCategory.sofa, messageRes: "")
                    ModelsCategoryGridChat(buttonOpenChat: buttonOpenChat, category: ModelCategory.silla, messageRes: "")
                    ModelsCategoryGridChat(buttonOpenChat: buttonOpenChat, category: ModelCategory.mesa, messageRes: "")
                }else if msj.contains("BUTTONMESA"){
                    ModelsCategoryGridChat(buttonOpenChat: buttonOpenChat, category: ModelCategory.mesa, messageRes: "")
                }else if msj.contains("BUTTONSILLA"){
                    ModelsCategoryGridChat(buttonOpenChat: buttonOpenChat, category: ModelCategory.silla, messageRes: "")
                }else if msj.contains("BUTTONSOFA"){
                    ModelsCategoryGridChat(buttonOpenChat: buttonOpenChat, category: ModelCategory.sofa, messageRes: "")
                }else{
                    Text(msj).padding()
                        .background(Color.black.opacity(0.6))
                        .foregroundStyle(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                }
                
                
            }
        }.onAppear {
            print(components)
        }
    }
}


//
//  INITChange.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 6/10/24.
//
import Foundation
import SwiftUI
import SwiftData

struct INITChange: View {
    var newMessage : String
    
    var messages: [ChatModel]
    
    @Binding var poScroll:ScrollPosition
    @Binding var ButtonInits: [String]

    var body: some View {
        
        
        
        VStack(alignment: .leading, spacing:15 ){
            Text(newMessage)
                .padding()
                .background(Color.black.opacity(0.6))
                .foregroundStyle(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            
            HStack{
                
                VStack(spacing:15){
                    ForEach($ButtonInits, id: \.self){ item in
                        
                        HStack{
                            Button(
                                action:{
                                    Task{
                                        
                                        messages.first?.historialChat.append("[USER]\(item.wrappedValue )")
                                            
                                        messages.first?.historialChat.append(await getBotResponse(message: "\(item.wrappedValue)"))
                                        poScroll.scrollTo(edge: .bottom)
                                   
                                        
                                    }
                                    
                                }
                            ){
                                HStack(alignment: .center, spacing: 10){
                                    Image(systemName: "arrow.up.right.square.fill") .foregroundStyle(.white).font(.title)
                                    Text("\(item.wrappedValue)").multilineTextAlignment(.leading)
                                    
                                }
                            }.padding(10).background(.black.opacity(0.6)).cornerRadius(10).foregroundStyle(.white)
                            
                            Spacer()
                        }.padding(.horizontal,10)
                        
                    }
                }
                Spacer()
                
            }
            
            
        }.padding(.horizontal,20)
    }
}



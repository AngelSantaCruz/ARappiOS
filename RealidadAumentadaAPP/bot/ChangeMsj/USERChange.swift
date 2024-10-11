//
//  USERChange.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 6/10/24.
//

import SwiftUI

struct USERChange: View {
    var messages : String
    var body: some View {
    
       let newMessage =  messages.replacingOccurrences(of: "[USER]", with: "")
           
            VStack(spacing:15){
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
                
            }
           

        
    }
}


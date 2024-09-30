//
//  NewsView.swift
//  ARapp
//
//  Created by Gelo Santa Cruz on 18/09/24.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        
        VStack(spacing:20){
            
            VStack(spacing:20){
                Text("Noticia")
                Text("Novedades de lunes").font(.caption).multilineTextAlignment(.leading)
                Text("Chatea con nuestro chatBot y obtén una vista previa de nuestros productos").font(.caption).multilineTextAlignment(.leading)
            }.padding(10).background(.black.opacity(0.20)).cornerRadius(10)
            
            VStack(spacing:20){
                Text("Noticia")
                Text("Novedades de lunes").font(.caption).multilineTextAlignment(.leading)
                Text("Chatea con nuestro chatBot y obtén una vista previa de nuestros productos").font(.caption).multilineTextAlignment(.leading)
            }.padding(10).background(.black.opacity(0.20)).cornerRadius(10)
            
            
            Spacer()
           
        
        }.padding(40)
    }
            
    
}

#Preview {
    NewsView()
}

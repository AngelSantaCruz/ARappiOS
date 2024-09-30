//
//  ContentView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 20/09/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        NavigationView {
            
            VStack(spacing:20) {
                Spacer()
                NavigationLink(destination:ChatView()){
                    
                    VStack(alignment:.leading){
                        
                        HStack(spacing:15){
                            Image(systemName: "ellipsis.message")
                                .resizable()
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading, spacing: 6){
                                Text("Comienza a chatear")
                                Text("Chatea con nuestro chatBot y obtén una vista previa de nuestros productos").font(.caption).multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        
                    }
                } .padding(22)
                    .frame(width: 310.0, height: 150.0)
                    .background(Color.white)
                    .cornerRadius(20)
                    .foregroundColor(.black)
                
                
                HStack(spacing:20){
                    Spacer()
                    NavigationLink (destination:HelpView()){
                        VStack{
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Ayuda")
                        }
                        .frame(width: 80.0, height: 80.0)
                        .cornerRadius(20)
                        .background(Color.white)
                        .foregroundColor(.black)
                    }.padding(4).cornerRadius(20)
                    
                    NavigationLink (destination:IdeaView()){
                        VStack{
                            Image(systemName: "lightbulb.max")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Ideas")
                        }
                        .frame(width: 80.0, height: 80.0)
                        .cornerRadius(20)
                        .background(Color.white)
                        .foregroundColor(.black)
                    }.padding(4).cornerRadius(20)
                    
                    NavigationLink (destination:NewsView()){
                        
                        VStack{
                            Image(systemName: "newspaper")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Noticias")
                        }
                        .frame(width: 80.0, height: 80.0)
                        .cornerRadius(20)
                        .background(Color.white)
                        .foregroundColor(.black)
                    }.padding(4).cornerRadius(20)
                    Spacer()
                }
                . padding(10)
                .navigationBarTitle("Inicio")
                .foregroundColor(.blue)
                Spacer()
                
                VStack(alignment:.leading){
                    Text("Capturas recientes").font(.title)
                    Spacer()
                }
                .padding(10)
                .frame(width:500, height: 250.0)       .background(Color.white)
            }
            .background(Gradient(colors: [Color.teal,Color.blue,Color.cyan]))
            
        }
    }
}

#Preview {
    ContentView()
}

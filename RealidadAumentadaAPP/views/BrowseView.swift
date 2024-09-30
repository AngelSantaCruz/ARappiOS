//
//  BrowseView.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 22/09/24.
//

import SwiftUI

struct BrowseView: View {
    @Binding var buttonOpenBrowse:Bool
    @Binding var modelName: String
    
    var body: some View{
        NavigationView{
            ScrollView(showsIndicators:false){
                ModelsCategoryGrid(buttonOpenBrowse:$buttonOpenBrowse)
            }.navigationBarTitle(Text("Lista"), displayMode:.large)
            .navigationBarItems(leading: Button(
                    action:{
                        self.buttonOpenBrowse.toggle()
                    }
                ){
                    HStack(spacing:10){
                        Image(systemName: "arrow.left").font(.title2).bold().foregroundStyle(.black.opacity(0.7))
                        Text("Cerrar").font(.title2).bold().foregroundStyle(.black.opacity(0.7))
                    }
                    
                })
            .background(.black.opacity(0.5))
        }
    }
}


struct ModelsCategoryGrid: View {
    @Binding var buttonOpenBrowse:Bool
    let models = Models()
    
    var body: some View {
        VStack{
            ForEach(ModelCategory.allCases, id: \.self ) { category in
                let modelByCategory = models.get(category: category)

                if !modelByCategory.isEmpty{
                    HorizontalGrid(buttonOpenBrowse: $buttonOpenBrowse, tittle: category.Label, items:modelByCategory)
                }
            }
        }
    }
}

struct HorizontalGrid:View {
    @Binding var buttonOpenBrowse:Bool
    @EnvironmentObject var placementSettings: PlacementSettings
    var tittle:String
    
    var items:[Model]
    
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(tittle).font(.title2).bold().padding(.leading,22)
                .padding(.top,10)
            ScrollView(.horizontal, showsIndicators: false){
                LazyHGrid(rows:gridItemLayout, spacing:20){
                    
                  
                    ForEach(0...items.count-1,id: \.self){ item in
                        ButtonItems(model: items[item]) {
                            items[item].LoadModelEntity()
                            self.placementSettings.selectedModel = items[item]
                            print("item presionado")
                            self.buttonOpenBrowse.toggle()
                        }
                    }
                }.padding(.horizontal,22).padding(.vertical,12)


            }
            
            
        }
    }
}

struct ButtonItems:View{
    
    let model: Model
    let action: ()->Void
    
    var body: some View{
        Button(action: {
            self.action()
        }){
            Image(uiImage:self.model.img).resizable().frame(width: 100, height: 100).aspectRatio(1/1,contentMode: .fit).background( Color(UIColor.secondarySystemFill)).cornerRadius(10)
        }
    }
}

//
//  Vertical.swift
//  RealidadAumentadaAPP
//
//  Created by Gelo Santa Cruz on 30/09/24.
//
import UIKit
import SwiftUI

struct ModelsCategoryGridChat: View {
    @Binding var buttonOpenChat:Bool
    let models = Models()
    var category: ModelCategory
    var messageRes: String
    var body: some View {
        VStack{
                let modelByCategory = models.get(category: category)

                if !modelByCategory.isEmpty{
                    HorizontalGridChat(buttonOpenChat:$buttonOpenChat, tittle: category.Label,messageRes:messageRes, items:modelByCategory)
                }
        }
    }
}

//
//  RecipeView.swift
//  LearnSwiftUIXcode11
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import SwiftUI


struct RecipeView: View{
    @State var recipe = RecipeModel()
    
    var body: some View{
        Group{
         
            HStack{
                Image(recipe.countryCode)
                       .resizable()
                           .frame(width: 20, height: 20)
                Text("\(recipe.name)")
                    .font(.subheadline)
                    .foregroundColor(Color.blue)
                    .bold()
                
       
            }
            
            VStack(alignment: .trailing, spacing: 10){
                Button(action:{
                    Helper.addRemoveFavorite(recipe: self.recipe)
                    self.recipe.favourite.toggle()
                }){
                    Image(systemName: Helper.isFavorite(name: recipe.name) ? "star.fill": "star")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .trailing)
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
       let mockRecipes = Helper.mockRecipes()
       return List(mockRecipes, id: \.id) { recipe in
           RecipeView(recipe: recipe)
       }
    }
}

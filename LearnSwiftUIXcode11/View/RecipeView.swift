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

        Group {
            VStack(alignment: .leading) {
                Text("\(recipe.name)")
                    .font(.headline)
                    .foregroundColor(Color.blue)
                    .bold()
                Image(uiImage: recipe.image).resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
            }
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

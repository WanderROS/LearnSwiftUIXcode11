//
//  RecipeDetailView.swift
//  LearnSwiftUIXcode11
//
//  Created by Wander on 2021/11/4.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View{
    @State var recipe: RecipeModel!
    @State private var viewIndex = 0
    
    private var isFavorite: Bool{
        return recipe.favourite
    }
    @EnvironmentObject var appData: AppData
    var body: some View{
        VStack(alignment: .leading, spacing: 15) {
            Image(recipe.countryCode)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
            
            HStack {
                           // Name of our recipe
                           Text("\(recipe.name)")
                               .font(.title)
                               .padding(.leading, 10)
                               .foregroundColor(self.appData.fontColor)
                           
                           // Favourites Button
                           Button(action: {
                               self.appData.fontColor = self.isFavorite ? .orange : .black
                               self.recipe.favourite.toggle()
                               self.appData.updateRecipe(recipe: self.recipe)
                           }) {
                            Image(systemName: isFavorite ? "star.fill" : "star")
                           }
                           
                       }
                       
                       // Recipe origin
                       Text("Origin: \(recipe.origin)")
                           .font(.subheadline)
                           .padding(.leading, 10)
                       
                   
                       // Picker to choose between Igredients & Recipe
                       Picker(selection: $viewIndex, label: Text("")) {
                           Text("Ingredients").tag(0)
                           Text("Recipe").tag(1)
                       }.pickerStyle(SegmentedPickerStyle())
                       
                       // Logic to determin which Picker View to show.
                       if viewIndex == 0 {
                           List(recipe.ingredients, id: \.self) { ingredient in
                               Image(systemName: "hand.point.right")
                               Text(ingredient)
                           }
                           .listStyle(GroupedListStyle())
                       } else if viewIndex == 1 {
                           Text(recipe.recipe)
                               .padding(15)
                               .multilineTextAlignment(.leading)
                       }
                       Spacer()
        }
    }
}

//
//  ContentView.swift
//  dev
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

import SwiftUI

struct ContentView: View {
    var recipes = Helper.mockRecipes()
    @State private var viewIndex = 0
    var body: some View {
        VStack {
            Picker(selection: $viewIndex, label: Text("")){
                Text("Recipes").tag(0)
                Text("Favourites").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            if viewIndex == 0 {
                List(recipes,id:\.id){
                    recipe in
                    RecipeView(recipe: recipe)
                }
            }else{
                List(Helper.getFavorites(),id:\.id){
                    recipe in
                    RecipeView(recipe: recipe)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(recipes: Helper.mockRecipes())
    }
}

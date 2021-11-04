//
//  ContentView.swift
//  dev
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

import SwiftUI

class AppData: ObservableObject {
    
    @Published var fontColor = Color.black
    @Published var recipes = [RecipeModel]()
    var favourites: [RecipeModel] {
        return recipes.filter({ $0.favourite == true })
    }
    
    func updateRecipe(recipe: RecipeModel) {
        recipes = recipes.filter( { $0.id != recipe.id } )
        recipes.append(recipe)
    }
    
}


struct ContentView: View {
    @State private var viewIndex = 0
    @EnvironmentObject var appData: AppData
    
        var body: some View {
            NavigationView {
                VStack {
                    Picker(selection: $viewIndex, label: Text("")) {
                        Text("Recipes").tag(0)
                        Text("Favourites").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if viewIndex == 0 {
                        List(appData.recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeView(recipe: recipe)
                                    .navigationBarTitle(Text("Recipes"))
                            }
                        }
                    } else if viewIndex == 1 {
                        
                        List(appData.favourites, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeView(recipe: recipe)
                                    .navigationBarTitle(Text("Favourites"))
                            }
                        }
                    }
                    
                }
                .navigationBarTitle(Text("My Favourite Recipes"))
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static let appData = AppData()
    static var previews: some View {
        ContentView().environmentObject(appData)
    }
}

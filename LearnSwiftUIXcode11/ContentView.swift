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
    @State private var showAddRecipe = false
    @State private var boolAnimation : Bool = false
    @State private var searchText : String = "hello"
        var body: some View {
            NavigationView {
                VStack {
                    NavigationView{
                        NavigationLink(destination: TimelineTableViewControllerView()){
                            Text("跳转").padding().background(Color.red).padding()
                        }
                    }
                    Text("\(searchText)")
                        ActivityIndicator(boolStart: self.boolAnimation)
                            .padding()
                        Button(action: {
                            self.boolAnimation = !self.boolAnimation
                            print("按下反转")
                        }, label: {
                            Text("反转").padding()
                        })
                    SearchBarView(text: self.$searchText, placeholder: "输入内容").padding()
                
                    Picker(selection: $viewIndex, label: Text("")) {
                        Text("Recipes").tag(0)
                        Text("Favourites").tag(1)
                    }.pickerStyle(SegmentedPickerStyle())

                    if viewIndex == 0 {
                        List(appData.recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeView(recipe: recipe)
                                    .navigationBarTitle(Text(""))
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
                 .navigationBarTitle(Text(""), displayMode: .inline) // Hack due to bug in Xcode!
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showAddRecipe.toggle()
                    }) {
                        Image(systemName: "plus")
                        .renderingMode(.original)
                    }.sheet(isPresented: $showAddRecipe) {
                        AddRecipeView().environmentObject(self.appData)
                    }
                )
                
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static let appData = AppData()
    static var previews: some View {
        ContentView().environmentObject(appData)
    }
}

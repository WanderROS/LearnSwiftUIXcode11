//
//  RecipeModel.swift
//  LearnSwiftUIXcode11
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

class RecipeModel: ObservableObject{
    @Published var recipes = [String]()
    var id = UUID()
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0){
            self.recipes.append(contentsOf:["Porks","Beef","Chinese Tea"])
        }
    }
}

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
    let recipeNames = ["Italian Chicken","Greek Bake","Health Soup"]
    @ObservedObject var recipeModel = RecipeModel()
    var body: some View{
        Group{
            VStack{
                List(recipeNames,id:\.self){
                    name in
                    Text("\(name)")
                }
                
                List(recipeModel.recipes,id:\.self){
                    name in
                    Text("\(name)")
                }
            }
        }
    }
}

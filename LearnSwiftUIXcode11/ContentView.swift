//
//  ContentView.swift
//  dev
//
//  Created by Wander on 2021/11/3.
//  Copyright © 2021 xcode11. All rights reserved.
//

import Foundation

import SwiftUI
import FSPagerView

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
    private struct TutorialItem: Identifiable {
        let id: UUID = UUID()
        let image: String
    }

    @State private var images: [TutorialItem] = [
        TutorialItem(image: "1"),
        TutorialItem(image: "2"),
        TutorialItem(image: "3"),
        TutorialItem(image: "4"),
        TutorialItem(image: "5"),
        TutorialItem(image: "6"),
        TutorialItem(image: "7"),
    ]
    
    @State var currentPage: Int = 0
    var body: some View {
        VStack{
                    ZStack(content: {
                        FSPagerViewSUI($currentPage, images) { item in
                            Image(item.image)
                                .resizable()
                                .cornerRadius(10)
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                            ).padding([.horizontal],5)
                        }
                        .itemSize(FSPagerView.automaticSize)
                        .decelerationDistance(1)
                        .didSelect { (value) in
                            print("按中\(value)")
                        }
                        .isInfinite(true)
                        .automaticSlidingInterval(3.0)
                        .transformer(FSPagerViewTransformer(type: .depth))

                        VStack(alignment: .center, spacing: nil, content: {
                            FSPageControlSUI(currentPage: $currentPage)
                                .numberOfPages(images.count)
                                .contentHorizontalAlignment(.right)
                                .contentInsets(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
                                .setFillColor(UIColor.systemPink, for: .selected)
                                .frame(maxWidth: .infinity)
                                .frame(height: 20)
                                
            //                .background(Color.black.opacity(0.5))
                        })
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                    })
                    .aspectRatio(375.0/193.0, contentMode: .fit)
            
            Button("按下"){
                self.images.append(TutorialItem(image: "find"))
            }
            Button("去掉"){
                self.images.remove(at: self.images.count-1)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

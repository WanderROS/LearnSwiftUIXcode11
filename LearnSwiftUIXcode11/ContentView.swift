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
import ObjectMapper
import Moya

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

// Model 定义
class ZhihuItemModel: Mappable{
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title <- map["title"]
        ga_prefix <- map["ga_prefix"]
        images <- map["images"]
        multipic <- map["multipic"]
        type <- map["type"]
        id <- map["id"]
    }
    
    var title:  String?
    var ga_prefix: String?
    var images: Array<String>?
    var multipic: String?
    var type: Int?
    var id: Int?
}

struct ContentView: View {
    private struct TutorialItem: Identifiable {
        let id: UUID = UUID()
        let image: Data
    }

    @State private var images: [TutorialItem] = [
//        TutorialItem(image: "1"),
//        TutorialItem(image: "2"),
//        TutorialItem(image: "3"),
//        TutorialItem(image: "4"),
//        TutorialItem(image: "5"),
//        TutorialItem(image: "6"),
//        TutorialItem(image: "7"),
    ]
    
    @State var cancelableRequest: Cancellable?
    @State var cancelableRequest2: Cancellable?
    @State var currentPage: Int = 0
    var body: some View {
        VStack{
                    ZStack(content: {
                        FSPagerViewSUI($currentPage, images) { item in
                            Image(uiImage: UIImage(data: item.image)!)
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
                //self.images.append(TutorialItem(image: "find"))
//                self.cancelableRequest = NetWorkRequest(API.easyRequset, modelType: [ZhihuItemModel].self, successCallback: { (zhihuModels, responseModel) in
//                            zhihuModels.forEach({ (item) in
//                                print("模型属性--\(item.title ?? "模型无title")" )
//                                print("图片链接--\(item.images?.first ?? "nil")")
//                                let url = URL(string: item.images?.first ?? "nil")
//                                if url != nil{
//                                    let data = try? Data(contentsOf: url!)
//                                    let temp =  TutorialItem(image: data!)
//                                    self.images.append(temp)
//                                }
//
//
//                        })
//                        }, failureCallback: { (responseModel) in
//                            print("网络请求失败 包括服务器错误和网络异常\(responseModel.code)__\(responseModel.message)")
//                        })
            }
            Button("食物"){
                DispatchQueue.global().async{
                    let url = URL(string: "https://source.unsplash.com/720x450/?food")
                    if let url = url {
                        let data = try? Data(contentsOf: url)
                        let temp =  TutorialItem(image: data!)
                        self.images.append(temp)
                    }
                }
                    self.cancelableRequest =  NetWorkRequest(API.foodImage,successCallback: {
                        (dataModel) in
                            print("success!")
                            let data = dataModel
                            let temp =  TutorialItem(image: data)
                        DispatchQueue.main.async {
                            self.images.append(temp)
                        }
                    }, failureCallback: { (response) in
                        print("网络请求失败 包括服务器错误和网络异常")
                    })
                
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

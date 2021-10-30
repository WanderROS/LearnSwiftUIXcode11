//
//  ContentView.swift
//  LearnSwiftUIXcode11
//
//  Created by wander on 2021/10/29.
//  Copyright © 2021 xcode11. All rights reserved.
//

import SwiftUI
import Combine

import EFQRCode
import Hue
import Charts

class VDChartAxisValueFormatter: NSObject,IAxisValueFormatter {
    var values:NSArray?;
    override init() {
        super.init();
    }
    init(_ values: NSArray) {
        super.init();
        self.values = values;
    }
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if values == nil {
            return "\(value)";
        }
        return values?.object(at: Int(value)) as! String;
    }
}

struct ChartView: UIViewRepresentable{
    func makeUIView(context: Context) -> LineChartView {
        let _lineChartView = LineChartView.init(frame: CGRect.init(x: 0, y: 20, width: 50, height: 50));
            _lineChartView.backgroundColor = UIColor.init(red: 230/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0);
            _lineChartView.doubleTapToZoomEnabled = false;
            _lineChartView.scaleXEnabled = false;
            _lineChartView.scaleYEnabled = false;
            _lineChartView.chartDescription?.text = "";//设置为""隐藏描述文字
            
            _lineChartView.noDataText = "暂无数据";
            _lineChartView.noDataTextColor = UIColor.gray;
            _lineChartView.noDataFont = UIFont.boldSystemFont(ofSize: 14);
            
            //y轴
            _lineChartView.rightAxis.enabled = false;
            let leftAxis = _lineChartView.leftAxis;
            leftAxis.labelCount = 10;
            leftAxis.forceLabelsEnabled = false;
            leftAxis.axisLineColor = UIColor.black;
            leftAxis.labelTextColor = UIColor.black;
            leftAxis.labelFont = UIFont.systemFont(ofSize: 10);
            leftAxis.labelPosition = .outsideChart;
            leftAxis.gridColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0);//网格
            leftAxis.gridAntialiasEnabled = false;//抗锯齿
            leftAxis.axisMaximum = 500;//最大值
            leftAxis.axisMinimum = 0;
            leftAxis.labelCount = 11;//多少等分
            
            //x轴
            let xAxis = _lineChartView.xAxis;
            xAxis.granularityEnabled = true;
            xAxis.labelTextColor = UIColor.black;
            xAxis.labelFont = UIFont.systemFont(ofSize: 10.0);
            xAxis.labelPosition = .bottom;
            xAxis.gridColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0);
            xAxis.axisLineColor = UIColor.black;
            xAxis.labelCount = 12;
            return _lineChartView;
    }
    func updateUIView(_ uiView: LineChartView, context: Context) {
       let xValues = ["x1","x2","x3","x4","x5","x6","x7","x8","x9","x10","x11","x12"];
       uiView.xAxis.valueFormatter = VDChartAxisValueFormatter.init(xValues as NSArray);
       uiView.leftAxis.valueFormatter = VDChartAxisValueFormatter.init();
       
       var yDataArray1 = [ChartDataEntry]();
       for i in 0...xValues.count-1 {
           let y = arc4random()%500;
           let entry = ChartDataEntry.init(x: Double(i), y: Double(y));
           
           yDataArray1.append(entry);
       }
        let set1 = LineChartDataSet.init(entries: yDataArray1, label: "橙色");
       set1.colors = [UIColor.orange];
       set1.drawCirclesEnabled = false;//绘制转折点
       set1.lineWidth = 1.0;
       
       var yDataArray2 = [ChartDataEntry]();
       for i in 0...xValues.count-1 {
           let y = arc4random()%500+1;
           let entry = ChartDataEntry.init(x: Double(i), y: Double(y));
           
           yDataArray2.append(entry);
       }
        let set2 = LineChartDataSet.init(entries: yDataArray2, label: "绿色");
       set2.colors = [UIColor.green];
       set2.drawCirclesEnabled = false;
       set2.lineWidth = 1.0;
       
       let data = LineChartData.init(dataSets: [set1,set2]);
    
       uiView.data = data;
    }
}



struct ContentView : View {
    @State private var selected = 3
    @State private var image : CGImage?
    @State private var dataUrl = Bundle.main.url(forResource: "QRCodeGIF6", withExtension: "gif")
    var body: some View {
            TabView(selection: $selected) {
                VStack {
                    ChartView().frame(width: 300, height: 300, alignment: .center)
                    Text("hello").padding()
                        .background(Color( UIColor(hex: "#3b5998")))
                    Text("Nice")
                    Button("Generate"){
                        if let image = EFQRCode.generate(
                            for: "https://github.com/EFPrefix/EFQRCode"
                        ) {
                            print("Create QRCode image success \(image)")
                            self.image = image
                        } else {
                            print("Create QRCode image failed!")
                        }
                    }.padding()
                    Button("Reconginze"){
                        if let testImage = self.image {
                            let codes = EFQRCode.recognize(testImage)
                            if !codes.isEmpty {
                                print("There are \(codes.count) codes")
                                for (index, code) in codes.enumerated() {
                                    print("The content of QR Code \(index) is \(code).")
                                }
                            } else {
                                print("There is no QR Codes in testImage.")
                            }
                        }
                    }
                    if image != nil {
                        Image(image!, scale: 2, label: Text("测试"))
                    }
                }
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("First")
                }.tag(0)
                Text("Another Tab")
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Second")
                    }.tag(1)
                Text("The Last Tab")
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("Third")
                    }.tag(2)
                Text("The Last Tab")
                    .tabItem {
                        if selected == 3 {
                            Image(systemName: "square.and.arrow.up")
                        } else{
                              Image(systemName: "4.square.fill")
                        }
                        Text("Forth")
                }.tag(3)
            }
            .font(.headline)
            .accentColor(.black)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

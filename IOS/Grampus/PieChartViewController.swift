//
//  ViewController.swift
//  Pie Chart View
//
//

import UIKit

class PieChartViewController : UIViewController {
    
    let pieChartView = PieChartView()
    let simplePieChartView = SimplePieChartView()
    
    let bestLooker = 1
    let superWorker = 2
    let extrovert = 3
    let untidy = 4
    let deadLiner = 5
    let introvert = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let padding: CGFloat = 20
        let height = (view.frame.height - padding * 3) / 2
        
        pieChartView.frame = CGRect(
            x: 0, y: padding, width: view.frame.size.width, height: height
        )
        
        pieChartView.segments = [
            LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "",  value: CGFloat(bestLooker)),    //Red -
            LabelledSegment(color: #colorLiteral(red: 1, green: 0.541176471, blue: 0, alpha: 1), name: "",  value: CGFloat(superWorker)),    //Orange
            LabelledSegment(color: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), name: "",  value: CGFloat(extrovert)),    //Purple
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "",  value: CGFloat(untidy)),    //Light Blue
            LabelledSegment(color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), name: "",  value: CGFloat(deadLiner)),    //Green
            LabelledSegment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "",  value: CGFloat(introvert))     //Blue
        ]
        
        //    pieChartView.segments = [
        //        LabelledSegment(color: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), name: "Green",      value: 25),      //“Best Looker”
        //        LabelledSegment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Red",        value: 57.56),   //“Super Worker”
        //        LabelledSegment(color: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), name: "Yellow",     value: 40),      //“Extrovert”
        //        LabelledSegment(color: #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), name: "Brown",     value: 30),       //“Untidy”
        //        LabelledSegment(color: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), name: "Blue",       value: 38),      //“Deadliner”
        //        LabelledSegment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 27),      //“Introvert”
        //        ]
        
        pieChartView.segmentLabelFont = .systemFont(ofSize: 10)
        
        view.addSubview(pieChartView)
        
        simplePieChartView.frame = CGRect(
            x: 0, y: height + padding * 2,
            width: view.frame.size.width, height: height
        )
        
        simplePieChartView.segments = [
            Segment(color: .red,    value: 57),
            Segment(color: .blue,   value: 30),
            Segment(color: .green,  value: 25),
            Segment(color: .yellow, value: 40)
        ]
        view.addSubview(simplePieChartView)
    }
}


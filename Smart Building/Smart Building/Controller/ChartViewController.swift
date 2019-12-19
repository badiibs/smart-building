//
//  ChartViewController.swift
//  Smart Building
//
//  Created by admin on 19/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import ScrollableGraphView

class ChartViewController: UIViewController, ScrollableGraphViewDataSource {

    @IBOutlet weak var ourView: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var temperature = 0.0
    var arrPink = [9, 16, 22, 14, 20, 11, 23, 16, 25, 11]

    
    override func viewDidLoad() {
        super.viewDidLoad()
      var addValue = 0
      addValue = Int(temperature)
        print(addValue)
        arrPink.append(addValue)
      updatePinkGraph()
        temperatureLabel.text = "\(temperature) °C"
        
    }
    
    
    func updatePinkGraph() {
        //arrPink.append(Int(temperature))
        let graphView = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: ourView.frame.size.width, height: ourView.frame.size.height), dataSource: self)

           // Setup the second line plot.
           let orangeLinePlot = LinePlot(identifier: "orange")

           orangeLinePlot.lineWidth = 3
           orangeLinePlot.lineColor = #colorLiteral(red: 0.7492650747, green: 0.1955875754, blue: 0.3992423117, alpha: 1)
           orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth

           orangeLinePlot.shouldFill = true
           orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
           orangeLinePlot.fillColor = #colorLiteral(red: 0.7492650747, green: 0.1955875754, blue: 0.3992423117, alpha: 0.5)

           orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        

        let dotPlot = DotPlot(identifier: "darkLineDot") // Add dots as well.
        dotPlot.dataPointType = ScrollableGraphViewDataPointType.circle
        dotPlot.dataPointSize = 4
        dotPlot.dataPointFillColor = #colorLiteral(red: 0.7492650747, green: 0.1955875754, blue: 0.3992423117, alpha: 1)
        dotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
           graphView.backgroundFillColor =  #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
           self.view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)

           graphView.dataPointSpacing = 80
           graphView.shouldAnimateOnStartup = true
           graphView.shouldAdaptRange = true

           graphView.shouldRangeAlwaysStartAtZero = true
           
        

           let referenceLines = ReferenceLines()

              referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.clear
              referenceLines.referenceLineLabelColor = #colorLiteral(red: 0.7492650747, green: 0.1955875754, blue: 0.3992423117, alpha: 1)
        referenceLines.relativePositions = [0, 0.4, 0.5, 0.6,0.7, 0.8, 0.9, 1]

              referenceLines.dataPointLabelColor = #colorLiteral(red: 0.7492650747, green: 0.1955875754, blue: 0.3992423117, alpha: 1)//UIColor.white.withAlphaComponent(1)
              // Add everything to the graph.
              graphView.addReferenceLines(referenceLines: referenceLines)

            graphView.addPlot(plot: orangeLinePlot)

            graphView.addPlot(plot: dotPlot)
            ourView.addSubview(graphView)

    }

    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
               switch(plot.identifier) {
               case "orange": return Double(arrPink[pointIndex])
               case "darkLineDot": return Double(arrPink[pointIndex])
               
               default:
                   return 0
               }
           }
           
           func label(atIndex pointIndex: Int) -> String {
                return "\(pointIndex + 9) DEC "
           }
           
           func numberOfPoints() -> Int {
            var numberOfDataPointsInGraph = arrPink.count
               return numberOfDataPointsInGraph
           }
    

}

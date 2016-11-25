//
//  GrowthVC.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/25/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class GrowthVC: UIViewController {

  @IBOutlet weak var chartView: CombinedChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
      drawLineChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
  func drawLineChart() {
    chartView.noDataText = "You need to provide data for the chart."
    
    let values1 = DataCollection.getHeightGrowthData()
    
    let values2: [Double] = [5, 2, 6, 9, 3, 6, 4, 11, 14, 10, 13, 11]
    
    var dataEntries1: [ChartDataEntry] = []
    var dataEntries2: [BarChartDataEntry] = []
    
    var dataEntries3: [BarChartDataEntry] = []
    
    for i in 0..<values1.count {
      let dataEntry =   ChartDataEntry(x: Double(i) , y: values1[i])
      dataEntries1.append(dataEntry)
    }
    
    for i in 0..<values2.count {
      
      let dataEntry = BarChartDataEntry(x: Double(i), y: values2[i])
      
      dataEntries2.append(dataEntry)
    }
    // for curce
    
    let min = 22.0
    let max = 52.0
    
    let curveData = DataCollection.getHeightGrowthDataCurve(min: min, max: max)
    for i in 0..<curveData.count {
      let dataEntry = BarChartDataEntry(x: Double(i), y: curveData[i])
      dataEntries3.append(dataEntry)
    }
    
    
    
    let scatterChartDataSet = ScatterChartDataSet(values: dataEntries1, label: "Child height in cm")
    scatterChartDataSet.colors = [UIColor.purple]
    scatterChartDataSet.setScatterShape(.circle)
    
    
    let barChartDataSet = BarChartDataSet(values: dataEntries2, label: "???")
    barChartDataSet.colors = [UIColor.green]
    
    let curveLineDataSet = LineChartDataSet(values: dataEntries3, label: "Standard height curve in cm")
    
//    curveLineDataSet.drawCircleHoleEnabled = false
    curveLineDataSet.drawCirclesEnabled = false
    curveLineDataSet.highlightColor = UIColor.black
    curveLineDataSet.colors = [UIColor.black]
  curveLineDataSet.drawValuesEnabled = false
    
    let chartData = CombinedChartData()
//    chartData.barData = BarChartData(dataSet: barChartDataSet)
    chartData.lineData = LineChartData(dataSet: curveLineDataSet)
    chartData.scatterData = ScatterChartData(dataSets: [scatterChartDataSet])
    
    chartView.data = chartData
    
    chartView.drawOrder = [DrawOrder.line.rawValue, DrawOrder.scatter.rawValue]
    chartView.chartDescription?.text = ""
    
    chartView.backgroundColor = UIColor.white
    chartView.drawGridBackgroundEnabled = true
    chartView.gridBackgroundColor = UIColor.white
    
  }
}

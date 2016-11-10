//
//  CombinedChartVC.swift
//  GraphTest
//
//  Created by Neetin Sharma on 11/9/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class CombinedChartVC: UIViewController {

  @IBOutlet weak var chartView: CombinedChartView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      drawLineChart(DataValues.months)
  }
  
  func drawLineChart(_ dataPoints: [String]) {
    chartView.noDataText = "You need to provide data for the chart."
    
    let values1: [Double] = [4, 3, 5, 6, 2, 7, 8, 10, 12, 12, 11, 15]
    let values2: [Double] = [5, 2, 6, 9, 3, 6, 4, 11, 14, 10, 13, 11]
    
    var dataEntries1: [ChartDataEntry] = []
    var dataEntries2: [BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry =   ChartDataEntry(x: Double(i) , y: values1[i])
      dataEntries1.append(dataEntry)
    }
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(x: Double(i), y: values2[i])
      
      dataEntries2.append(dataEntry)
    }
    
    let lineChartDataSet = LineChartDataSet(values: dataEntries1, label: "Company 1")
    
    lineChartDataSet.colors = [UIColor.red]
    
    let barChartDataSet = BarChartDataSet(values: dataEntries2, label: "Company 2")
    barChartDataSet.colors = [UIColor.green]
  
    
    let chartData = CombinedChartData()
    chartData.barData = BarChartData(dataSet: barChartDataSet)
    chartData.lineData = LineChartData(dataSet: lineChartDataSet)
    
    chartView.data = chartData
    
    
    chartView.drawOrder = [DrawOrder.bar.rawValue, DrawOrder.line.rawValue]
    chartView.chartDescription?.text = ""
    
    chartView.backgroundColor = UIColor.gray
    chartView.drawGridBackgroundEnabled = true
    chartView.gridBackgroundColor = UIColor.yellow
    
  }
}

//
//  DesatVC.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/21/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class DesatVC: UIViewController, ChartViewDelegate {

  let dayColor = UIColor(colorLiteralRed: 180/255, green: 154/255, blue: 224/255, alpha: 0.6)//UIColor(hex: "cbebf7")
  let nightColor = UIColor(colorLiteralRed: 59/255, green: 178/255, blue: 226/255, alpha: 0.6)//UIColor(hex: "dcccf1")
  let lineColor = UIColor(colorLiteralRed: 14/255, green: 145/255, blue: 200/255, alpha: 1)//UIColor(hex: "28a9df")
//    let borderColor = UIColor(colorLiteralRed: 174/255, green: 204/255, blue: 243/255, alpha: 1)
  let chartBackgroundColor = UIColor(colorLiteralRed: 238/255, green: 238/255, blue: 238/255, alpha: 0.4)
  
  @IBOutlet weak var chartView: CombinedChartView!
  weak var valueFormatter: IAxisValueFormatter!
  weak var customValueFormatter: IValueFormatter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    chartView.delegate = self
    valueFormatter = self
    customValueFormatter = self
    drawLineChart(DataCollection.desaturationLabels)
  }
  
  func drawLineChart(_ dataPoints: [String]) {
    chartView.noDataText = "You need to provide data for the chart."
    chartView.enableCustomXEntries = true
    let values: [Double] = DataCollection.getDesaturationEpisodes()
    
    var dataEntries1: [CandleChartDataEntry] = []
    var dataEntries2: [ChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
        let dataEntry = CandleChartDataEntry(x: Double(i), shadowH: values[i], shadowL: values[i], open: values[i] - 4, close: values[i] + 4)
        dataEntry.y = values[i]
        dataEntries1.append(dataEntry)
    }
    
    for i in 0..<dataPoints.count {
        let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
        dataEntries2.append(dataEntry)
    }
    
    let candleChartDataSet = CandleChartDataSet(values: dataEntries1, label: "Company 1")
    
    candleChartDataSet.colors = [dayColor, nightColor]
    candleChartDataSet.shadowColor = UIColor.clear
//        candleChartDataSet.shadowColorSameAsCandle = true
    candleChartDataSet.drawValuesEnabled = false
    candleChartDataSet.highlightEnabled = false
    candleChartDataSet.setFill = true
    
    let lineChartDataSet = LineChartDataSet(values: dataEntries2, label: "Company 2")
    lineChartDataSet.colors = [lineColor]
    lineChartDataSet.circleHoleRadius = 0
    lineChartDataSet.circleColors = [lineColor]
    lineChartDataSet.circleRadius = 4
    lineChartDataSet.highlightEnabled = false
    lineChartDataSet.valueFormatter = customValueFormatter
    lineChartDataSet.valueColors = [UIColor.white]
    lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 16)
    lineChartDataSet.lineWidth = 4
    
    let rightYAxis = chartView.getAxis(.right)
    rightYAxis.axisMaximum = 30 // based on the desaturation values
    rightYAxis.axisMinimum = 0
    rightYAxis.granularityEnabled = true
    rightYAxis.granularity = 10
    
    let leftYAxis = chartView.getAxis(.left)
    leftYAxis.axisMaximum = 30 // based on the desaturation values
    leftYAxis.axisMinimum = 0
    leftYAxis.granularityEnabled = true
    leftYAxis.granularity = 10
    
    let xAxis = chartView.xAxis
    xAxis.valueFormatter = valueFormatter
    xAxis.labelPosition = .bottom
    
    xAxis.spaceMin = 0.5
    xAxis.spaceMax = 0.5
    
//        xAxis.axisMinimum = -0.5 // Fixes for candlestick
//        xAxis.axisMaximum = 13.5 // Fixes for candlestick
//        xAxis.forceLabelsEnabled = true
//        xAxis.centerAxisLabelsEnabled = true
//        xAxis.entries = [1.5, 3.5, 5.5, 7.5, 9.5, 11.5]
    //        xAxis.entries = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
    
    let chartData = CombinedChartData()
    chartData.candleData = CandleChartData(dataSet: candleChartDataSet)
    chartData.lineData = LineChartData(dataSet: lineChartDataSet)
    chartView.data = chartData
//        chartView.drawBordersEnabled = true
//        chartView.borderColor = borderColor
    
    chartView.drawOrder = [DrawOrder.candle.rawValue, DrawOrder.line.rawValue]
    chartView.chartDescription?.text = ""
    
    // unnecessary gesture
    chartView.scaleXEnabled = false
    chartView.scaleYEnabled = false
//        chartView.highlightPerTapEnabled = false
//        chartView.highlightFullBarEnabled = false
    chartView.legend.enabled = false
    chartView.backgroundColor = chartBackgroundColor
  }
  
  func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    print(entry)
  }
}

extension DesatVC: IAxisValueFormatter {
  
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    return DataCollection.desaturationLabels[Int(value)]
  }
  
}

extension DesatVC: IValueFormatter {
  
  func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    return String.localizedStringWithFormat("%.0f", entry.y)
  }
  
}

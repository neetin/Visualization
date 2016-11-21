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

    @IBOutlet weak var chartView: CombinedChartView!
    weak var valueFormatter: IAxisValueFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self
        valueFormatter = self
        drawLineChart(DataCollection.desaturationLabels)
    }
    
    func drawLineChart(_ dataPoints: [String]) {
        chartView.noDataText = "You need to provide data for the chart."
        
        let values: [Double] = DataCollection.getDesaturationEpisodes()
        
        var dataEntries1: [CandleChartDataEntry] = []
        var dataEntries2: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = CandleChartDataEntry(x: Double(i), shadowH: values[i], shadowL: values[i], open: values[i] - 2, close: values[i] + 2)
            dataEntry.y = values[i]
            dataEntries1.append(dataEntry)
        }
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries2.append(dataEntry)
        }
        
        let candleChartDataSet = CandleChartDataSet(values: dataEntries1, label: "Company 1")
        candleChartDataSet.colors = [UIColor.red, UIColor.green]
        candleChartDataSet.shadowColor = UIColor.white
        candleChartDataSet.drawValuesEnabled = false
        candleChartDataSet.highlightEnabled = false
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries2, label: "Company 2")
        lineChartDataSet.colors = [UIColor.green]
        lineChartDataSet.circleHoleRadius = 0
        lineChartDataSet.highlightEnabled = false
        
        let rightYAxis = chartView.getAxis(.right)
        rightYAxis.axisMaximum = 25 // based on the desaturation values
        rightYAxis.axisMinimum = 0
        
        let leftYAxis = chartView.getAxis(.left)
        leftYAxis.axisMaximum = 25 // based on the desaturation values
        leftYAxis.axisMinimum = 0
        
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = valueFormatter
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = -0.5 // Fixes for candlestick
        xAxis.axisMaximum = 13.5 // Fixes for candlestick
//        xAxis.forceLabelsEnabled = true
//        xAxis.centerAxisLabelsEnabled = true
        xAxis.entries = [1.5, 3.5, 5.5, 7.5, 9.5, 11.5]
        //        xAxis.entries = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
        
        let chartData = CombinedChartData()
        chartData.candleData = CandleChartData(dataSet: candleChartDataSet)
        chartData.lineData = LineChartData(dataSet: lineChartDataSet)
        chartView.data = chartData
        
        chartView.drawOrder = [DrawOrder.line.rawValue, DrawOrder.candle.rawValue]
        chartView.chartDescription?.text = ""
        
        // unnecessary gesture
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
//        chartView.highlightPerTapEnabled = false
//        chartView.highlightFullBarEnabled = false
        chartView.legend.enabled = false
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

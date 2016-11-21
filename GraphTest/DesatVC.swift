//
//  DesatVC.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/21/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class DesatVC: UIViewController {

    @IBOutlet weak var chartView: CombinedChartView!
    weak var valueFormatter: IAxisValueFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        candleChartDataSet.colors = [UIColor.red]
        candleChartDataSet.shadowColor = UIColor.white
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries2, label: "Company 2")
        lineChartDataSet.colors = [UIColor.green]
        
        let chartData = CombinedChartData()
        chartData.candleData = CandleChartData(dataSet: candleChartDataSet)
        chartData.lineData = LineChartData(dataSet: lineChartDataSet)
        chartView.data = chartData
        
        chartView.drawOrder = [DrawOrder.line.rawValue, DrawOrder.candle.rawValue]
        chartView.chartDescription?.text = ""
        
        let rightYAxis = chartView.getAxis(.right)
        rightYAxis.axisMaximum = 21
        rightYAxis.axisMinimum = 0
        
        let leftYAxis = chartView.getAxis(.left)
        leftYAxis.axisMaximum = 21
        leftYAxis.axisMinimum = 0
        
        chartView.xAxis.axisMinimum = -0.5
        chartView.xAxis.axisMaximum = 12
        
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = valueFormatter
        xAxis.drawLabelsEnabled = true
        xAxis.axisMinimum = -0.5
        xAxis.axisMaximum = 12
//        xAxis.entries = [1.5, 3.5, 5.5, 7.5, 9.5, 11.5]
    }
}

extension DesatVC: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return DataCollection.desaturationLabels(Int(value))
    }
}

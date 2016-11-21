//
//  CandleChartVC.swift
//  GraphTest
//
//  Created by Sujan Vaidya on 11/11/16.
//  Copyright © 2016 3 Callistos. All rights reserved.
//

import UIKit
import Charts

class CandleChartVC: UIViewController {
    @IBOutlet var chartView: CandleStickChartView!

    weak var valueFormatter: IAxisValueFormatter!
    override func viewDidLoad() {
        super.viewDidLoad()
        valueFormatter = self
        addCandleChart(dataPoints: DataValues.months, values: DataValues.unitSold)
    }

    func addCandleChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "There is no data available at this moment."
        
        var dataEntries: [CandleChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = CandleChartDataEntry(x: Double(i), shadowH: values[i], shadowL: values[i], open: values[i] - 2, close: values[i] + 2)
            dataEntry.y = values[i]
            dataEntries.append(dataEntry)
        }
        let candleChartDataSet = CandleChartDataSet(values: dataEntries, label: "Company 2")
        candleChartDataSet.colors = [UIColor.red, UIColor.green]
        
        chartView.data = CandleChartData(dataSet: candleChartDataSet)
    
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = valueFormatter
//        xAxis.granularityEnabled = true
//        xAxis.granularity = 0
//        xAxis.labelPosition = .topInside
        
        chartView.chartDescription?.text = ""
    }
}

extension CandleChartVC: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return DataValues.months[Int(value)]
    }
}

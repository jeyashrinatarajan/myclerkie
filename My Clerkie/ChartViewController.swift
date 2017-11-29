//
//  ChartViewController.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/19/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit
import SwiftCharts


class ChartViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    @IBOutlet var chartCollectionView: UICollectionView!
    fileprivate var vchart: Chart?
    fileprivate var hchart: Chart?
    fileprivate var slchart: Chart?
    fileprivate var dlchart: Chart?
    var vbarChartView = UIView()
    var hbarChartView = UIView()
    var singlelineChartView = UIView()
    var duolineChartView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Vertical bar chart config
        let vbarchartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 1000, by: 250)
        )
        
        let vbarchartframe = CGRect(x: 0, y: 50, width: 366, height: 366)
        let vchart = BarsChart(
            frame: vbarchartframe,
            chartConfig: vbarchartConfig,
            xTitle: "Month",
            yTitle: "Amount Saved",
            bars: [
                ("Jan", 200),
                ("Feb", 400),
                ("Mar", 300),
                ("Apr", 450),
                ("May", 150),
                ("June", 200),
                ("July", 350)
            ],
            color: UIColor(red:3/255.0, green:188/255.0, blue:229/255.0, alpha:1.0),
            barWidth: 20
        )
        vbarChartView = vchart.view
       self.vchart = vchart
        
        //Horizontal bar chart config
        let hbarchartConfig = BarsChartConfig(
            valsAxisConfig: ChartAxisConfig(from: 0, to: 1200, by: 200)
        )
        
        let hbarchartframe = CGRect(x: 0, y: 50, width: 366, height: 350)
        let hchart = BarsChart(
            frame: hbarchartframe,
            chartConfig: hbarchartConfig,
            xTitle: "Amount Spent ($)",
            yTitle: "Item",
            bars: [
                ("Rent", 1000),
                ("Utility", 300),
                ("Food", 350),
                ("Gas", 100),
                ("Misc.", 100)
            ],
            color: UIColor.orange,
            barWidth: 20,
            horizontal : true
        )
        hbarChartView = hchart.view
        self.hchart = hchart
        
        
        //single line chart config
        let slinechartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 12, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 12, by: 2)
        )
        
        let slinechartframe = CGRect(x: 0, y: 50, width: 350, height: 350)
        
        let slchart = LineChart(
            frame: slinechartframe,
            chartConfig: slinechartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(4.0, 12.6), (5.2, 8), (9.3, 5.0), (9.1, 5.0), (16.0, 8.0)], color: UIColor.brown)
                
            ]
        )
        
        singlelineChartView = slchart.view
        self.slchart = slchart
        
        //duo line chart config
        let dlinechartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 2, to: 12, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 12, by: 2)
        )
        
        let dlinechartframe = CGRect(x: 0, y: 50, width: 350, height: 350)
        
        let dlchart = LineChart(
            frame: dlinechartframe,
            chartConfig: dlinechartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        
        duolineChartView = dlchart.view
        self.dlchart = dlchart

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var chartViews = [vbarChartView,hbarChartView,singlelineChartView,duolineChartView]
     var chartTitle = ["Monthly savings","Monthly expenditure","Single Line chart","Duo Line Chart"]
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath as IndexPath) as! ChartViewCell
        cell.addSubview(chartViews[indexPath.row])
        cell.chartTitleLabel.text = chartTitle[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

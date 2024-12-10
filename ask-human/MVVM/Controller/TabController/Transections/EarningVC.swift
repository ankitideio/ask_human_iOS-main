//
//  EarningVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 11/01/24.
//

import UIKit
import Charts
import ChartProgressBar



class EarningVC: UIViewController {
    //MARK: - OUTLETS
    @IBOutlet var lblScreenTtile: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var viewTotaContract: UIView!
    @IBOutlet var viewTotalEarn: UIView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var viewFilter: UIView!
    @IBOutlet var lblTitleTotalCpntract: UILabel!
    @IBOutlet var lblTitleTotalEarning: UILabel!
    @IBOutlet var imgVwFilter: UIImageView!
    @IBOutlet var lblFilter: UILabel!
    @IBOutlet var lblTitleWalletbalance: UILabel!
    @IBOutlet weak var lblTotalContract: UILabel!
    @IBOutlet weak var lblWeekAmount: UILabel!
    @IBOutlet weak var lblTotoalEarning: UILabel!
    @IBOutlet var lblWeekDate: UILabel!
    @IBOutlet var viewShadowChart: UIView!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet var lblBalanceAmount: UILabel!
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var viewWithraw: UIView!
    @IBOutlet weak var btnRight: UIButton!
    
    //MARK: - VARIABLES
    
    var yearlyData: [Double] = []
    var monthlyData: [Double] = []
    var weeklyData: [Double] = []
    var yearName = [String]()
    var monthName = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var weekName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var currentWeekStartDate: Date = Date()
    var calendar = Calendar.current
    var selectType = "Week"
    var totoalEarning = 0
    var viewModel = EarningVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            
        }
    }
    
    func uiSet(){
        
        chartView.isUserInteractionEnabled = false
        viewWithraw.layer.shadowColor = UIColor.black.cgColor
        viewWithraw.layer.shadowOpacity = 0.15
        viewWithraw.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewWithraw.layer.shadowRadius = 14
        viewWithraw.layer.masksToBounds = false
        viewShadowChart.layer.shadowColor = UIColor.black.cgColor
        viewShadowChart.layer.shadowOpacity = 0.15
        viewShadowChart.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewShadowChart.layer.shadowRadius = 14
        viewShadowChart.layer.masksToBounds = false
        updateLabel()
        
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            viewTotalEarn.backgroundColor = UIColor(hex: "#161616")
            viewTotaContract.backgroundColor = UIColor(hex: "#161616")
            viewWithraw.backgroundColor = UIColor(hex: "#161616")
            viewShadowChart.backgroundColor = UIColor(hex: "#161616")
            let labels = [
                lblTitleWalletbalance, lblBalanceAmount, lblTitleTotalEarning, lblTitleTotalCpntract,
                lblWeekAmount, lblWeekDate, lblTotoalEarning, lblFilter, lblScreenTtile
            ]

            for label in labels {
                label?.textColor = .white
            }
            viewFilter.borderWid = 0
            viewFilter.borderCol = .clear
            viewFilter.backgroundColor = UIColor(hex: "#EE0B80")
            imgVwFilter.image = UIImage(named: "filterWhite")
        }else{
            lblScreenTtile.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
            imgVwFilter.image = UIImage(named: "filter")
            lblFilter.textColor = UIColor(hex: "#878787")
            viewFilter.borderWid = 1
            viewFilter.borderCol = UIColor(hex: "#EEEEEE")
            viewFilter.backgroundColor = .clear
            viewTotalEarn.backgroundColor = .clear
            viewTotaContract.backgroundColor = .clear
            viewWithraw.backgroundColor = .white
            viewShadowChart.backgroundColor = .white
            lblTitleWalletbalance.textColor = UIColor(hex: "#878787")
            lblBalanceAmount.textColor = .black
            lblTitleTotalEarning.textColor = UIColor(hex: "#878787")
            lblTitleTotalCpntract.textColor = UIColor(hex: "#878787")
            lblWeekAmount.textColor = .black
            lblWeekDate.textColor = UIColor(hex: "#878787")
            lblTotoalEarning.textColor = .black
        }
    }
    func updateLabel() {
        calendar.firstWeekday = 1
        let startDate = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeekStartDate))!
        let endDate = calendar.date(byAdding: .day, value: 6, to: startDate)!
        let todayDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yyyy"
        let date = dateFormatter.date(from: dateFormatter.string(from: todayDate)) ?? Date()
        if let date1 = dateFormatter.date(from: dateFormatter.string(from: startDate)),
           let date2 = dateFormatter.date(from: dateFormatter.string(from: endDate)) {
            if date >= date1{
                dateFormatter.dateFormat = "yyyy-M-dd"
                let formattedDate1 = dateFormatter.string(from: date1)
                let formattedDate2 = dateFormatter.string(from: date2)
                print("StartDate",formattedDate1,"EndDate",formattedDate2)
                getEarningApi(startData: formattedDate1, endDate: formattedDate2)
                let dateFormatters = DateFormatter()
                dateFormatters.dateFormat = "MMM d"
                
                let weekLabelText = "\(dateFormatters.string(from: startDate)) - \(dateFormatters.string(from: endDate))"
                lblWeekDate.text = weekLabelText
            }else{
                showSwiftyAlert("", "Don't show next week", false)
            }
            
        } else {
            print("Error converting date strings to Date objects.")
        }
        
        
        
    }
    func getCurrentWeekStartEndDate() -> (startDate: Date, endDate: Date) {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday
        
        var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)
        components.weekday = calendar.firstWeekday
        
        let startDate = calendar.date(from: components)!
        
        let endDate = calendar.date(byAdding: .day, value: 6, to: startDate)!
        
        return (startDate, endDate)
    }
    
    func getCurrentYearStartEndDate() -> (startDate: Date, endDate: Date) {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday
        
        let components = calendar.dateComponents([.year], from: currentDate)
        let startOfYear = calendar.date(from: components)!
        
        let endOfYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startOfYear)!
        
        return (startOfYear, endOfYear)
    }
    func getEarningApi(startData:String,endDate:String){
        viewModel.getEarningApi(startDate: startData, endDate: endDate, showLoader: true) { data in
            if data?.totalEarnings ?? 0 > 0{
                self.chartView.leftAxis.drawLabelsEnabled = true
                self.chartView.legend.enabled = true
                
            }else{
                self.chartView.leftAxis.drawLabelsEnabled = false
                self.chartView.legend.enabled = false
            }
            self.lblBalanceAmount.text = "$\(data?.walletBalance ?? 0)"
            self.lblWeekAmount.text = "$\(data?.ammountperWeek ?? 0)"
            self.lblTotoalEarning.text = "$\(data?.totalEarnings ?? 0)"
            self.lblTotalContract.text = "\(data?.totalContact ?? 0)"
            self.totoalEarning = data?.walletBalance ?? 0
            self.monthlyData.removeAll()
            self.yearlyData.removeAll()
            self.weeklyData.removeAll()
            self.yearName.removeAll()
            for i in data?.getMonthYear ?? []{
                self.yearName.append("\(i.year ?? 0)")
                self.yearlyData.append(Double(i.totalAmount ?? 0))
            }
            for i in data?.monthGraph ?? []{
                self.monthlyData.append(Double(i.totalAmount ?? 0))
            }
            if data?.weekGraph?.count ?? 0 > 0{
                for i in data?.weekGraph ?? []{
                    self.weeklyData.append(Double(i.totalAmount ?? 0))
                }
            }else{
                self.weeklyData = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            }
            self.chartSetup()
            self.handleFilterSelection(2)
            
        }
    }
    
    func chartSetup(){
        
        setChart(dataPoints: monthName, values: monthlyData)
        
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.chartDescription.text = ""
        chartView.fitBars = true
        chartView.xAxis.centerAxisLabelsEnabled = false
        
    }
    
    //MARK: - BUTTON ACTIONS
    @IBAction func actionPreviousWeek(_ sender: UIButton) {
        currentWeekStartDate = calendar.date(byAdding: .weekOfYear, value: -1, to: currentWeekStartDate)!
        updateLabel()
        
    }
    @IBAction func actionNextWeek(_ sender: UIButton) {
        
        currentWeekStartDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentWeekStartDate)!
        updateLabel()
        
    }
    
    
    @IBAction func acionFilter(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePopUpsVC") as! ProfilePopUpsVC
        vc.isSelect = 7
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 130, height: 113)
        let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
        popOver.sourceView = sender
        popOver.delegate = self
        popOver.permittedArrowDirections = .up
        vc.callBack = { (index,title,selecIndex) in
            self.handleFilterSelection(index)
            print("index:-\(index)")
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func handleFilterSelection(_ index: Int) {
        print(self.yearName)
        switch index {
        case 0:
            setChart(dataPoints: monthName, values: monthlyData)
            chartView.xAxis.centerAxisLabelsEnabled = false
            lblWeekDate.isHidden = true
            btnLeft.isHidden = true
            btnRight.isHidden = true
        case 1:
            
            setChart(dataPoints: yearName, values: yearlyData)
            chartView.xAxis.centerAxisLabelsEnabled = false
            lblWeekDate.isHidden = true
            btnLeft.isHidden = true
            btnRight.isHidden = true
        case 2:
            setChart(dataPoints: weekName, values: weeklyData)
            chartView.xAxis.centerAxisLabelsEnabled = false
            lblWeekDate.isHidden = false
            btnLeft.isHidden = false
            btnRight.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func actionWithraw(_ sender: GradientButton) {
        if totoalEarning != 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawAmountVC") as! WithdrawAmountVC
            vc.isComing = false
            vc.totalAmount = self.totoalEarning
            vc.callBack = { amount in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawPopUpVC") as! WithdrawPopUpVC
                vc.callBack = {
                    self.updateLabel()
                }
                vc.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(vc, animated: true)
            }
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: true)
        }else{
            showSwiftyAlert("","Sorry!! You have insufficient balance.", false)
        }
        
    }
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().tabBarProfileVCRoot()
    }
    
    //MARK: - CHART SETUP
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        guard values.count == dataPoints.count else {
            print("Error: The values array does not match the dataPoints array.")
            return
        }
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries,label: "")
        chartDataSet.colors = [NSUIColor.app]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartView.data = chartData
        
        let rightYAxis = chartView.rightAxis
        rightYAxis.enabled = false
        
        let cxAxis = chartView.xAxis
        cxAxis.drawGridLinesEnabled = false
        
        let leftYAxis = chartView.leftAxis
        leftYAxis.drawGridLinesEnabled = false
        
        leftYAxis.axisMinimum = 0.0
        
        chartDataSet.drawValuesEnabled = false
        
        chartView.legend.enabled = false
        
        self.chartView.data = chartData
        
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        xAxis.labelCount = dataPoints.count
        xAxis.centerAxisLabelsEnabled = true
        
        
    }
    
}

// MARK: - Popup
extension EarningVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}

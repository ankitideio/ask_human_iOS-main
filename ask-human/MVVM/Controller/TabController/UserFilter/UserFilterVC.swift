//
//  UserFilterVC.swift
//  ask-human
//
//  Created by meet sharma on 21/11/23.
//

import UIKit

struct FilterOption {
    var title: String
    var options: [String]
}
struct FilterData {
    var title: String
    var selectOption: [String]
}
class UserFilterVC: UIViewController {
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet weak var btnClear: UIButton!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tblVwFilter: UITableView!
    
    
    //MARK: - VARIABLE
    
    var availabilityData: [[String: Any]] = [
        ["data": [["id": "0", "value": "Male"], ["id": "1", "value": "Female"], ["id": "2", "value": "Others"]], "title": "Gender"],
        ["data": [["id": "3", "value": "White"], ["id": "4", "value": "Black"], ["id": "5", "value": "Asian"], ["id": "6", "value": "Indian"], ["id": "7", "value": "Hispanic"], ["id": "8", "value": "Middle Eastern"], ["id": "9", "value": "Other"]], "title": "Ethnicity"],
        ["data": [["id": "10", "value": "Jawan"], ["id": "11", "value": "Munawwar Rangila"], ["id": "12", "value": "Salsabilla"], ["id": "13", "value": "Now Entertainment"]], "title": "Zodiac"],
        ["data": [["id": "14", "value": ""]], "title": "Age"],
        ["data": [["id": "15", "value": "No"], ["id": "16", "value": "Occasionally"], ["id": "17", "value": "Regularly"]], "title": "Smoking"],
        ["data": [["id": "18", "value": "No"], ["id": "19", "value": "Socially"], ["id": "20", "value": "Regularly"]], "title": "Drinking"],
        ["data": [["id": "21", "value": "Yoga"], ["id": "22", "value": "Long Walk"], ["id": "23", "value": "Boxing"], ["id": "24", "value": "Strength"]], "title": "Workout"],
        ["data": [["id": "25", "value": "Slim"], ["id": "26", "value": "Fit"], ["id": "27", "value": "Muscular"], ["id": "28", "value": "Average"], ["id": "29", "value": "Curvy"]], "title": "BodyType"],
    ]

    var callBack:((_ selectedOption:String?)->())?
    var selectedOptions: [String] = []
    var sliderValueChanged: ((Float, Float) -> Void)?
    var selectedIndexPaths: [IndexPath] = []
    var selectGender = ""
    var Ethnicity = ""
    
    var arrGender = [String]()
    var arrEthnicity = [String]()
    var arrZodiac = [String]()
    var arrSmoking = [String]()
    var arrDrinking = [String]()
    var arrWorkout = [String]()
    var arrBodyType = [String]()
    var minValue = ""
    var maxValue = ""
    var arrData = [String]()
    var callBackFilter:(()->())?
    
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
        tblVwFilter.showsVerticalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwFilter.reloadData()
        }
    }
    
    func darkMode(){
        
        if traitCollection.userInterfaceStyle == .dark {
            lblScreenTitle.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
            btnClear.backgroundColor = .white
            btnClear.setTitleColor(.black, for: .normal)
            tblVwFilter.backgroundColor = UIColor(hex: "#161616")
        }else{
            tblVwFilter.backgroundColor = .white
            btnClear.backgroundColor = .black
            btnClear.setTitleColor(.white, for: .normal)
            lblScreenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
    }
    func uiSet(){
        
        let tableViewHeight = calculateTableViewHeight()
        preferredContentSize = CGSize(width: view.frame.width - 50, height: tableViewHeight)
        
        
        arrGender.append(contentsOf: Store.filterDetail?["Gender"] ?? [])
        arrEthnicity.append(contentsOf: Store.filterDetail?["Ethnicity"] ?? [])
        arrZodiac.append(contentsOf: Store.filterDetail?["Zodiac"] ?? [])
        arrSmoking.append(contentsOf: Store.filterDetail?["Smoking"] ?? [])
        arrDrinking.append(contentsOf: Store.filterDetail?["Drinking"] ?? [])
        arrBodyType.append(contentsOf: Store.filterDetail?["BodyType"] ?? [])
        arrWorkout.append(contentsOf: Store.filterDetail?["Workout"] ?? [])
        
        arrData.append(contentsOf: Store.filterDetail?["Ethnicity"] ?? [])
        arrData.append(contentsOf: Store.filterDetail?["Zodiac"] ?? [])
        arrData.append(contentsOf: Store.filterDetail?["Smoking"] ?? [])
        arrData.append(contentsOf: Store.filterDetail?["Drinking"] ?? [])
        arrData.append(contentsOf: Store.filterDetail?["BodyType"] ?? [])
        arrData.append(contentsOf: Store.filterDetail?["Workout"] ?? [])
        if Store.filterDetail?["Gender"]?.contains("0") == true{
            arrData.append("Male")
        }
        if Store.filterDetail?["Gender"]?.contains("1") == true{
            arrData.append("Female")
        }
        if Store.filterDetail?["Gender"]?.contains("2") == true{
            arrData.append("Others")
        }
        print(arrData)
        if Store.isFilterAge == true{
            btnClear.setTitle("Clear(\(arrData.count+1))", for: .normal)
        }else{
            btnClear.setTitle("Clear(\(arrData.count))", for: .normal)
        }
        Store.selectFilter = availabilityData
        minValue = Store.filterAgeSelect?["minAge"] as? String ?? "18"
        maxValue = Store.filterAgeSelect?["maxAge"] as? String ?? "72"
        self.tblVwFilter.reloadData()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: -BUTTON ACTIONS
    @IBAction func actionClear(_ sender: UIButton) {
        self.arrGender.removeAll()
        self.arrEthnicity.removeAll()
        self.arrZodiac.removeAll()
        self.arrSmoking.removeAll()
        self.arrDrinking.removeAll()
        self.arrWorkout.removeAll()
        self.arrBodyType.removeAll()
        self.minValue = ""
        self.maxValue = ""
        self.arrData.removeAll()
        Store.isFilterAge = false
        Store.filterDetail = ["Gender":arrGender,"Ethnicity":arrEthnicity,"Zodiac":arrZodiac,"Smoking":arrSmoking,"Drinking":arrDrinking,"Workout":arrWorkout,"BodyType":arrBodyType]
        Store.filterAgeSelect = ["minAge":minValue,"maxAge":maxValue]
        callBackFilter?()
               self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func actionShow(_ sender: GradientButton) {
        Store.filterDetail = ["Gender":arrGender,"Ethnicity":arrEthnicity,"Zodiac":arrZodiac,"Smoking":arrSmoking,"Drinking":arrDrinking,"Workout":arrWorkout,"BodyType":arrBodyType]
        Store.filterAgeSelect = ["minAge":minValue,"maxAge":maxValue]
        
        print(Store.filterAgeSelect ?? "")
        
        self.navigationController?.popViewController(animated: true)
        callBackFilter?()
        
        
//        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//        let nextVC = mainStoryBoard.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
//        nextVC.isComing = true
//        let nav = UINavigationController.init(rootViewController: nextVC)
//        nav.isNavigationBarHidden = true
//        UIApplication.shared.windows.first?.rootViewController = nav
        
    }
    
    
}



//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension UserFilterVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Number of sections: \(Store.selectFilter?.count ?? 0)")
        return Store.selectFilter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3{
            return 80
        }else{
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 27
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSecionTVC") as! FilterSecionTVC
        let sectionData = Store.selectFilter?[section]
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblSectionName.textColor = .white
            cell.contentView.backgroundColor = UIColor(hex: "#161616")
        }else{
            cell.contentView.backgroundColor = .white
            cell.lblSectionName.textColor = .black
        }
        cell.lblSectionName.text = sectionData?["title"] as? String ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = Store.selectFilter?[section]
        let data = sectionData?["data"] as? [[String: String]] ?? []
        print("Number of rows in section \(section): \(data.count)")
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFilterTVC", for: indexPath) as! UserFilterTVC
        let sectionData = Store.selectFilter?[indexPath.section]
        let data = sectionData?["data"] as? [[String: String]] ?? []
        
        if traitCollection.userInterfaceStyle == .dark {
            cell.contentView.backgroundColor = UIColor(hex: "#161616")
        } else {
            cell.contentView.backgroundColor = .white
        }
        
        cell.uiSet()
        
        let minAgeString = minValue
        let maxAgeString = maxValue
        
        if let minAge = Double(minAgeString), let maxAge = Double(maxAgeString) {
            cell.slider.lowerValue = minAge
            cell.slider.upperValue = maxAge
        } else {
            cell.slider.upperValue = 72.0
            cell.slider.lowerValue = 18.0
        }
        
        cell.callBack = { (minValue, maxValue) in
            self.minValue = "\(minValue)"
            self.maxValue = "\(maxValue)"
            self.btnClear.setTitle("Clear(\(self.arrData.count+1))", for: .normal)
        }
        
        let item = data[indexPath.row]
        let value = item["value"] ?? ""
        let id = item["id"] ?? ""
        
        
        
        cell.lblName.text = value
        
        if traitCollection.userInterfaceStyle == .dark {
            cell.lblName.textColor = .white
            cell.lblMin.textColor = .white
            cell.lblMax.textColor = .white
        } else {
            cell.lblMin.textColor = UIColor(hex: "#545454")
            cell.lblMax.textColor = UIColor(hex: "#545454")
            cell.lblName.textColor = UIColor(hex: "#545454")
        }
        
        if sectionData?["title"] as? String == "Age" {
            cell.slider.isHidden = false
            cell.lblMin.isHidden = false
            cell.lblMax.isHidden = false
            cell.btnSelectUnselect.isHidden = true
        } else {
            cell.btnSelectUnselect.isHidden = false
            cell.slider.isHidden = true
            cell.lblMin.isHidden = true
            cell.lblMax.isHidden = true
        }
        
        cell.btnSelectUnselect.setImage(arrGender.contains(id) || arrEthnicity.contains(id) || arrZodiac.contains(id) || arrSmoking.contains(id) || arrDrinking.contains(id) || arrWorkout.contains(id) || arrBodyType.contains(id) ? UIImage(named: "tick") : UIImage(named: "unTick"), for: .normal)
        cell.btnSelectUnselect.tag = indexPath.row
        cell.btnSelectUnselect.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
        
        return cell
    }
    @objc func selectCategory(sender: UIButton) {
        guard let indexPath = tblVwFilter.indexPathForRow(at: sender.convert(CGPoint.zero, to: tblVwFilter)) else { return }
        
        let sectionData = Store.selectFilter?[indexPath.section]
        let data = sectionData?["data"] as? [[String: String]] ?? []
        let item = data[indexPath.row]
        let value = item["value"] ?? ""
        let id = item["id"] ?? ""
        
        switch sectionData?["title"] as? String {
        case "Gender":
            toggleSelection(&arrGender, id: id, value: value)
        case "Ethnicity":
            toggleSelection(&arrEthnicity, id: id, value: value)
        case "Zodiac":
            toggleSelection(&arrZodiac, id: id, value: value)
        case "Smoking":
            toggleSelection(&arrSmoking, id: id, value: value)
        case "Drinking":
            toggleSelection(&arrDrinking, id: id, value: value)
        case "Workout":
            toggleSelection(&arrWorkout, id: id, value: value)
        case "BodyType":
            toggleSelection(&arrBodyType, id: id, value: value)
        default:
            break
        }
        
        // Update the filter detail and clear button title
        updateFilterDetails()
        tblVwFilter.reloadData()
    }

    private func toggleSelection(_ array: inout [String], id: String, value: String) {
        if array.contains(id) {
            array.removeAll { $0 == id }
        } else {
            array.append(id)
        }
    }

    private func updateFilterDetails() {
        arrData = arrGender + arrEthnicity + arrZodiac + arrSmoking + arrDrinking + arrWorkout + arrBodyType
        if Store.isFilterAge {
            btnClear.setTitle("Clear(\(arrData.count + 1))", for: .normal)
        } else {
            btnClear.setTitle("Clear(\(arrData.count))", for: .normal)
        }
    }

   
}


extension UserFilterVC {
    private func calculateTableViewHeight() -> CGFloat {
        var totalHeight: CGFloat = 0
        
        for section in 0..<(Store.selectFilter?.count ?? 0) {
            let numberOfRows = tableView(tblVwFilter, numberOfRowsInSection: section)
            let rowHeight = tableView(tblVwFilter, heightForRowAt: IndexPath(row: 0, section: section))
            let sectionHeight = tableView(tblVwFilter, heightForHeaderInSection: section)
            
            totalHeight += sectionHeight + CGFloat(numberOfRows) * rowHeight
        }
        
        return totalHeight
    }
}

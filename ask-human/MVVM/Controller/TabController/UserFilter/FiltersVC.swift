//
//  FiltersVC.swift
//  ask-human
//
//  Created by IDEIO SOFT on 09/01/25.
//

import UIKit
import SwiftRangeSlider
import AlignedCollectionViewFlowLayout
import MaterialComponents
import MultiSlider

class FiltersVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet var btnResetAll: UIButton!
    @IBOutlet var btnCross: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var lblTitleHourlyPrice: UILabel!
    @IBOutlet var lblTitleRating: UILabel!
    @IBOutlet var lblTitleLanguage: UILabel!
    @IBOutlet var lblTitleEthic: UILabel!
    @IBOutlet var lblTitleZodiac: UILabel!
    @IBOutlet var lblTitleGender: UILabel!
    @IBOutlet var lblTitleAge: UILabel!
    @IBOutlet var lblTitleHashtags: UILabel!
    @IBOutlet var scrollVw: UIScrollView!
    @IBOutlet var scrollViewTop: NSLayoutConstraint!
    @IBOutlet var heightHashtags: NSLayoutConstraint!
    @IBOutlet var btnResetHahstag: UIButton!
    @IBOutlet var btnResetAge: UIButton!
    @IBOutlet var btnResetGender: UIButton!
    @IBOutlet var btnResetZodiac: UIButton!
    @IBOutlet var btnResetEthics: UIButton!
    @IBOutlet var btnResetLanguage: UIButton!
    @IBOutlet var btnResetRating: UIButton!
    @IBOutlet var btnResetHourlyPrice: UIButton!
    @IBOutlet var ageMultiSlider: MultiSlider!
    @IBOutlet var ageSlider: RangeSlider!
    @IBOutlet var ratingSlider: ThumbTextSlider!
    @IBOutlet var viewDoubleSlider: RangeSliderFilter!
    @IBOutlet var lblEthics: UILabel!
    @IBOutlet var heightCollvwLanguage: NSLayoutConstraint!
    @IBOutlet var collVwLanguage: UICollectionView!
    @IBOutlet var txtfldHashtag: UITextField!
    @IBOutlet var viewSuggestHashtags: UIView!
    @IBOutlet var viewAddmoreHahstag: UIView!
    @IBOutlet var viewEthnicity: UIView!
    @IBOutlet var viewChooseLanguage: UIView!
    @IBOutlet var viewOtherLanguage: UIView!
    @IBOutlet var hourlyPriceSlider: MultiSlider!
    @IBOutlet var viewBack: UIView!
    @IBOutlet var collVwZodiac: UICollectionView!
    @IBOutlet var collVwGender: UICollectionView!
    @IBOutlet var collVwHashtag: UICollectionView!
    @IBOutlet var collVwHashtagSuggest: UICollectionView!
    @IBOutlet var heightCollvwHAshtagSuggest: NSLayoutConstraint!
    @IBOutlet var txtFldOtherLanguage: UITextField!
    //MARK: - variables
    var type:Int = 0
    var isSelectNew = false
    var arrGender = ["Male", "Female", "Others"]
    var arrSelectedGender = [Int]()
    var arrZodiac = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    var arrSelectedZodiac = [String]()
    var viewModel = NoteVM()
    var arrTrendingHashtags = [Hashtaggs]()
    var arrSuggestHashtags = [GetSearchHashtagData]()
    var viewModelHashtag = ProfileVM()
    var isMatched = false
    var arrLanguages = [Language]()
    var arrSelectedLanguages = [String]()
    var arrContainLanguage = [String]()
    var arrSelectedEthics = [String]()
    var arrContainEthics = [String]()
    var arrContainHahtags = [String]()
    var arrContainZodiac = [String]()
    var arrEthnic = [Ethnic]()
    var arrSelectedHahtags = [String]()
    var arrContainGender = [Int]()
    var sliderRating = ""
    var minAge = ""
    var maxAge = ""
    var minPrice = ""
    var maxPrice = ""
    var arrEthicsIds = [String]()
    var arrLanguageIds = [String]()
    var callBack:(()->())?
    var isContainLanguage = false
    var isLoading = false
    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arrSelectedHahtags.append(contentsOf: Store.searchHastag ?? [])
        //Store.searchHastag = arrSelectedHahtags
        print("Store.searchHastag:-\(Store.searchHastag)")
        print("arrSelectedHahtags:-\(arrSelectedHahtags)")

        uiSet()
        setupTapGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTrendingHahstagApi()
        darkMode()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getLanguagesApi()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getEthnicityApi()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
        }
    }
    
    private func uiSet() {
        arrContainGender = Store.filterGender?["Gender"] ?? []
        arrContainHahtags = Store.searchHastag ?? []
        arrContainEthics = Store.filterDetail?["Ethnicity"] ?? []
        arrContainZodiac = Store.filterDetail?["Zodiac"] ?? []
        arrContainLanguage = Store.filterDetail?["language"] ?? []
        slidersSetup()
        viewBack.layer.cornerRadius = 10
        viewBack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        scrollVw.layer.cornerRadius = 10
        scrollVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let nib2 = UINib(nibName: "AddHashtagCVC", bundle: nil)
        collVwHashtagSuggest.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        collVwLanguage.register(nib2, forCellWithReuseIdentifier: "AddHashtagCVC")
        
        let nib = UINib(nibName: "FilterOptionsCVC", bundle: nil)
        collVwHashtag.register(nib, forCellWithReuseIdentifier: "FilterOptionsCVC")
        collVwZodiac.register(nib, forCellWithReuseIdentifier: "FilterOptionsCVC")
        collVwGender.register(nib, forCellWithReuseIdentifier: "FilterOptionsCVC")
        
        let alignedFlowLayoutCollVwHashtag2 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwHashtagSuggest.collectionViewLayout = alignedFlowLayoutCollVwHashtag2
        
        if let flowLayout = collVwHashtagSuggest.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.invalidateLayout()
        }
        
        let alignedFlowLayoutCollVwHashtag22 = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        collVwLanguage.collectionViewLayout = alignedFlowLayoutCollVwHashtag22
        
        if let flowLayout2 = collVwLanguage.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout2.estimatedItemSize = CGSize(width: 0, height: 22)
            flowLayout2.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout2.invalidateLayout()
        }
        collVwGender.reloadData()
        collVwZodiac.reloadData()
        collVwLanguage.reloadData()
        collVwHashtag.reloadData()
        updateHeight(for: collVwLanguage, constraint: heightCollvwLanguage)
        updateheightCollVwLanguage()
    }
    
    private func darkMode() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        btnCross.setImage(isDarkMode ? UIImage(named: "darkCross") : UIImage(named: "crosss"), for: .normal)
        btnResetAll.setImage(isDarkMode ? UIImage(named: "darkReset") : UIImage(named: "reset"), for: .normal)
        btnCancel.backgroundColor = isDarkMode ? UIColor.white : UIColor(hex: "#272727")
        btnCancel.setTitleColor(isDarkMode ? UIColor.black : .white, for: .normal)
        
        let placeholderColor = isDarkMode ? UIColor(red: 199/255, green: 199/255, blue: 199/255, alpha: 1.0) : UIColor.placeholder
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: placeholderColor]
        
        [txtfldHashtag, txtFldOtherLanguage].forEach {
            $0?.attributedPlaceholder = NSAttributedString(string: $0?.placeholder ?? "", attributes: attributes)
            $0?.textColor = isDarkMode ? .white : .black
        }
        
        let textColor = isDarkMode ? UIColor.white : UIColor.black
        [lblTitleHashtags, lblTitleAge, lblTitleGender, lblTitleZodiac, lblTitleEthic,
         lblTitleLanguage, lblTitleRating, lblTitleHourlyPrice, lblEthics].forEach {
            $0?.textColor = textColor
        }
    }
    func getTrendingHahstagApi(){
        viewModel.getTrendingHashtagApi { data in
            self.arrTrendingHashtags = data?.hashtags ?? []
            self.collVwHashtag.reloadData()
            self.updateHashtagsHeight()
            self.isLoading = true
        }
    }
    private func updateHashtagsHeight() {
        guard let flowLayout = collVwHashtag.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        // Total number of items
        let numberOfItems = arrTrendingHashtags.count
        // Assuming 2 items per row
        let itemsPerRow: CGFloat = 2
        // Calculate number of rows
        let numberOfRows = ceil(CGFloat(numberOfItems) / itemsPerRow)
        // Cell height (you may need to adjust based on design)
        let itemHeight: CGFloat = 40.0 // Replace with the actual height of your cell
        // Spacing adjustments
        let lineSpacing = flowLayout.minimumLineSpacing
        let sectionInsets = flowLayout.sectionInset
        
        // Total height calculation
        let totalHeight = (numberOfRows * itemHeight) +
        ((numberOfRows - 1) * lineSpacing)
        heightHashtags.constant = totalHeight
        self.view.layoutIfNeeded()
    }
    
    private func getLanguagesApi(){
        
        viewModel.getLanguagesApi { data in
            self.arrLanguages = data?.languages ?? []
            self.arrLanguageIds = Store.filterDetail?["language"] ?? [""]
            for datas in data?.languages  ?? []{
                if self.arrLanguageIds.contains(datas.id ?? ""){
                    self.arrSelectedLanguages.append(datas.name ?? "")
                    self.isContainLanguage = true
                }
            }
            DispatchQueue.main.async{
                self.collVwLanguage.reloadData()
                self.updateheightCollVwLanguage()
                self.updateHeight(for: self.collVwLanguage, constraint: self.heightCollvwLanguage)
                
            }
        }
    }
    private func getEthnicityApi(){
        viewModel.getEthnicityApi { data in
            self.arrEthnic = data?.ethnics ?? []
            self.arrEthicsIds = Store.filterDetail?["Ethnicity"] ?? [""]
            for datas in data?.ethnics  ?? []{
                if self.arrEthicsIds.contains(datas.id ?? ""){
                    self.arrSelectedEthics.insert(datas.ethnic ?? "", at: 0)
                }
            }
            
            
            let selectedEthicsString = self.arrSelectedEthics.joined(separator: ", ")
            
            self.lblEthics.text = selectedEthicsString
            if selectedEthicsString == ""{
                self.lblEthics.text = "Choose Ethnicity"
                self.lblEthics.textColor = UIColor(hex: "#6E6E6E")
            }else{
                self.lblEthics.textColor = UIColor(hex: "#000000")
            }
            
        }
    }
    //MARK: - button actions
    @IBAction func actionOtherlanguageDone(_ sender: UIButton) {
        view.endEditing(true)
        if let text = txtFldOtherLanguage.text, !text.isEmpty {
            isLanguageExist = true
            viewModel.addLanguagesApi(name: text) { data in
                self.view.endEditing(true)
                self.txtFldOtherLanguage.text = ""
                self.getLanguagesApi()
            }
        } else {
            
            viewOtherLanguage.isHidden = true
            // Optionally show an alert or handle the case when the text field is empty
            print("Text field is empty, not adding language.")
        }
    }
    @IBAction func actionSuggestHashtagDone(_ sender: UIButton) {
        scrollViewTop.constant = 50
        view.endEditing(true)
        viewAddmoreHahstag.isHidden = false
        viewSuggestHashtags.isHidden = true
        txtfldHashtag.text = ""
        arrSuggestHashtags.removeAll()
        collVwHashtagSuggest.reloadData()
        updateheightCollVwSuggestHashtags()
        updateHeight(for: collVwHashtagSuggest, constraint: heightCollvwHAshtagSuggest)
    }
    
    @IBAction func actionAddMoreHashtag(_ sender: UIButton) {
        view.endEditing(true)
        viewAddmoreHahstag.isHidden = true
        viewSuggestHashtags.isHidden = false
    }
    @IBAction func actionCancel(_ sender: UIButton) {
        view.endEditing(true)
        self.dismiss(animated: true)
    }
    @IBAction func actionApply(_ sender: UIButton) {
        applyFilters()
    }
    private  func applyFilters(){
        view.endEditing(true)
      
        Store.searchHastag = arrSelectedHahtags
        Store.filterGender = ["Gender":arrSelectedGender]
        Store.filterDetail = ["Ethnicity":arrEthicsIds,
                              "Zodiac":arrSelectedZodiac,
                              "language":arrLanguageIds]
        Store.filterMinMaxValues = [ "minAge":minAge,
                                     "maxAge":maxAge,
                                     "minPrice":minPrice,
                                     "maxPrice":maxPrice,
                                     "rating":sliderRating]
        self.dismiss(animated: true)
        callBack?()
        print("Store.searchHastag:-\(Store.searchHastag)")
        print("arrSelectedHahtags:-\(arrSelectedHahtags)")
    }
    @IBAction func actionCross(_ sender: UIButton) {
        view.endEditing(true)
        self.dismiss(animated: true)
    }
    @IBAction func actionResetAll(_ sender: UIButton) {
        //self.dismiss(animated: true)
        view.endEditing(true)
        Store.searchHastag = nil
        viewOtherLanguage.isHidden = true
        resetEthics()
        resetGender()
        resetZodiac()
        resetHahstag()
        resetLanguage()
        resetAge()
        resetHourltPrice()
        resetRating()
        applyFilters()
    }
    @IBAction func actionResetHashtag(_ sender: UIButton) {
        view.endEditing(true)
        resetHahstag()
    }
    private func resetHahstag(){
        arrSelectedHahtags.removeAll()
        arrContainHahtags.removeAll()
        for index in 0..<arrTrendingHashtags.count {
            if let cell = collVwHashtag.cellForItem(at: IndexPath(item: index, section: 0)) as? FilterOptionsCVC {
                cell.btnSelect.isSelected = false
            }
        }
        collVwHashtag.reloadData()
        viewAddmoreHahstag.isHidden = false
        viewSuggestHashtags.isHidden = true
        txtfldHashtag.text = ""
        arrSuggestHashtags.removeAll()
        collVwHashtagSuggest.reloadData()
        updateheightCollVwSuggestHashtags()
        updateHeight(for: collVwHashtagSuggest, constraint: heightCollvwHAshtagSuggest)
    }
    @IBAction func actionResetAge(_ sender: UIButton) {
        view.endEditing(true)
        resetAge()
    }
    private func resetAge(){
        minAge = ""
        maxAge = ""
        ageMultiSlider.value = [18, 65]
        
    }
    @IBAction func actionResetGender(_ sender: UIButton){
        view.endEditing(true)
        resetGender()
    }
    private func resetGender(){
        arrContainGender.removeAll()
        arrSelectedGender.removeAll()
        for index in 0..<arrGender.count {
            if let cell = collVwGender.cellForItem(at: IndexPath(item: index, section: 0)) as? FilterOptionsCVC {
                cell.btnSelect.isSelected = false
            }
        }
        collVwGender.reloadData()
    }
    @IBAction func actionResetZodiac(_ sender: UIButton) {
        view.endEditing(true)
        resetZodiac()
    }
    private func resetZodiac(){
        arrSelectedZodiac.removeAll()
        arrContainZodiac.removeAll()
        for index in 0..<arrZodiac.count {
            if let cell = collVwZodiac.cellForItem(at: IndexPath(item: index, section: 0)) as? FilterOptionsCVC {
                cell.btnSelect.isSelected = false
            }
        }
        collVwZodiac.reloadData()
        
    }
    @IBAction func actionResetEthinicity(_ sender: UIButton) {
        view.endEditing(true)
        resetEthics()
    }
    private func resetEthics(){
        arrEthicsIds.removeAll()
        arrSelectedEthics.removeAll()
        arrContainEthics.removeAll()
        lblEthics.text = "Choose Ethnicity"
        lblEthics.textColor = UIColor(hex: "#6E6E6E")
        
    }
    @IBAction func actionResetLanguage(_ sender: UIButton) {
        viewOtherLanguage.isHidden = true
        view.endEditing(true)
        resetLanguage()
    }
    private func resetLanguage(){
        arrLanguageIds.removeAll()
        arrSelectedLanguages.removeAll()
        arrContainLanguage.removeAll()
        collVwLanguage.reloadData()
        updateheightCollVwLanguage()
        updateHeight(for: collVwLanguage, constraint: heightCollvwLanguage)
        
    }
    @IBAction func actionResetRating(_ sender: UIButton) {
        view.endEditing(true)
        resetRating()
    }
    private func resetRating(){
        ratingSlider.value = 0
    }
    @IBAction func actionResetHourlyPrice(_ sender: UIButton) {
        view.endEditing(true)
        resetHourltPrice()
    }
    private func resetHourltPrice(){
        minPrice = ""
        maxPrice = ""
        hourlyPriceSlider.value = [1, 1000]
    }
    
}
//MARK: - slidersSetup
extension FiltersVC{
    private func slidersSetup(){
        ageMultiSlider.orientation = .horizontal
        ageMultiSlider.minimumValue = 18
        ageMultiSlider.maximumValue = 65
        ageMultiSlider.outerTrackColor = UIColor(hex: "#D9D9D9")
        
        // Ensure that the slider's value is in the correct range (use integers)
        ageMultiSlider.value = [18, 65]
        
        ageMultiSlider.valueLabelPosition = .top
        ageMultiSlider.tintColor = .app
        ageMultiSlider.trackWidth = 10
        ageMultiSlider.showsThumbImageShadow = false
        ageMultiSlider.valueLabelAlternatePosition = false
        
        ageMultiSlider.keepsDistanceBetweenThumbs = false
        
        // Format the value labels as integers with the "Years" suffix
        ageMultiSlider.valueLabelFormatter.positiveSuffix = " Years"
        ageMultiSlider.valueLabelFormatter.numberStyle = .decimal
        ageMultiSlider.valueLabelFormatter.minimumFractionDigits = 0
        ageMultiSlider.valueLabelFormatter.maximumFractionDigits = 0
        
        if traitCollection.userInterfaceStyle == .dark {
            ageMultiSlider.valueLabelColor = UIColor(hex: "#979797")
        }else{
            ageMultiSlider.valueLabelColor = UIColor(hex: "#545454")
        }
        
        ageMultiSlider.addTarget(self, action: #selector(ageMultisliderSliderValueChanged(_:)), for: .valueChanged)
        
        hourlyPriceSlider.orientation = .horizontal
        hourlyPriceSlider.minimumValue = 1
        hourlyPriceSlider.maximumValue = 100
        hourlyPriceSlider.outerTrackColor = UIColor(hex: "#D9D9D9")
        
        // Ensure that the slider's value is in the correct range (use integers)
        hourlyPriceSlider.value = [1, 100]
        
        hourlyPriceSlider.valueLabelPosition = .top
        hourlyPriceSlider.tintColor = .app
        hourlyPriceSlider.trackWidth = 10
        hourlyPriceSlider.showsThumbImageShadow = false
        hourlyPriceSlider.valueLabelAlternatePosition = false
        
        hourlyPriceSlider.keepsDistanceBetweenThumbs = false
        
        // Format the value labels as integers with the "Years" suffix
        hourlyPriceSlider.valueLabelFormatter.positivePrefix = "$"
        hourlyPriceSlider.valueLabelFormatter.numberStyle = .decimal
        hourlyPriceSlider.valueLabelFormatter.minimumFractionDigits = 0
        hourlyPriceSlider.valueLabelFormatter.maximumFractionDigits = 0
        
        if traitCollection.userInterfaceStyle == .dark {
            hourlyPriceSlider.valueLabelColor = UIColor(hex: "#979797")
        }else{
            hourlyPriceSlider.valueLabelColor = UIColor(hex: "#545454")
        }
        
        hourlyPriceSlider.addTarget(self, action: #selector(hourlySliderValueChanged(_:)), for: .valueChanged)
        
        //rating
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 5
        if let ratingVal = Store.filterMinMaxValues?["rating"] as? String,
           let ratingVal1 = Double(ratingVal) {
            ratingSlider.value = Float(ratingVal1)
            minAge = String(format: "%.0f", ratingVal1)  // Formatting to 1 decimal place
        }
        ratingSlider.addTarget(self, action: #selector(ratingSlidervalueChanged(_:)), for: .valueChanged)
        if let minAgeString = Store.filterMinMaxValues?["minAge"] as? String,
           let minAge1 = Double(minAgeString) {
            ageMultiSlider.value = [minAge1, ageMultiSlider.value.last ?? 0]
            minAge = String(minAge1)
        }
        
        if let maxAgeString = Store.filterMinMaxValues?["maxAge"] as? String,
           let maxAge1 = Double(maxAgeString) {
            ageMultiSlider.value = [ageMultiSlider.value.first ?? 0, maxAge1]
            maxAge = String(maxAge1)
        }
        
        if let minPriceString = Store.filterMinMaxValues?["minPrice"] as? String,
           let minPrice1 = Double(minPriceString) {
            hourlyPriceSlider.value = [minPrice1, hourlyPriceSlider.value.last ?? 0]
            minPrice = String(minPrice1)
        }
        
        if let maxPriceString = Store.filterMinMaxValues?["maxPrice"] as? String,
           let maxPrice1 = Double(maxPriceString) {
            hourlyPriceSlider.value = [hourlyPriceSlider.value.first ?? 0, maxPrice1]
            maxPrice = String(maxPrice1)
        }
        
    }
    @objc func ageMultisliderSliderValueChanged(_ slider: MultiSlider) {
        view.endEditing(true)
        let firstThumbValue = slider.value.first ?? 0.0
        minAge = String(format: "%.0f", firstThumbValue)
        let secondThumbValue = slider.value.last ?? 0.0
        maxAge = String(format: "%.0f", secondThumbValue)
    }
    
    @objc func hourlySliderValueChanged(_ slider: MultiSlider) {
        view.endEditing(true)
        let firstThumbValue = slider.value.first ?? 0.0
        minPrice = String(format: "%.0f", firstThumbValue)
        let secondThumbValue = slider.value.last ?? 0.0
        maxPrice = String(format: "%.0f", secondThumbValue)
    }
    
    @objc func ratingSlidervalueChanged(_ rangeSlider: ThumbTextSlider) {
        let sliderValue = rangeSlider.value
        let formattedValue = String(format: "%.1f", sliderValue)
        sliderRating = formattedValue
        rangeSlider.setValue(sliderValue, animated: true)
    }
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension FiltersVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collVwHashtag:
            return arrTrendingHashtags.count
        case collVwHashtagSuggest:
            return arrSuggestHashtags.count
        case collVwLanguage:
            return arrSelectedLanguages.count
        case collVwGender:
            return arrGender.count
        default:
            return arrZodiac.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwHashtag{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterOptionsCVC", for: indexPath) as! FilterOptionsCVC
            if arrTrendingHashtags.count > 0 {
                cell.lblTitle.text = "#\(arrTrendingHashtags[indexPath.item].title ?? "")"
                if arrContainHahtags.contains(arrTrendingHashtags[indexPath.item].title ?? "") {
                    if !arrSelectedHahtags.contains(arrTrendingHashtags[indexPath.item].title ?? "") {
                        arrSelectedHahtags.append(arrTrendingHashtags[indexPath.item].title ?? "")
                    }
                }
            }
            cell.btnSelect.isSelected = arrSelectedHahtags.contains(arrTrendingHashtags[indexPath.item].title ?? "")
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#545454")
            
            let selectedImage = UIImage(named: "selected")
            let deselectedImage = isDarkMode ? UIImage(named: "darkNoSel") : UIImage(named: "unSelcted")
            cell.btnSelect.setImage(cell.btnSelect.isSelected ? selectedImage : deselectedImage, for: .normal)
           	
            return cell
        }else if collectionView == collVwHashtagSuggest{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
            
            if arrSuggestHashtags.count > 0 {
                if let customFont = UIFont(name: "Nunito-Medium", size: 10) {
                    cell.lblHashtag.font = customFont
                }
                cell.viewBack.layer.cornerRadius = 12
                cell.viewBtnDelete.isHidden = true
                cell.viewBack.borderWid = 0
                let suggestHashtag = arrSuggestHashtags[indexPath.row]
                cell.lblHashtag.text = "#\(suggestHashtag.title ?? "")"
                if let hashtagTitle = suggestHashtag.title {
                    if arrTrendingHashtags.contains(where: { $0.title == hashtagTitle }) {
                        
                        cell.imgVwVerify.image = UIImage(named: "whiteverify")
                        cell.viewBack.backgroundColor = .app
                        cell.lblHashtag.textColor = .white
                        
                    } else {
                        cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
                        
                        let isDarkMode = traitCollection.userInterfaceStyle == .dark
                        cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38") : UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
                        cell.lblHashtag.textColor = isDarkMode ? UIColor(hex: "#CCCCCC") : .black
                        
                        
                    }
                }
                if suggestHashtag.isVerified == 1 {
                    cell.widthImgVerify.constant = 14
                } else {
                    cell.widthImgVerify.constant = 0
                }
                
                cell.viewUserCount.setGradientBackground(
                    colors: [UIColor(hex: "#F10B81"), UIColor(hex: "#950D98")],
                    startPoint: CGPoint(x: 0.0, y: 0.0),
                    endPoint: CGPoint(x: 1.0, y: 1.0)
                )
                
                if suggestHashtag.usedCount == 0 {
                    cell.viewUserCount.isHidden = true
                } else if suggestHashtag.usedCount ?? 0 < 100 {
                    cell.viewUserCount.isHidden = false
                    cell.widthViewUsedCount.constant = 16
                    cell.heightUsedCount.constant = 16
                    cell.viewUserCount.layer.cornerRadius = 8
                } else {
                    cell.viewUserCount.isHidden = false
                    cell.widthViewUsedCount.constant = 20
                    cell.heightUsedCount.constant = 20
                    cell.viewUserCount.layer.cornerRadius = 10
                }
                cell.lblUsedCount.text = formatUsedCount(suggestHashtag.usedCount ?? 0)
                
            }
            return cell
        }else if collectionView == collVwLanguage{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddHashtagCVC", for: indexPath) as! AddHashtagCVC
            cell.lblHashtag.text = arrSelectedLanguages[indexPath.row]
            cell.viewBack.layer.cornerRadius = 12
            cell.viewBtnDelete.isHidden = false
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.viewBack.backgroundColor = isDarkMode ? UIColor(hex: "#610D38")  : UIColor(hex: "#EE0C81").withAlphaComponent(0.07)
            cell.imgVwDeleteBtn.image = isDarkMode ? UIImage(named: "darkCros") : UIImage(named: "crossTag")
            cell.lblHashtag.textColor =  isDarkMode ? UIColor(hex: "#CCCCCC") : .black
            cell.viewBack.borderCol = .clear
            cell.imgVwVerify.image = UIImage(named: "certificate-solid 1")
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(actionDeleteLanguage), for: .touchUpInside)
            return cell
        }else if collectionView == collVwGender{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterOptionsCVC", for: indexPath) as! FilterOptionsCVC
            let data = arrGender[indexPath.item]
            cell.lblTitle.text = data
            if !arrSelectedGender.contains(indexPath.item) && arrContainGender.contains(indexPath.item) {
                arrSelectedGender.append(indexPath.item)
            }
            cell.btnSelect.isSelected = arrContainGender.contains(indexPath.item)
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#545454")
            
            let selectedImage = UIImage(named: "selected")
            let deselectedImage = isDarkMode ? UIImage(named: "darkNoSel") : UIImage(named: "unSelcted")
            cell.btnSelect.setImage(cell.btnSelect.isSelected ? selectedImage : deselectedImage, for: .normal)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterOptionsCVC", for: indexPath) as! FilterOptionsCVC
            let data = arrZodiac[indexPath.item]
            cell.lblTitle.text = data
            if arrContainZodiac.contains(data) {
                if !arrSelectedZodiac.contains(data) {
                    arrSelectedZodiac.append(data)
                }
                cell.btnSelect.isSelected = true
            } else {
                cell.btnSelect.isSelected = false
            }
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#545454")
            
            let selectedImage = UIImage(named: "selected")
            let deselectedImage = isDarkMode ? UIImage(named: "darkNoSel") : UIImage(named: "unSelcted")
            cell.btnSelect.setImage(cell.btnSelect.isSelected ? selectedImage : deselectedImage, for: .normal)
            return cell
        }
        
    }
    @objc func actionDeleteLanguage(sender:UIButton){
        view.endEditing(true)
        arrSelectedLanguages.remove(at: sender.tag)
        arrLanguageIds.remove(at: sender.tag)
        collVwLanguage.reloadData()
        updateHeight(for: collVwLanguage, constraint: heightCollvwLanguage)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        if collectionView == collVwHashtag {
            if isLoading{
                let hashtag = arrTrendingHashtags[indexPath.item]
                let cell = collectionView.cellForItem(at: indexPath) as! FilterOptionsCVC
                cell.btnSelect.isSelected.toggle()
                if cell.btnSelect.isSelected {
                    print("isSelected")
                    arrSelectedHahtags.append(hashtag.title ?? "")
                } else {
                    if let index = arrSelectedHahtags.firstIndex(of: hashtag.title ?? "") {
                        print("deSelected")
                        arrSelectedHahtags.remove(at: index)
                    }
                }
                cell.btnSelect.isSelected = arrSelectedHahtags.contains(arrTrendingHashtags[indexPath.item].title ?? "")
                let isDarkMode = traitCollection.userInterfaceStyle == .dark
                cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#545454")
                
                let selectedImage = UIImage(named: "selected")
                let deselectedImage = isDarkMode ? UIImage(named: "darkNoSel") : UIImage(named: "unSelcted")
                cell.btnSelect.setImage(cell.btnSelect.isSelected ? selectedImage : deselectedImage, for: .normal)

            }
        }else  if collectionView == collVwHashtagSuggest {
            let suggestHashtag = arrSuggestHashtags[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath) as! AddHashtagCVC
            if !arrTrendingHashtags.contains(where: { $0.title == suggestHashtag.title }) {
                arrTrendingHashtags.append(Hashtaggs(id: nil, title: suggestHashtag.title ?? "", isVerified: nil, createdBy: nil, usedCount: nil))
                cell.viewBack.backgroundColor = .app
                cell.imgVwVerify.image = UIImage(named: "whiteverify")
                cell.lblHashtag.textColor = .white
                collVwHashtag.reloadData()
                updateHashtagsHeight()
                collVwHashtag.layoutIfNeeded()
            }
        }else if collectionView == collVwGender {
            let gender = arrGender[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath) as! FilterOptionsCVC
            cell.btnSelect.isSelected.toggle()
            if cell.btnSelect.isSelected {
                ///0 for male 1 female
                arrSelectedGender.append(indexPath.row)
                print("isSelected")

            } else {
                if let index = arrSelectedGender.firstIndex(of: indexPath.row) {
                    arrSelectedGender.remove(at: index)
                    print("deSelected")

                }
            }
            cell.btnSelect.isSelected = arrSelectedGender.contains(indexPath.row)

            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#545454")
            
            let selectedImage = UIImage(named: "selected")
            let deselectedImage = isDarkMode ? UIImage(named: "darkNoSel") : UIImage(named: "unSelcted")
            cell.btnSelect.setImage(cell.btnSelect.isSelected ? selectedImage : deselectedImage, for: .normal)

        } else if collectionView == collVwZodiac {
            let zodiac = arrZodiac[indexPath.item]
            let cell = collectionView.cellForItem(at: indexPath) as! FilterOptionsCVC
            cell.btnSelect.isSelected.toggle()
            if cell.btnSelect.isSelected {
                arrSelectedZodiac.append(zodiac)
                print("isSelected")

            } else {
                if let index = arrSelectedZodiac.firstIndex(of: zodiac) {
                    arrSelectedZodiac.remove(at: index)
                    print("deSelected")
                }
            }
            cell.btnSelect.isSelected = arrSelectedZodiac.contains(arrZodiac[indexPath.item])
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            cell.lblTitle.textColor = isDarkMode ? UIColor(hex: "#979797") : UIColor(hex: "#545454")
            
            let selectedImage = UIImage(named: "selected")
            let deselectedImage = isDarkMode ? UIImage(named: "darkNoSel") : UIImage(named: "unSelcted")
            cell.btnSelect.setImage(cell.btnSelect.isSelected ? selectedImage : deselectedImage, for: .normal)

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collVwHashtag {
            let collectionWidth = collectionView.frame.width
            let itemWidth = (collectionWidth / 2) - 5 // Adjust spacing here
            let itemHeight: CGFloat = 40 // Set a fixed height for all items
            
            return CGSize(width: itemWidth, height: itemHeight)
        }else if collectionView == collVwZodiac || collectionView == collVwGender{
            
            let collectionWidth = collectionView.frame.width
            let itemWidth = (collectionWidth / 2) - 5 // Adjust spacing here
            let itemHeight: CGFloat = 30 // Set a fixed height for all items
            return CGSize(width: itemWidth, height: itemHeight)
        }else{
            return CGSize(width: 0, height: 22)
        }
    }
    
}
//MARK: - Tap Gesture Actions
extension FiltersVC{
    //MARK: - Setup Tap Gestures
    private func setupTapGestures() {
        addTapGesture(to: viewEthnicity, action: #selector(viewTapped(_:)))
        addTapGesture(to: viewChooseLanguage, action: #selector(viewTapped(_:)))
        addTapGesture(to: viewOtherLanguage, action: #selector(viewTapped(_:)))
    }
    
    private func addTapGesture(to view: UIView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        if let tappedView = sender.view {
            switch tappedView {
            case viewEthnicity:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterOptionsVC") as! FilterOptionsVC
                vc.isSelect = 1
                vc.arrEthnic = arrEthnic
                vc.arrSelectedEthics = arrSelectedEthics
                vc.modalPresentationStyle = .popover
                vc.preferredContentSize = CGSize(width: tappedView.frame.width, height: CGFloat(arrEthnic.count*55))
                let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
                popOver.sourceView = sender.view
                popOver.delegate = self
                popOver.permittedArrowDirections = .up
                vc.callBack = { index,title,ids  in
                    self.arrSelectedEthics.append(title)
                    self.arrEthicsIds.append(ids)
                    let selectedEthicsString = self.arrSelectedEthics.joined(separator: ", ")
                    self.lblEthics.text = selectedEthicsString
                    let isDarkMode = self.traitCollection.userInterfaceStyle == .dark
                    self.lblEthics.textColor = isDarkMode ? .white : UIColor(hex: "#000000")
                    
                }
                self.present(vc, animated: true, completion: nil)
                
            case viewChooseLanguage:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterOptionsVC") as! FilterOptionsVC
                vc.isSelect = 0
                vc.arrLanguages = arrLanguages
                vc.arrSelectedLanguages = arrSelectedLanguages
                vc.arrLanguageIds = arrLanguageIds
                vc.modalPresentationStyle = .popover
                vc.preferredContentSize = CGSize(width: tappedView.frame.width, height: CGFloat(arrLanguages.count*55))
                let popOver : UIPopoverPresentationController = vc.popoverPresentationController!
                popOver.sourceView = sender.view
                popOver.delegate = self
                popOver.permittedArrowDirections = .up
                vc.callBack = { index,title,ids in
                    if title != "Add more" {
                        DispatchQueue.main.async {
                            self.viewOtherLanguage.isHidden = true
                            self.arrSelectedLanguages.append(title)
                            self.arrLanguageIds.append(ids)
                            self.isContainLanguage = false
                            self.collVwLanguage.reloadData()
                            self.updateheightCollVwLanguage()
                            self.updateHeight(for: self.collVwLanguage, constraint: self.heightCollvwLanguage)
                            // Force layout update
                            self.collVwLanguage.layoutIfNeeded()
                            self.view.layoutIfNeeded()

                        }
                    }else{
                        self.viewOtherLanguage.isHidden = false
                    }
                    
                }
                self.present(vc, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
}
// MARK: - UITextFieldDelegate
extension FiltersVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtfldHashtag{
            self.scrollViewTop.constant = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtfldHashtag{
            self.scrollViewTop.constant = 0
            view.endEditing(true)
        }else if textField == txtFldOtherLanguage{
            view.endEditing(true)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtfldHashtag{
            if string.contains(" ") {
                return false
            }
            
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            print("newText:--\(newText)")
            if newText == ""{
                arrSuggestHashtags.removeAll()
                collVwHashtagSuggest.reloadData()
                updateheightCollVwSuggestHashtags()
                updateHeight(for: collVwHashtagSuggest, constraint: heightCollvwHAshtagSuggest)
            }else{
                arrSuggestHashtags.removeAll()
                
                getSearchHashtags(searchText: newText)
            }

        }else if textField == txtFldOtherLanguage{
            if string.contains(" ") {
                return false
            }
            
        }
        return true
        
    }
    private func getSearchHashtags(searchText:String){
        viewModelHashtag.getSearchHashtagApi(searchBy: searchText) { data
            in
            DispatchQueue.main.async {
                self.arrSuggestHashtags = data
                self.collVwHashtagSuggest.reloadData()
                self.collVwHashtagSuggest.layoutIfNeeded()
                self.scrollViewTop.constant = 0
                self.updateheightCollVwSuggestHashtags()
                self.updateHeight(for: self.collVwHashtagSuggest, constraint: self.heightCollvwHAshtagSuggest)
                self.updateHeight(for: self.collVwHashtagSuggest, constraint: self.heightCollvwHAshtagSuggest)
            }
        }
    }
}
//MARK: - handle height of collectionview suggest hashtag
extension FiltersVC{
    func updateHeight(for collectionView: UICollectionView, constraint: NSLayoutConstraint) {
        DispatchQueue.main.async {
            
            collectionView.performBatchUpdates({
                collectionView.layoutIfNeeded()
                let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
                
                if collectionView == self.collVwHashtagSuggest {
                    constraint.constant = self.arrSuggestHashtags.isEmpty ? 0 : contentHeight
                    
                } else if collectionView == self.collVwLanguage {
                    switch self.arrSelectedLanguages.count {
                    case 0:
                        constraint.constant = 0
                    case 1:
                        constraint.constant = 45
                    default:
                        constraint.constant = contentHeight
                    }
                }
                collectionView.setNeedsLayout()
                collectionView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
                                               
    }
    
    private func updateheightCollVwSuggestHashtags() {
        collVwHashtagSuggest.layoutIfNeeded()
        heightCollvwHAshtagSuggest.constant = collVwHashtagSuggest.contentSize.height
    }
    private func updateheightCollVwLanguage() {
        collVwLanguage.layoutIfNeeded()
        heightCollvwLanguage.constant = collVwLanguage.contentSize.height
    }
    private func formatUsedCount(_ count: Int) -> String {
        if count >= 1_000_000 {
            return "\(count / 1_000_000)M+"
        } else if count >= 1_000 {
            return "\(count / 1_000)K+"
        } else if count % 100 == 0 {
            return "\(count)"
        } else if count > 100 {
            return "\(count / 100 * 100)+"
        } else {
            return "\(count)"
        }
    }
}
// MARK: - Popup
extension FiltersVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    }
}

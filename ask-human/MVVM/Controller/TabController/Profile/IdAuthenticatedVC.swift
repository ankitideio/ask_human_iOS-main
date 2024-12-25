    //
    //  IdAuthenticatedVC.swift
    //  ask-human
    //
    //  Created by IDEIO SOFT on 24/12/24.
    //

    import UIKit

    class IdAuthenticatedVC: UIViewController {
       //MARK: - IBOutlet
        @IBOutlet var btnProcess: GradientButton!
        @IBOutlet var btnBack: UIButton!
        @IBOutlet var imgVwTitle: UIImageView!
        @IBOutlet var txtFldGender: UITextField!
        @IBOutlet var txtFldNationality: UITextField!
        @IBOutlet var txtFldZodiac: UITextField!
        @IBOutlet var txtFldAge: UITextField!
        
        //MARK: - variables
        var callBack:(()->())?
        var countriesPhoneNumbersWithNationalities: [String: [String]] = [
            "Afghan": ["+93"],
            "Albanian": ["+355"],
            "Algerian": ["+213"],
            "Andorran": ["+376"],
            "Angolan": ["+244"],
            "Argentine": ["+54"],
            "Armenian": ["+374"],
            "Australian": ["+61"],
            "Austrian": ["+43"],
            "Azerbaijani": ["+994"],
            "Bahamian": ["+1-242"],
            "Bahraini": ["+973"],
            "Bangladeshi": ["+880"],
            "Barbadian": ["+1-246"],
            "Belarusian": ["+375"],
            "Belgian": ["+32"],
            "Belizean": ["+501"],
            "Beninese": ["+229"],
            "Bhutanese": ["+975"],
            "Bolivian": ["+591"],
            "Bosnian": ["+387"],
            "Botswanan": ["+267"],
            "Brazilian": ["+55"],
            "Bruneian": ["+673"],
            "Bulgarian": ["+359"],
            "Burkinabe": ["+226"],
            "Burundian": ["+257"],
            "Cabo Verdean": ["+238"],
            "Cambodian": ["+855"],
            "Cameroonian": ["+237"],
            "Canadian": ["+1"],
            "Central African": ["+236"],
            "Chadian": ["+235"],
            "Chilean": ["+56"],
            "Chinese": ["+86"],
            "Colombian": ["+57"],
            "Comorian": ["+269"],
            "Congolese (Brazzaville)": ["+242"],
            "Congolese (Kinshasa)": ["+243"],
            "Costa Rican": ["+506"],
            "Croatian": ["+385"],
            "Cuban": ["+53"],
            "Cypriot": ["+357"],
            "Czech": ["+420"],
            "Danish": ["+45"],
            "Djiboutian": ["+253"],
            "Dominican (Dominica)": ["+1-767"],
            "Dominican (Republic)": ["+1-809"],
            "Dominican": ["+1-809"],
            "Ecuadorian": ["+593"],
            "Egyptian": ["+20"],
            "El Salvadoran": ["+503"],
            "Equatorial Guinean": ["+240"],
            "Eritrean": ["+291"],
            "Estonian": ["+372"],
            "Eswatini": ["+268"],
            "Ethiopian": ["+251"],
            "Fijian": ["+679"],
            "Finnish": ["+358"],
            "French": ["+33"],
            "Gabonese": ["+241"],
            "Gambian": ["+220"],
            "Georgian": ["+995"],
            "German": ["+49"],
            "Ghanaian": ["+233"],
            "Greek": ["+30"],
            "Grenadian": ["+1-473"],
            "Guatemalan": ["+502"],
            "Guinean": ["+224"],
            "Guinean-Bissauan": ["+245"],
            "Guyanese": ["+592"],
            "Haitian": ["+509"],
            "Honduran": ["+504"],
            "Hungarian": ["+36"],
            "Icelander": ["+354"],
            "Indian": ["+91"],
            "Indonesian": ["+62"],
            "Iranian": ["+98"],
            "Iraqi": ["+964"],
            "Irish": ["+353"],
            "Israeli": ["+972"],
            "Italian": ["+39"],
            "Ivorian": ["+225"],
            "Jamaican": ["+1-876"],
            "Japanese": ["+81"],
            "Jordanian": ["+962"],
            "Kazakhstani": ["+7"],
            "Kenyan": ["+254"],
            "Kiribati": ["+686"],
            "North Korean": ["+850"],
            "South Korean": ["+82"],
            "Kuwaiti": ["+965"],
            "Kyrgyzstani": ["+996"],
            "Laotian": ["+856"],
            "Latvian": ["+371"],
            "Lebanese": ["+961"],
            "Lesothan": ["+266"],
            "Liberian": ["+231"],
            "Libyan": ["+218"],
            "Liechtenstein": ["+423"],
            "Lithuanian": ["+370"],
            "Luxembourgian": ["+352"],
            "Madagascan": ["+261"],
            "Malawian": ["+265"],
            "Malaysian": ["+60"],
            "Maldivian": ["+960"],
            "Malian": ["+223"],
            "Maltese": ["+356"],
            "Marshallese": ["+692"],
            "Mauritanian": ["+222"],
            "Mauritian": ["+230"],
            "Mexican": ["+52"],
            "Micronesian": ["+691"],
            "Moldovan": ["+373"],
            "Monacan": ["+377"],
            "Mongolian": ["+976"],
            "Montenegrin": ["+382"],
            "Moroccan": ["+212"],
            "Mozambican": ["+258"],
            "Myanmar": ["+95"],
            "Namibian": ["+264"],
            "Nauruan": ["+674"],
            "Nepalese": ["+977"],
            "Dutch": ["+31"],
            "New Zealander": ["+64"],
            "Nicaraguan": ["+505"],
            "Nigerien": ["+227"],
            "Nigerian": ["+234"],
            "North Macedonian": ["+389"],
            "Norwegian": ["+47"],
            "Omani": ["+968"],
            "Pakistani": ["+92"],
            "Palauan": ["+680"],
            "Panamanian": ["+507"],
            "Papua New Guinean": ["+675"],
            "Paraguayan": ["+595"],
            "Peruvian": ["+51"],
            "Filipino": ["+63"],
            "Polish": ["+48"],
            "Portuguese": ["+351"],
            "Qatari": ["+974"],
            "Romanian": ["+40"],
            "Russian": ["+7"],
            "Rwandan": ["+250"],
            "Kittitian": ["+1-869"],
            "Saint Lucian": ["+1-758"],
            "Vincentian": ["+1-784"],
            "Samoan": ["+685"],
            "San Marinese": ["+378"],
            "Sao Tomean": ["+239"],
            "Saudi": ["+966"],
            "Senegalese": ["+221"],
            "Serbian": ["+381"],
            "Seychellois": ["+248"],
            "Sierra Leonean": ["+232"],
            "Singaporean": ["+65"],
            "Slovak": ["+421"],
            "Slovenian": ["+386"],
            "Solomon Islander": ["+677"],
            "Somali": ["+252"],
            "South African": ["+27"],
            "South Sudanese": ["+211"],
            "Spanish": ["+34"],
            "Sri Lankan": ["+94"],
            "Sudanese": ["+249"],
            "Surinamer": ["+597"],
            "Swedish": ["+46"],
            "Swiss": ["+41"],
            "Syrian": ["+963"],
            "Taiwanese": ["+886"],
            "Tajik": ["+992"],
            "Tanzanian": ["+255"],
            "Thai": ["+66"],
            "Togolese": ["+228"],
            "Tongan": ["+676"],
            "Trinidadian": ["+1-868"],
            "Tunisian": ["+216"],
            "Turkish": ["+90"],
            "Turkmen": ["+993"],
            "Tuvaluan": ["+688"],
            "Ugandan": ["+256"],
            "Ukrainian": ["+380"],
            "Emirati": ["+971"],
            "British": ["+44"],
            "American": ["+1"],
            "Uruguayan": ["+598"],
            "Uzbekistani": ["+998"],
            "Vanuatuan": ["+678"],
            "Vatican": ["+39"],
            "Venezuelan": ["+58"],
            "Vietnamese": ["+84"],
            "Yemeni": ["+967"],
            "Zambian": ["+260"],
            "Zimbabwean": ["+263"]
        ]

        override func viewDidLoad() {
            super.viewDidLoad()
            uiSet()
        }
        //MARK: - functions
        func uiSet(){
            if traitCollection.userInterfaceStyle == .dark {
                btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
                imgVwTitle.image = UIImage(named: "askhumanicondark")
            }else{
                btnBack.setImage(UIImage(named: "back"), for: .normal)
                imgVwTitle.image = UIImage(named: "askhumaniconlight")
            }
            txtFldNationality.text = getCountryName(byPhoneCode: Store.userDetail?["countryCode"] as? String ?? "")
            if Store.userDetail?["gender"] as? Int ?? 0 == 0{
                self.txtFldGender.text = "Male"
            }else if Store.userDetail?["gender"] as? Int ?? 0 == 1{
                self.txtFldGender.text = "Female"
            }else{
                self.txtFldGender.text = "TS"
            }
            txtFldAge.text = "\(Store.userDetail?["age"] as? Int ?? 0)"
            if let dob = Store.userDetail?["dob"] as? String, !dob.isEmpty {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM, yyyy"
                    if let dateOfBirth = formatter.date(from: dob) {
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.month, .day], from: dateOfBirth)
                        if let month = components.month, let day = components.day {
                            self.txtFldZodiac.text = getZodiacSign(month: month, day: day)
                        }
                    }
                }
        }
        func getCountryName(byPhoneCode phoneCode: String) -> String? {
            for (country, codes) in countriesPhoneNumbersWithNationalities {
                if codes.contains(phoneCode) {
                    return country
                }
            }
            return nil
        }
        private func getZodiacSign(month: Int, day: Int) -> String {
            switch (month, day) {
            case (1, 20...), (2, 1...18): return "Aquarius"
            case (2, 19...), (3, 1...20): return "Pisces"
            case (3, 21...), (4, 1...19): return "Aries"
            case (4, 20...), (5, 1...20): return "Taurus"
            case (5, 21...), (6, 1...20): return "Gemini"
            case (6, 21...), (7, 1...22): return "Cancer"
            case (7, 23...), (8, 1...22): return "Leo"
            case (8, 23...), (9, 1...22): return "Virgo"
            case (9, 23...), (10, 1...22): return "Libra"
            case (10, 23...), (11, 1...21): return "Scorpio"
            case (11, 22...), (12, 1...21): return "Sagittarius"
            case (12, 22...), (1, 1...19): return "Capricorn"
            default: return "Unknown"
            }
        }
        //MARK: - IBAction
        @IBAction func actionProceed(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
            callBack?()
        }
        @IBAction func actionBack(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
            
        }

    }

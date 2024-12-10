//
//  Constant.swift
//  MYKA
//
//  Created by cqlapple on 11/08/21.
//

import Foundation
import UIKit





//MARK: - URL + KEYS

//let baseURL = "https://www.shoponestop.net/sosapi/v1/"
//let baseURL = "https://d8d3-2401-4900-1c6f-6433-31ef-109f-51bb-5b97.in.ngrok.io/"
let commonBaseURL = "http://52.14.219.231/sosapi/v1/"
let imageURL = "http://52.14.219.231/sosapi/v1/"
let baseURL = "http://52.14.219.231/sosapi/v1/"

public typealias parameters = [String:Any]
let securityKey = ""
var noInternetConnection = "No Internet Connection Available"
var appName = "SOS"
var productId = ""
let window = UIApplication.shared.windows.first


//MARK: - StoryBoard
enum AppStoryboard: String{
    case Main = "Main"
   // case tabBar = "TabbarController"
    var instance: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
var rootVC: UIViewController?{
    get{
        return UIApplication.shared.windows.first?.rootViewController
    }
    set{
        UIApplication.shared.windows.first?.rootViewController = newValue
    }
}
//MARK: - STORE FILE
enum DefaultKeys: String{
    case selectTabIndex
    
}


//MARK: API - SERVICES
enum Services: String
{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//MARK: API - ENUM
enum API: String
{
    //MARK: API - USER
  case signUp = ""
    
}
enum dateFormat: String {
    case fullDate = "MM_dd_yy_HH:mm:ss.SS"
    case MonthDayYear = "MMM d, yyyy"
    case MonthDay = "MMM dd EEE"
    case DateAndTime = "dd/M/yyyy hh:mm a"
    case TimeWithAMorPMandMonthDay = "hh:mm a MMM dd EEE"
    case TimeWithAMorPMandDate = "hh:mm a MMM d, yyyy"
    case dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yearMonthFormat = "yyyy-MM-dd"
    case slashDate = "dd/MM/yyyy"
    case timeAmPm = "hh:mm a"
    case BackEndFormat  = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dateTime = "hh:mm a "
    case hh_mm_a = "hh:mm a MMM yy"
}
//MARK: REGEX - MESSAGE
enum RegexMessage: String {
    case invalidBlnkEmail               = "Please enter email"
    case invalidNameCount               = "Please"
    case invalidImage                   = "Please select image"
    case invalidAddress                 = "Please enter address"
    case streetandHouse                 = "Please enter street & house number"
    case invalidCountryCode             = "Please select country code"
    case invalidCountry                 = "Please enter country"
    case invalidPassword                = "Please enter password"
    case passwordRangeError             = "Password must be in 9 - 16 digit "
    case invalidOldPassword             = "Please enter old password"
    case invalidNewPassword             = "Please enter new password"
    case invalidConfPassword            = "Please enter confirm password"
    case enterMessage                   = "Please enter message"
    case invalidCode                    = "Please enter valid code"
    case invalidCity                    = "Please enter city"
    case invalidState                   = "Please enter state"
    case postalcode                     = "Please enter postal code"
    case invalidName                    = "Please enter name"
    case invalidAlphabetName            = "Please enter valid name"
    case invalidRating                  = "Please add your review"
    case emptyRating                    = "Please add your rating"
    case invalidZipCode                 = "Please enter zipcode"
    case invalidPinCode                 = "Please enter pincode"
    case invalidEmail                   = "Please enter valid email"
    case invalidPhnNo                   = "Please enter mobile number"
    case phoneNumberIncorrectError      = "Please enter atleast 9 digits in phone number"
    case phoneLimitExceedError          = "Phone number must be between 9-11 digits"
    case invalidTerms                   = "Please accept terms and conditions"
    case invalidConfirmPassword         = "Password and confirm password do not match"
}
//func rootToLogin(){
//    UserDefaults.standard.setValue(nil, forKey: "LoginToken")
//    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//    let nav = UINavigationController.init(rootViewController: redViewController)
//    nav.isNavigationBarHidden = true
//    UIApplication.shared.windows.first?.rootViewController = nav
//}
//
//func rootToHome(){
//    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
//    let nav = UINavigationController.init(rootViewController: redViewController)
//    nav.isNavigationBarHidden = true
//    UIApplication.shared.windows.first?.rootViewController = nav
//}
//
//func rootToSelectedTab(tab:Int){
//    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
//    redViewController.selectedIndex = tab
//    let nav = UINavigationController.init(rootViewController: redViewController)
//    nav.isNavigationBarHidden = true
//    UIApplication.shared.windows.first?.rootViewController = nav
//}

func selectLogin_TF(anyview: UIView){
    anyview.layer.cornerRadius = 8
    anyview.backgroundColor = .white
    anyview.layer.borderWidth = 1
    anyview.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
}

func selectPassword_TF(anyview: UIView){
    anyview.layer.borderWidth = 0
    anyview.layer.borderColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
    anyview.layer.cornerRadius = 0
    anyview.backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
}

func reset_TF(anyview: UIView){
    anyview.layer.borderWidth = 0
    anyview.layer.borderColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
    anyview.layer.cornerRadius = 0
    anyview.backgroundColor = #colorLiteral(red: 0.9136453271, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
}

enum constantMessages:String{
    
    case internetError    = "Please check your internet connectivity"
    case emptyName        = "Please enter your name"
    case emptyFullName   = "Please enter full name"
    case emptyLastName    = "Please enter your last name"
    case emptyCountryCode = "Please select your country code"
    case emptyPhone       = "Please enter Phone Number"
    case emptyEmail       = "Please enter your email"
    case emptyPassword    = "Please enter password"
    case emptyOldPassword = "Please enter old password"
    case emptyNewPassword = "Please enter new password"
    case emptyConfirmPassword = "Please enter confirm password"
    case minimumPassword = "Please enter minimum 6 characters"
  
   
    case emptyOtp         = "Please enter OTP"
    case emptyImage       = "Please upload images"
    case emptyGender      = "Please select your gender"
    case emptyLocation    = "Please enter your location"
    case emptyDob         = "Please enter your date of birth"
    case emptyBio         = "Please enter about yourself"
    case emptyAge         = "Please enter your age"
    case emptyHeight      = "Please enter your height"
    case emptymessage     = "Please write something"
    case emptyInterest    = "Please select your interests"
    case emptyHobbies     = "Please select your hobbies"
    case emptyImageOrVideo = "Please add an image or a video"
    case emptyTitle       = "Please add a title"
    case emptyDescription = "Please add description"
    case emptyJobType     = "Please enter job type"
    case emptyPickup      = "Please enter your pick up location"
    case emptydrop        = "Please enter your drop location"
    case emptyDate        = "Please select your date"
    case emptyColor       = "Please enter color"
    case emptyTime        = "Please select your Time"
    case emptyVehicleName = "Please enter your vehicle name"
    case emptyVehicleModel = "Please enter your vehicle model"
    case emptyYear        = "Please select your year"
    case emptyDeriveTerrian = "Please select your drive terrrian"
    case emptyAddReview   = "Please enter your comment"
    case emptyProviderId = "Provider Id nil"
    case passwordCharacterLimit = "Password must be 6 digits long"
    case emptyCardNumber = "Please enter your card number"
    case emptyExpiryDate = "Please enter your card expiry date"
    case emptyCvc = "Plase enter your cvv/vcv number"
     
    
    case acceptTerms      = "Please accept terms & conditions"
    case invalidPhone     = "Please enter valid phone number"
    case invalidEmail     = "Please enter valid email"
    case invalidCPassword = "Password and confirm password doesn't match"
    case invalidOtp       = "Please enter valid OTP"
    case invalidImage     = "You cannot select more than five images"
        
    case blockedUser      = "Please Unblock this user before sending message"
    case blockedByUser    = "You have been blocked by this user"
    case callRejected     = "Call rejected"
    case callEnded        = "Call ended"
    case callNoAnswer     = "No answer"
    
    case resendOtp        = "OTP send your linked phone number"
    var instance : String {
        return self.rawValue
    }
}

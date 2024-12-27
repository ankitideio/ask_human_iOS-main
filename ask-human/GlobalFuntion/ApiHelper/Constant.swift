//
//  Constant.swift
//  ask-human
//
//  Created by IDEIO SOFT on 05/12/23.
//


import Foundation
import UIKit


//MARK: - URL + KEYS


//let imageURL = "http://3.144.134.55/askhuman/v1/"
//let imageURL = "http://13.59.239.2:3000/v1/"
let imageURL = "https://api.askhuman.ai/v1/"

//let baseURL = "http://18.216.216.200/askhuman/v1/"
//let baseURL = "http://3.144.134.55/askhuman/v1/"
//let baseURL = "http://3.14.81.244/askhuman/v1/"
//let baseURL = "http://18.219.17.124/askhuman/v1/"
//let baseURL = "http://18.217.10.216:3000/v1/"

//let baseURL = "http://13.59.239.2:3000/v1/"
let baseURL = "https://api.askhuman.ai/v1/"

public typealias parameters = [String:Any]
let securityKey = ""
var noInternetConnection = "No Internet Connection Available"
var appName = "ask-human"
var productId = ""
var showChat = false
let window = UIApplication.shared.windows.first
var showMessageList = false
var isRead = false
var hasReEmitted = false
var isUserFilter = ""
var filterIndex = 0
var sendByMe = false
var viewInboxData = false
var showLoader = false


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
    
    case authKey
    case userDetails
    case autoLogin
    case deviceToken
    case security_key
    case Authorization
    case loginUser
    case selectTabIndex
    case totalEarning
    case userDetail
    case isComingDraft
    case filterdata
    case notesId
    case userName
    case filterDetail
    case age
    case comingOtp
    case filterAgeSelect
    case selectFilter
    case isFilterAge
    case getMessageData
    case isSocialLogin
    case notificationCount
    case getNotificationData
    case storeNotificationData
    case isRefer
    case selectReferData
    case notifyCount
    case userIdRefer
    case DarkMode
    case userFilter
    case filterIndex
    case addUser
    case openSiri
    case openUrl
    case Hashtags
    case hashtagForSearchUser
    case nationality
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
    case signUp = "auth/signUp"
    case logIn = "auth/login"
    case loginWithGoogle = "auth/sociallogin"
    case phoneVerification = "auth/phoneVerification"
    case addNote = "user/notes/addNotes"
    case getNote = "user/notes/notesDraftList"
    case getProfile = "user/myProfile"
    case logout = "auth/logout"
    case updateProfile = "user/updateProfile"
    case changePassword = "user/changePassword"
    case searchNote = "user/allUserList"
    case resendOtp = "auth/otpResend"
    case userResendOtp = "user/otpResend"
    case forgotPassword = "auth/forgotPassword"
    case otpVerifyforgotPassword = "auth/forgetPasswordOtpVerify"
    case setNewPasswrd = "auth/setNewPassword"
    case sendInvitation = "message/sendInvitation"
    case sendMultipleInvitation = "message/sendMultipleInvitation"
    case notifications = "user/notification/myNotification"
    case notificationRead = "user/notification/isRead"
    case accepReject = "message/acceptOrRejectOrEndInvitation"
    case userDetail = "user/getUserDetails"
    case changeEmail = "user/changeEmail"
    case changePhone = "user/changePhoneNumber"
    case changeEmailVerify = "user/newEmailVerification"
    case changePhoneNumberVerify = "user/verifyPhoneNumber"
    case allContractsList = "message/contractList"
    case contractList = "message/mycontractList"
    case deleteDraft = "user/notes/deleteDraft"
    case draftDetail = "user/notes/notesDraftDetails"
    case addReview = "review/createReview"
    case disputeReasonList = "user/dispute/getUserReasonList"
    case addDispute = "user/dispute/addDispute"
    case myDispute = "user/dispute/myDispute"
    case getDispute = "user/dispute/getDispute"
    case updateNote = "user/notes/updateNotes"
    case messageDetail = "message/messageDetails"
    case transactionHistory = "user/wallet/transactionHistory"
    case uploadVideoVerification = "user/videoIdentification/videoUpload"
    case getEarning = "user/earning/myEarning"
    case getWalletDetails = "user/wallet/getWalletDetails"
    case addWalletAmount = "user/wallet/addWallet"
    case getMessageId = "message/getMessageId"
    case fileUpload = "user/upload/fileUpload"
    case withdrawAmount = "user/earning/withdrawRequest"
    case continueChat = "message/continueChat"
    case endDispute = "user/dispute/endDispute"
    case referInvitation = "message/referInvitation"
    case applyReferInvitation = "message/applyInvitation"
    case acceptRejectReferProposal = "message/referInviteAcceptReject"
    case appliedRequest = "message/getRequests"
    case getjobCreatedDetail = "message/getNoteDetails"
    case appliedUser = "user/getAppliedUsers"
    case addBank = "user/bank/add"
    case bankList = "user/bank"
    case deleteBank = "user/bank/delete"
    case defaultBank = "user/bank/mark-default"
    case getHashtags = "user/hashtags/getHashtags"
    case sendRequestForHashtag = "user/hashtags/requestVerification"
    case scanDocument = "user/scanDocument"
}
enum dateFormat: String {
    case fullDate = "MM_dd_yy_HH:mm:ss.SS"
    case MonthDayYear = "MMM d, yyyy"
    case MonthDay = "MMM dd EEE"
    case DateAndTime = "dd.MM.yyyy hh:mm a"
    case TimeWithAMorPMandMonthDay = "hh:mm a MMM dd EEE"
    case TimeWithAMorPMandDate = "hh:mm a MMM d, yyyy"
    case dateTimeFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yearMonthFormat = "yyyy-MM-dd"
    case slashDate = "dd/MM/yyyy"
    case timeAmPm = "hh:mm a"
    case BackEndFormat  = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case dateTime = "hh:mm a "
    case hh_mm_a = "HH:mm"
    case hh_mm = "HH:mm:ss"
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
func formatDate(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "dd MMMM yyyy,HH:mm"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    return ""
}
func formatDisputeDate(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    return ""
}
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

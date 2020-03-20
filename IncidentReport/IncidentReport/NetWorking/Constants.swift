//
//  Constants.swift
//  HitchApp
//
//  Created by roy on 5/20/19.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

let kappName = "Incident Report"

let googleApiKey = "AIzaSyDPCFuocmjodADPmnWhM1ODSBYkAWWdS2o"
let keyData     = "12345678901234561234567890123456".data(using:String.Encoding.utf8)!
let ivData      = "abcdefghijklmnop".data(using:String.Encoding.utf8)!


let Production = "http://del.kmgin.com:9020/RideShareService_Prod/"


let appImageUrl = Production+"appImage"
let appVersionUrl = Production+"appVersion"
let getLatestTOSPPDocUrl = Production+"getLatestTOSPPDoc"
let authenticateMember = Production+"MemberService.svc/AuthenticateMember"
let saveMemberProfile = Production+"MemberService.svc/SaveMemberProfile"
let saveMemberImage = Production+"MemberService.svc/SaveMemberImage"
let getMemberProfile = Production+"MemberService.svc/GetMemberProfile"
let acceptAgreement = Production+"MemberService.svc/AcceptAgreement"
let saveVehicleImage = Production+"VehicleService.svc/SaveVehicleImage"
let getParameterData = Production+"ParameterService.svc/GetParameterData"
let getDistanceRequest = Production+"RideService.svc/GetDistance"
let saveRideRequest = Production+"RideService.svc/SaveRideRequest"
let searchDriverInRoute = Production+"RideService.svc/SearchDriverInRoute"
let sendRequest = Production+"RideService.svc/SendRequest"
let getRides = Production+"RideService.svc/GetRides"
let getRequest = Production+"RideService.svc/GetRequest"
let getRequestedRides = Production+"RideService.svc/GetRequestedRides"
let getRideRequests = Production+"RideService.svc/GetRideRequests"
let getRequestReplied = Production+"RideService.svc/GetRequestReplied"
let updateRideStatus = Production+"RideService.svc/UpdateRideStatus"
let getMyRideProfile = Production+"RideService.svc/GetMyRideProfile"
let updateRideFeedback = Production+"RideService.svc/UpdateRideFeedback"
let updateScheduledRide = Production+"RideService.svc/UpdateScheduledRide"
let logoutService = Production+"MemberService.svc/MemberLogout"
let getAppUserUrl = Production+"getAppUser"
let updateAppUser = Production+"updateAppUser"
let getCoverImage = Production+"getCoverImage"
let saveCoverImage = Production+"saveCoverImage"
let getVehicleDetailsUrl = Production+"getVehicleDetails"
let saveVehicleDetailsUrl = Production+"saveVehicleDetails"
let cancelUnScheduledRide = Production+"RideService.svc/CancelUnScheduledRide"
let getNotificationCount = Production+"NotificationService.svc/GetNotificationCount"
let payAmount = Production+"PaymentService.svc/PayAmount"

let getMessage = Production+"MessageService.svc/GetMessage"
let saveMessage = Production+"MessageService.svc/SaveMessage"



var rideType: RideType!
enum RideType: Int {
    case offerRide, findRide
}
var rideStatus: RideStatus!
enum RideStatus: Int {
    case onGoing, scheduled, requested, cancelled, paymentPending, paymentConfirmationPending, completed
}

var socialLoginType: SocialLogin!
enum SocialLogin: Int {
    case facebook, twitter
}

var fromMyRides = false
//class Constants: NSObject {
//
//}


let publishableKey = "pk_test_hgdZjDGqsgqvnoYv3qjb8fCR"
let baseURLString = "http://localhost:4567"
let defaultCurrency = "usd"
let defaultDescription = "Purchase from RWPuppies iOS"

//MARK: Instagram
struct INSTAGRAM_IDS{
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_APIURL = "https://api.instagram.com/v1/users/"
    static let INSTAGRAM_CLIENT_ID = "9480991183a84605912c11bb62675beb"
    static let INSTAGRAM_CLIENTSERCRET = "3601a953849a4048afd6431be3ece558"
    static let INSTAGRAM_REDIRECT_URI = "https://www.kmgin.com"
    static var INSTAGRAM_ACCESS_TOKEN = "12262457904.1677ed0.09b64139ded949348b84972cb54e93b0"
    static let INSTAGRAM_SCOPE = "likes+comments+relationships"
    /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
}


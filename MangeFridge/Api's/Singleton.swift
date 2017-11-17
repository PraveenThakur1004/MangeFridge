//
//  Singleton.swift



import UIKit
let sharedManager : Singleton = Singleton()
class Singleton: NSObject {
    //MARK:-Variable and Constant
     var user : User!
     var deviceToken: String?
     var user_id:String?
     var user_email:String?
     var guestUser = false
    //MARK:- Initialization
    override init()
    {
       super.init();
    }
    class var sharedInstance : Singleton {
        return sharedManager
    }
        
}

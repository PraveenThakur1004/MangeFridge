//
//  WebserviceManager.swift


import UIKit
import Foundation
import Alamofire
import FTIndicator
//MARK:-BaseUrls
//http://nimbyisttechnologies.com/himanshu/fridge/api/apis/
let baseUrl = "http://nimbyisttechnologies.com/himanshu/fridge/api/apis/"
class WebserviceManager: NSObject{
    //MARK:- Constant BaseUrl+taskUrl
    //New
    fileprivate let failedURLMessage = "cannot access server's URL"
    //Basic
    let userLoginURL = baseUrl + "login"
    let userSignUpURL = baseUrl + "registerUser"
    let forgotpasswordURL = baseUrl + "forgetPassword"
    let changePasswordURL = baseUrl + "updatePassword"
    let updateDeviceURL = baseUrl + "updateToken?"
    let logoutURL = baseUrl + "logout"
    let updateProfileURL = baseUrl + "updateProfile"
    //SlideMenu
    let searchURL = baseUrl + ""
    let getFavouriteURL = baseUrl + ""
    let getTopRatedURL = baseUrl + ""
    let getDrinksURL = baseUrl + ""
    let getFoodURL = baseUrl + ""
    //Settings
    let privacyPolicyURl = baseUrl + "privacy"
    let aboutUsURl = baseUrl + "about"
    let getHelpURL = baseUrl + "help"
    //MARK:-Almofire post request
    //Multipart
    //singleImage
    func uploadTaskFor(URLString : String , parameters : [String : String] , forImage : UIImage?, imageKey:String, completion: @escaping (_ success: [String : AnyObject]) -> Void){
         Alamofire.upload(
                multipartFormData: { MultipartFormData in
                    for (key, value) in parameters {
                        MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    if forImage != nil{
                        if  let imageData = UIImageJPEGRepresentation(forImage! , 0.6) {
                        
                                                    MultipartFormData.append(imageData, withName: imageKey, fileName: "image.jpeg", mimeType: "image/jpeg")
                        }
                        
                    }
            }, to: URLString) { (result) in
                switch(result) {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if response.result.value != nil{
                            let json = response.result.value
                            completion(json as! [String : AnyObject])
                        }
                    }
                    break;
                case .failure(_):
                    FTIndicator.showError(withMessage:"Unable to upload")
                    break;
                }
            }
        
        
    }
    //PostRequest
   func alamofirePost(parameter : NSDictionary , urlString : String, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
       Alamofire.request(urlString, method: .post, parameters: parameter as? Parameters , headers: nil).responseJSON { (response:DataResponse<Any>) in
                print(response.result)
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        let dict  =  response.result.value as! NSDictionary
                        completionHandler(dict, nil)
                        print(dict)
                        }
                    break
                case .failure(_):
                    FTIndicator.showError(withMessage:"Unable to find the result")
                    

                    break
                }
            }
        
    }
    //GetRequest
    func alamofireGet(urlString:String,completionHandler:@escaping(AnyObject)-> ()){
       
            Alamofire.request(urlString).responseJSON{ response in // method defaults to `.get`
                debugPrint(response)
                print(response)
                switch(response.result){
                case .success(_):
                    if let JSON = response.result.value {
                        completionHandler(JSON as AnyObject)
                    }
                    break
                case .failure(_):
                    FTIndicator.showError(withMessage:"Unable to find the result")
                    break
                }
            }
    }
    //MARK:- Api's
    //login
    func login(parameters: NSDictionary, completionHandler closure: @escaping (_ success: Bool,_ user: User?, _ message: String?) -> Void) {
        if URL(string: userLoginURL) != nil {
            print(parameters)
            print(userLoginURL)
            self.alamofirePost(parameter: parameters, urlString:  userLoginURL, completionHandler: { (result, error) -> Void in
                var success = false
                var message: String?
                var user: User?
                let status = result?["response"] as! String
                if  status == "1" {
                    success = true
                    let dict  = result?["data"] as? [String: AnyObject]
                    user = self.getUser(dict!)
                }
                else {
                    let status = result?["response"] as! String
                    print(status )
                    message = result?["mesg"] as? String;
                }
                closure(success,user,message);
            })
        }
    }
    //login
    func signUp(parmeters:[String: String],image:UIImage?, completionHandler closure: @escaping (_ success: Bool,_ user: User?,  _ message: String?) -> Void) {
        if URL(string: userSignUpURL) != nil {
            print(parmeters)
            self.uploadTaskFor(URLString: userSignUpURL, parameters: parmeters, forImage: image, imageKey:"image" , completion:  { (result) -> Void in
                var success = false
                var message: String?
                var user: User?
            let status = result["response"] as! String
                if  status == "1" {
                    success = true
                    let dict  = result["data"] as? [String: AnyObject]
                   user = self.getUser(dict!)
                  
                }
                else {
                    let status = result["response"] as! String
                    print(status )
                    message = result["mesg"] as? String;
                }
                closure( success, user ,message);
            })
        }
    }
    //ForgotPassword
    func forgotPassword(parameter:NSDictionary, completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
        if URL(string: forgotpasswordURL) != nil {
        self.alamofirePost(parameter: parameter, urlString:  forgotpasswordURL, completionHandler: { (result, error) -> Void in
                var success = false
                var message: String?
                let status = result?["response"] as! String
                if  status == "1" {
                    success = true
                    message = result?["mesg"] as? String
                } else {
                    message = result?["mesg"] as? String
                }
                closure(success, message)
            })
        } else {
            closure(false, failedURLMessage)
        }
    }
    //Logot
    func logout(completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
        if URL(string: logoutURL) != nil {
            let userid = Singleton.sharedInstance.user.id
            let dict = ["user_id": userid]
            self.alamofirePost(parameter: dict as NSDictionary, urlString:  logoutURL, completionHandler: { (result, error) -> Void in
                var success = false;
                var message: String?;
                let status = result?["response"] as? String
                if  status == "1" {
                    success = true;
                    message = result?["mesg"] as? String
                } else {
                    message = result?["mesg"] as? String
                }
                closure(success, message)
            })
        } else {
            closure(false, failedURLMessage)
        }
    }
    
    //login
    func updateProfile(parmeters:[String: String],image:UIImage?, completionHandler closure: @escaping (_ success: Bool,_ user: User?,  _ message: String?) -> Void) {
        if URL(string: updateProfileURL) != nil {
            print(parmeters)
            self.uploadTaskFor(URLString: updateProfileURL, parameters: parmeters, forImage: image, imageKey:"image" , completion:  { (result) -> Void in
                var success = false
                var message: String?
                var user: User?
                let status = result["response"] as! String
                if  status == "1" {
                    success = true
                    let dict  = result["data"] as? [String: AnyObject]
                    user = self.getUser(dict!)
                    
                }
                else {
                    let status = result["response"] as! String
                    print(status )
                    message = result["mesg"] as? String;
                }
                closure( success, user ,message);
            })
        }
    }
    //UpdateToken
   func updateToken(_ devicetoken: String, completionHandler closure: @escaping ( _ success: Bool) -> Void) {
        if URL(string: updateDeviceURL) != nil {
            let userId = Singleton.sharedInstance.user.id
            let queryString = updateDeviceURL + "user_id=\(userId!)"  + "&token=\(String(describing: Singleton.sharedInstance.deviceToken!))" ;
            print(queryString)
            self.alamofirePost(parameter: [:], urlString:  queryString, completionHandler: { (result, error) -> Void in
                var success = false
                let status = result?["response"] as! String
                if  status == "1" {
                    success = true
                    
                }
                else {
                    success = false
                }
                closure(success );
            })
        }
    }
   //UpdatePassword
    func changePassword(parameters:NSDictionary,  completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
        if URL(string: changePasswordURL) != nil {
            
             self.alamofirePost(parameter: parameters, urlString:  changePasswordURL, completionHandler: { (result, error) -> Void in
                var success = false;
                var message: String?;
                let status = result?["response"] as? String
                if  status == "1" {
                    success = true;
                    message = result?["mesg"] as? String
                } else {
                    message = result?["mesg"] as? String
                }
                closure(success, message)
            })
        } else {
            closure(false, failedURLMessage)
        }
    }
    //MARK- Setting Api's
    //Aboutus
    func aboutUs( completionHandler closure:@escaping (_ sucess:Bool, _ data:NSDictionary, _ message:String? ) -> Void){
            
            if URL(string: aboutUsURl) != nil {
                self.alamofireGet(urlString: aboutUsURl, completionHandler: { result in
                    var success = false
                    var message: String?
                    var data = NSDictionary()
                    let status = result["response"] as? String
                    if  status == "1" {
                        success = true
                         data  = (result["data"] as? NSDictionary)!
                        message = result["mesg"] as? String;
                    }
                    else {
                       
                          message = result["mesg"] as? String;
                    }
                    closure( success, data, message)
                })
            }
        }
    //Privacy 
    func getprivacy( completionHandler closure:@escaping (_ sucess:Bool, _ data:NSDictionary, _ message:String? ) -> Void){
        
        if URL(string: privacyPolicyURl) != nil {
            self.alamofireGet(urlString: privacyPolicyURl, completionHandler: { result in
                var success = false
                var message: String?
                var data = NSDictionary()
                let status = result["response"] as? String
                if  status == "1" {
                    success = true
                    data  = (result["data"] as? NSDictionary)!
                    message = result["mesg"] as? String;
                }
                else {
                    
                    message = result["mesg"] as? String;
                }
                closure( success, data, message)
            })
        }
    }
    //Private
   //GetUser
    fileprivate func getUser(_ dict: [String: AnyObject])  -> User {
        let user = User(id:  dict["id"] as? String ?? "", name: dict["name"] as? String ?? "", email: dict["email"] as? String ?? "", userImageUrlString: dict["image"] as? String ?? "")
        return user
    }
    //GetSection
    /*
    fileprivate func getSection(_ array: [NSDictionary]) -> [Section] {
        var sections = [Section]()
        for item in array{
            let Menu = item.object(forKey: "Menu") as! NSDictionary
            let items = item.object(forKey: "Item") as! [NSDictionary]
            let section = Section(name: Menu["name"] as? String ?? "", id:Menu["id"] as? String ?? "", items:getItems(items
            ))
        sections += [section]
            
        }
        return sections
    }
    //getItemunderSection
    fileprivate func getItems(_ array: [NSDictionary]) -> [Item] {
        var items = [Item]()
        for item in array{
            let item = Item(name:item["name"] as? String ?? "", price:item["price"] as? String ?? "", id:item["id"] as? String ?? "", menu_id: item["menu_id"] as? String ?? "", image: item["image"] as? String ?? "")
                items += [item]
            }
        return items
    }*/
    
}

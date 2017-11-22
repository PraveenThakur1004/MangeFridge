//
//  WebserviceManager.swift


import UIKit
import Foundation
import Alamofire
import FTIndicator
//MARK:-BaseUrls
let baseUrl = "http://fridgebit.com/admin/api/apis/"
class WebserviceManager: NSObject{
    //MARK:- Constant BaseUrl+taskUrl
    //Basic
    let userLoginURL = baseUrl + "login"
    let userSignUpURL = baseUrl + "registerUser"
    let forgotpasswordURL = baseUrl + "forgetPassword"
    let changePasswordURL = baseUrl + "updatePassword"
    let updateDeviceURL = baseUrl + "updateToken?"
    let logoutURL = baseUrl + "logout"
    let updateProfileURL = baseUrl + "updateProfile"
    //SlideMenu
    let getIngredientsURL = baseUrl + "getIngr"
    let getFiltersURL = baseUrl + "getFilter"
    let searchURL = baseUrl + "searchrecp"
    let getUserFavouriteRecipeURL = baseUrl + "favList"
    let getTopRatedURL = baseUrl + "topRecp?"
    let getDrinksRecipeURL = baseUrl + "drinkrecp"
    let getFoodRecipeURL = baseUrl + "foodrecp?"
    let getRecipeDetailURL = baseUrl + "recpDetail"
    //Detail
    let getAllReviewsURL = baseUrl + "allReview"
    let giveRatingAndReviewURL = baseUrl + "giverating"
    let addFavURL = baseUrl + "favoriterecp"
    //MARK:-Almofire base requests
    //singleImage Multipart
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
    //MARK:- Base Api's
    //login
    func login(parameters: NSDictionary, completionHandler closure: @escaping (_ success: Bool,_ user: User?, _ message: String?) -> Void) {
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
    //SignUp
    func signUp(parmeters:[String: String],image:UIImage?, completionHandler closure: @escaping (_ success: Bool,_ user: User?,  _ message: String?) -> Void) {
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
    //ForgotPassword
    func forgotPassword(parameter:NSDictionary, completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
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
        }
    //Logout
    func logout(completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
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
        }
    //updateuser profile
    func updateProfile(parmeters:[String: String],image:UIImage?, completionHandler closure: @escaping (_ success: Bool,_ user: User?,  _ message: String?) -> Void) {
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
    //UpdatePassword
    func changePassword(parameters:NSDictionary,  completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
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
    }
    //MARK: - Menu Request Api's
    //Get Ingredients
    func getIngredients( completionHandler closure:@escaping (_ sucess:Bool, _ data:[Ingredients]) -> Void){
        self.alamofirePost(parameter: [:], urlString:  getIngredientsURL, completionHandler: { (result, error) -> Void in
            var success = false
            var ingerdients = [Ingredients]()
            let status = result?["response"] as? String
            if  status == "1" {
                success = true
                let data  = (result?["data"] as? [NSDictionary])!
                ingerdients = self.getIngredient(data)
            }
            closure(success, ingerdients)
        })
        
    }
    //Get Ingredients
    func getFilters( completionHandler closure:@escaping (_ sucess:Bool, _ data:[Ingredients]) -> Void){
        self.alamofirePost(parameter: [:], urlString:  getFiltersURL, completionHandler: { (result, error) -> Void in
            var success = false
            var ingerdients = [Ingredients]()
            let status = result?["response"] as? String
            if  status == "1" {
                success = true
                let data  = (result?["data"] as? [NSDictionary])!
                ingerdients = self.getFilters(data)
            }
            closure(success, ingerdients)
        })
        
    }
    //Search On basis of Ingredients and Filters
    func searchIngredents(parameters: NSDictionary, completionHandler closure: @escaping (_ success: Bool,_ item: [Item], _ message: String?) -> Void) {
        self.alamofirePost(parameter: parameters, urlString:  searchURL, completionHandler: { (result, error) -> Void in
            var success = false
            var message: String?
            var items = [Item]()
            let status = result?["response"] as! String
            if  status == "1" {
                success = true
                let dict  = result?["data"] as? [NSDictionary]
                items = self.getItems(dict!)
            }
            else {
                let status = result?["response"] as! String
                print(status )
                message = result?["mesg"] as? String;
            }
            closure(success,items,message);
        })
    }
    //GetDrinksRecipe
    func getDrinksRecipe(completionHandler closure: @escaping (_ success: Bool,_ item: [Item], _ message: String?) -> Void) {
        var parameters:NSDictionary = [:]
        if Singleton.sharedInstance.guestUser == false{
            if let id = Singleton.sharedInstance.user.id{
                parameters = ["user_id":id]
            }
            else{
                FTIndicator.showError(withMessage: "User not exist")
                return
            }
            
        }
        self.alamofirePost(parameter: parameters, urlString:  getDrinksRecipeURL, completionHandler: { (result, error) -> Void in
            var success = false
            var message: String?
            var items = [Item]()
            let status = result?["response"] as! String
            if  status == "1" {
                success = true
                let dict  = result?["data"] as? [NSDictionary]
                items = self.getItems(dict!)
            }
            else {
                let status = result?["response"] as! String
                print(status )
                message = result?["mesg"] as? String;
            }
            closure(success,items,message);
        })
    }
    //GetFoodRecipe
    func getFoodRecipe(completionHandler closure: @escaping (_ success: Bool,_ item: [Item], _ message: String?) -> Void) {
        var parameters:NSDictionary = [:]
        if Singleton.sharedInstance.guestUser == false{
            if let id = Singleton.sharedInstance.user.id{
                parameters = ["user_id":id]
            }
            else{
                FTIndicator.showError(withMessage: "User not exist")
                return
            }
            
        }
        self.alamofirePost(parameter: parameters, urlString:  getFoodRecipeURL, completionHandler: { (result, error) -> Void in
            var success = false
            var message: String?
            var items = [Item]()
            let status = result?["response"] as! String
            if  status == "1" {
                success = true
                let dict  = result?["data"] as? [NSDictionary]
                items = self.getItems(dict!)
            }
            else {
                let status = result?["response"] as! String
                print(status )
                message = result?["mesg"] as? String;
            }
            closure(success,items,message);
        })
    }
    //GetTopRatedRecipe
    func getTopRatedRecipe(completionHandler closure: @escaping (_ success: Bool,_ item: [Item], _ message: String?) -> Void) {
        var parameters:NSDictionary = [:]
        if Singleton.sharedInstance.guestUser == false{
            if let id = Singleton.sharedInstance.user.id{
                parameters = ["user_id":id]
            }
            else{
                FTIndicator.showError(withMessage: "User not exist")
                return
            }
            
        }
        self.alamofirePost(parameter: parameters, urlString:  getTopRatedURL, completionHandler: { (result, error) -> Void in
            var success = false
            var message: String?
            var items = [Item]()
            let status = result?["response"] as! String
            if  status == "1" {
                success = true
                let dict  = result?["data"] as? [NSDictionary]
                items = self.getFavTopRatedItems(dict!)
            }
            else {
                let status = result?["response"] as! String
                print(status )
                message = result?["mesg"] as? String;
            }
            closure(success,items,message);
        })
    }
    //GetFavouriteRecipe
    func getFavouriteRecipe(completionHandler closure: @escaping (_ success: Bool,_ item: [Item], _ message: String?) -> Void) {
        var parameters:NSDictionary
        if let id = Singleton.sharedInstance.user.id{
            parameters = ["user_id":id]
        }
        else{
            FTIndicator.showError(withMessage: "User not exist")
            return
        }
        self.alamofirePost(parameter: parameters, urlString:  getUserFavouriteRecipeURL, completionHandler: { (result, error) -> Void in
            var success = false
            var message: String?
            var items = [Item]()
            let status = result?["response"] as! String
            if  status == "1" {
                success = true
                let dict  = result?["data"] as? [NSDictionary]
                items = self.getFavTopRatedItems(dict!)
            }
            else {
                let status = result?["response"] as! String
                print(status )
                message = result?["mesg"] as? String;
            }
            closure(success,items,message);
        })
    }
    //MARK:- Detail Page Api's
    //GetAllReivews on Recipe
     func getAllReviews(recipeId:String, completionHandler closure: @escaping (_ success: Bool,_ item: [NSDictionary], _ message: String?) -> Void) {
        let parameters:NSDictionary = ["recipe_id":recipeId]
        self.alamofirePost(parameter: parameters, urlString:  getAllReviewsURL, completionHandler: { (result, error) -> Void in
            var success = false
            var message: String?
            var items = [NSDictionary]()
            let status = result?["response"] as! String
            if  status == "1" {
                success = true
                items  = result?["data"] as! [NSDictionary]
            }
            else {
                let status = result?["response"] as! String
                print(status )
                message = result?["mesg"] as? String;
            }
            closure(success,items,message);
        })
    }
    //Give Rating and Reviws to recipe
    func rateAndReview(parameters:NSDictionary,  completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
       self.alamofirePost(parameter: parameters, urlString:  giveRatingAndReviewURL, completionHandler: { (result, error) -> Void in
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
        
    }
    //Add Recipe to favourite list
    func addToFavourite(parameters:NSDictionary,  completionHandler closure: @escaping (_ success: Bool, _ message: String?) -> Void) {
        print(parameters)
        self.alamofirePost(parameter: parameters, urlString:  addFavURL, completionHandler: { (result, error) -> Void in
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
        
    }
    //MARK:- Model Setup
    //SetUp user model
    fileprivate func getUser(_ dict: [String: AnyObject])  -> User {
        let user = User(id:  dict["id"] as? String ?? "", name: dict["name"] as? String ?? "", email: dict["email"] as? String ?? "", userImageUrlString: dict["image"] as? String ?? "")
        return user
    }
    //Ingredients
    fileprivate func getIngredient(_ array: [NSDictionary]) -> [Ingredients] {
        var ingredients = [Ingredients]()
        for value in array{
            let ingredient = value["Ingredient"] as? NSDictionary
            let value = Ingredients(name:ingredient!["name"] as? String ?? "", id:ingredient!["id"] as? String ?? "")
            ingredients += [value]
        }
        return ingredients
    }
    //Filters
    fileprivate func getFilters(_ array: [NSDictionary]) -> [Ingredients] {
        var filters = [Ingredients]()
        for value in array{
            let filter = value["Filter"] as? NSDictionary
            let value = Ingredients(name:filter!["name"] as? String ?? "", id:filter!["id"] as? String ?? "")
            filters += [value]
        }
        return filters
    }
    //Items
    fileprivate func getItems(_ array: [NSDictionary]) -> [Item] {
        var items = [Item]()
        for value in array{
            let item = value["Recipe"] as! NSDictionary
            var totalReviews = "0"
            if let value = item["totalReviews"] as? Float {
                print("\(value)")
                totalReviews = String(format:"%.0f", value)
            }
            let category = value["Category"] as! NSDictionary
            let ingredients = value["Ingredient"] as! [NSDictionary]
            let value = Item(id:item["id"] as? String ?? "", name:item["name"] as? String ?? "", duration:item["time_duration"] as? String ?? "", category:category["name"] as? String ?? "", image: item["image"] as? String ?? "", description: item["description"] as? String ?? "", favoritestatus: item["favourite"] as? String ?? "", ingredients: getCommasepratedIngredents(array: ingredients), review: totalReviews, ratings: item["rating"] as? String ?? "")
            items += [value]
        }
        return items
    }
    //Favourite and top rated model
    fileprivate func getFavTopRatedItems(_ array: [NSDictionary] ) -> [Item] {
        var items = [Item]()
        for value in array{
            let item = value["Recipe"] as! NSDictionary
            let category = item["Category"] as! NSDictionary
            let ingredients = value["Ingredient"] as! [NSDictionary]
            let value = Item(id:item["id"] as? String ?? "", name:item["name"] as? String ?? "", duration:item["time_duration"] as? String ?? "", category:category["name"] as? String ?? "", image: item["image"] as? String ?? "", description: item["description"] as? String ?? "", favoritestatus: item["favourite"] as? String ?? "1", ingredients: getCommasepratedIngredents(array: ingredients), review: item["totalReviews"] as? String ?? "", ratings: item["rating"] as? String ?? "")
            items += [value]
        }
        return items
    }
    fileprivate func getCommasepratedIngredents(array:[NSDictionary]) -> String{
        var ingredients = ""
        for value in array{
            let ingredient = value["Ingredient"] as? NSDictionary
            if ingredients != ""{
                ingredients = ingredients + ",\(String(describing: ingredient!["name"]!) )"
            }else{
                ingredients = String(describing: ingredient!["name"]!)
                print(ingredients)
            }
        }
        
        return ingredients
    }
}


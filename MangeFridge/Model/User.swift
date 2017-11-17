//
//  User.swift

//

import Foundation
class User: NSObject {
    //MARK:-Variable and Constant
    var id: String?;
    var name: String?;
    var email: String?;
    var userImageUrlString : String?
    //MARK:- Initialization
    init(id:String,name: String, email: String,userImageUrlString:String) {
        self.id = id
        self.userImageUrlString = userImageUrlString
        self.name = name;
        self.email = email;
        }
    func asDictionary() -> [String: String] {
       return ["name": name!, "email": email!, "image": userImageUrlString!,"id":id!];
    }
    
}
        

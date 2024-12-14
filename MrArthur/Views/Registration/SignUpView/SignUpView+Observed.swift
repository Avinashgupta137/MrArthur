//
//  SignUpView+Observed.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import Foundation
import SwiftUI

extension SignUpView{
    
    class Observed:ObservableObject{
        
       
        func loginAPICall(param:[String:Any],completion:@escaping(String?)->()){
            var errormsg = ""
          
        
            
            LoginAPICall().apiCall(parameter: param) { errmsg in
                errormsg = errmsg ?? ""
                if(errormsg.count == 0){
                DispatchQueue.main.async {
                  //  self.launchresponse = welcome!
                   
                    }
                 //   welcomeobjobeserved = Welcome.init(token: welcome?.token, user: welcome?.user)
                }


            completion(errormsg)
             
            }
          
            
            
        }
    }
}

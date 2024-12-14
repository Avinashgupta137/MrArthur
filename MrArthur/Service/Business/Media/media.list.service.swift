//
//  media.list.sercie.swift
//  MrArthur
//
//  Created by IPS-169 on 17/09/22.
//

import Foundation
class MediaService{
    
    static func getList(completion:@escaping(Bool, String?, GetMediaListResponseModel?)->()){
        GetMediaListAPICall().getList { staus,message, mediaListReponse  in
            completion(staus,message,mediaListReponse)
        }
    }
}

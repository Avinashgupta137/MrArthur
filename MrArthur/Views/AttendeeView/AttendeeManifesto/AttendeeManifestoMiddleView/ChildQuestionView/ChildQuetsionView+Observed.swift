//
//  QuestionScreenView+Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 14/07/22.
//

import Foundation
import SwiftUI
extension ChildQuetsionView{
    
    
    class Observed:ObservableObject{
        
        @Published var questionState:StateOfQuestion = StateOfQuestion.answerpending
        
        @Published var onbordingresponse = OnbordingResponse()
       
        @Published var selectedChildQuestion:Answer = Answer.init(id: 0, question: "", answer: [AnswerValue](),backendanswer: [""])
        
        @AppStorage("selectedChildAnswer", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var selectedstrchildAnswer : String = ""
        
//        @AppStorage("arrOFChildQuestion", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var arrofChildQuestiondata : Data =  Data()
        
    
        
        func fetchChildAnwserList(stepname:String,anwser:[String],completion:@escaping(String?,OnbordingResponse?)->()){
           
            let param = ["stepName":stepname,"answerList":anwser] as [String : Any]
            QuestionListAPICall().childAnsweredAPICall(parameter: param) { errormsg, welcome in
               
                var onboardingresponse = OnbordingResponse.init(name: "", type: "", category: "", updatedAt: "")
                if(errormsg?.count == 0){
                                    DispatchQueue.main.async {
                                        if let onbordingresponseobj = welcome  as? OnbordingResponse{
                                        onboardingresponse = OnbordingResponse.init(name: onbordingresponseobj.name, type: onbordingresponseobj.type, category: onbordingresponseobj.category, updatedAt: onbordingresponseobj.updatedAt)
                                        }
                                        }
                                  
                                    
                
                    
                                completion(errormsg,onboardingresponse)

                }else{
                    completion(errormsg,onboardingresponse)
                }

        }
    }
        
       

        func load<T: Decodable>(_ filename: String) -> T {
            let data: Data

            guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
                else {
                    fatalError("Couldn't find \(filename) in main bundle.")
            }

            do {
                data = try Data(contentsOf: file)
            } catch {
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
            }

            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
            }
        }
        func loadDatajson(_ filename: String) -> Any? {
            let data: Data

            guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
                else {
                    fatalError("Couldn't find \(filename) in main bundle.")
            }
            
            do {
                data = try Data(contentsOf: file)
            } catch {
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
            }

            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            } catch let myJSONError {
                print(myJSONError)
            }
           
            return nil
           
        }
}
}

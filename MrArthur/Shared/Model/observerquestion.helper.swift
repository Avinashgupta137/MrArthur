//
//  ObserverQuestionHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 26/07/22.
//

import Foundation
import SwiftUI

class ObserverQuestionHelper: ObservableObject{
    @Published var selectedQuestion:AnswerModel = AnswerModel(id: 0, question: "", answer: [AnswerValueModel](),backendAnswer: [""])
    @Published var questionState:StateOfQuestion = StateOfQuestion.answerPending
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    
    func deSelectAll(){
        for i in 0...selectedQuestion.answer.count - 1{
            var changableAnwser = selectedQuestion.answer[i]
            changableAnwser.isActive = false
            selectedQuestion.answer.remove(at: i)
            selectedQuestion.answer.insert(changableAnwser, at: i)
        }
    }
    
    func getListOfQuestions(questionIndex:Int){
        let answers: [AnswerModel] = load("Question_Parent.json")
        let arrofQuestion = UtilityMethod().getValueForKey(key: ConstantOfApp.kArrOfQuestion) as? [[String:Any]] ?? [[String:Any]]()
        if(arrofQuestion.count == 0){
            if let arrOfQuestions = loadDataJson("Question_Parent.json") as? [[String:Any]]{
                UtilityMethod().saveInDefault(value: arrOfQuestions, key: ConstantOfApp.kArrOfQuestion)
            }
        }else{
            UtilityMethod().saveInDefault(value: arrofQuestion, key: ConstantOfApp.kArrOfQuestion)
        }
        
        selectedQuestion = answers[questionIndex]
        
        if let id = selectedQuestion.id, id == 9 {
            let prevQues = answers[questionIndex - 1]
            if let prevAns = UtilityMethod().getQuestion(
                key: ConstantOfApp.kSelectedQuestion + "\(prevQues.id ?? 0)"
            )?.selectedAnswer {
                var currentAnsList = selectedQuestion.answer
                if let index = currentAnsList.firstIndex(where: {$0.ans.lowercased() == prevAns.lowercased()}) {
                    currentAnsList.remove(at: index)
                    selectedQuestion.answer = currentAnsList
                }
            }
        }
        
        UtilityMethod().saveQuestion(question: selectedQuestion, key: ConstantOfApp.kCurrentQuestion)
        self.getAnswerList()
    }
    
    private func getAnswerList() {
        if let selectedQuestion = UtilityMethod().getQuestion(key: ConstantOfApp.kSelectedQuestion + "\(selectedQuestion.id ?? 0)"){
            var tempAnsList = selectedQuestion.answer
            tempAnsList = self.selectedQuestion.answer
            if let index = tempAnsList.firstIndex(where: {$0.ans == selectedQuestion.selectedAnswer}) {
                self.selectedQuestion.answer[index].isActive = true
                questionState = .answerGiven
            } else {
                questionState = .answerPending
            }
        } else {
            questionState = .answerPending
        }
    }
    
    func getListOfAttendeeQuestions(questionIndex:Int){
        let answers: [AnswerModel] = load("Question_attendee.json")
        let arrofQuestion = UtilityMethod().getValueForKey(key: ConstantOfApp.kArrOfAttendeeQuestion) as? [[String:Any]] ?? [[String:Any]]()
        if(arrofQuestion.count == 0 || observerManifestoObservedObject.currentIndex == 3){
            if let arrOfQuestions = loadDataJson("Question_attendee.json") as? [[String:Any]]{
                
                UtilityMethod().saveInDefault(value: arrOfQuestions, key: ConstantOfApp.kArrOfAttendeeQuestion)
                
            }
        }else{
            UtilityMethod().saveInDefault(value: arrofQuestion, key: ConstantOfApp.kArrOfAttendeeQuestion)
            
        }
        selectedQuestion = answers[questionIndex]
        UtilityMethod().saveQuestion(question: selectedQuestion, key: ConstantOfApp.kCurrentAttendeeQuestion)
        if let selectedQuestion = UtilityMethod().getQuestion(key: ConstantOfApp.kSelectedQuestion + "\(selectedQuestion.id ?? 0)"){
            if let index = selectedQuestion.answer.firstIndex(where: {$0.answer == selectedQuestion.selectedAnswer}) {
                self.selectedQuestion.answer[index].isActive = true
            }
            if(selectedQuestion.selectedAnswer?.count == 0){
                questionState = .answerPending
                
            }else if(selectedQuestion.selectedAnswer?.count ?? 0 > 0){
                questionState = .answerGiven
            }
        }else{
            questionState = .answerPending
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
    func loadDataJson(_ filename: String) -> Any? {
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


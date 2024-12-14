//
//  QuestionHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 26/07/22.
//

import Foundation
import SwiftUI

class AttendeeQuestionHelper:ObservableObject{
    @Published var selectedAttendeeQuestion:AnswerModel = AnswerModel.init(id: 0, question: "", answer: [AnswerValueModel](),backendAnswer: [""])
    @Published var attendeeQuestionState:StateOfQuestion = StateOfQuestion.answerPending
    @EnvironmentObject private var attendeeManifestoObservedObject: AttendeeManifestoObserver
    func deSelectAll(){
        for i in 0...selectedAttendeeQuestion.answer.count - 1{
            var changableAnwser = selectedAttendeeQuestion.answer[i]
            changableAnwser.isActive = false
            selectedAttendeeQuestion.answer.remove(at: i)
            selectedAttendeeQuestion.answer.insert(changableAnwser, at: i)
        }
    }
    func getListOfattendeeQuestions(questionIndex:Int){
        let answers: [AnswerModel] = load("Question_attendee.json")
        let arrofQuestion = UtilityMethod().getValueForKey(key: ConstantOfApp.kArrOfAttendeeQuestion) as? [[String:Any]] ?? [[String:Any]]()
        if(arrofQuestion.count == 0){
            if let arrOfQuestions = loadDataJson("Question_attendee.json") as? [[String:Any]]{
                
                UtilityMethod().saveInDefault(value: arrOfQuestions, key: ConstantOfApp.kArrOfAttendeeQuestion)
            }
        }else{
            UtilityMethod().saveInDefault(value: arrofQuestion, key: ConstantOfApp.kArrOfAttendeeQuestion)
            
        }
        selectedAttendeeQuestion = answers[questionIndex]
        
        if let id = selectedAttendeeQuestion.id, id == 2 {
            let prevQues = answers[questionIndex - 1]
            if let prevAns = UtilityMethod().getQuestion(
                key: ConstantOfApp.kSelectedAttendeeQuestion + "\(prevQues.id ?? 0)"
            )?.selectedAnswer {
                var currentAnsList = selectedAttendeeQuestion.answer
                if let index = currentAnsList.firstIndex(where: {$0.ans.lowercased() == prevAns.lowercased()}) {
                    currentAnsList.remove(at: index)
                    selectedAttendeeQuestion.answer = currentAnsList
                }
            }
        }
        
        UtilityMethod().saveQuestion(question: selectedAttendeeQuestion, key: ConstantOfApp.kCurrentAttendeeQuestion)
        self.getAttendeeAnswerList()
    }
    
    private func getAttendeeAnswerList() {
        if let selectedquestion = UtilityMethod().getQuestion(key: ConstantOfApp.kSelectedAttendeeQuestion + "\(selectedAttendeeQuestion.id ?? 0)"){
            var tempAnsList = selectedquestion.answer
            tempAnsList = self.selectedAttendeeQuestion.answer
            if let index = tempAnsList.firstIndex(where: {$0.answer ==  selectedquestion.selectedAnswer}) {
                selectedAttendeeQuestion.answer[index].isActive = true
                attendeeQuestionState = .answerGiven
            } else{
                attendeeQuestionState = .answerPending
            }
        }else{
            attendeeQuestionState = .answerPending
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


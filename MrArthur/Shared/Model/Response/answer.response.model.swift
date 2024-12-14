//
//  Answer.swift
//  MrArthur
//
//  Created by Troo on 13/07/22.
//

import Foundation


struct AnswerListModel: Codable {
    var answer: [AnswerModel]?
}

struct AnswerModel: Codable, Identifiable {
    var id: Int?
    var question: String?
    var answer : [AnswerValueModel]
    var backendAnswer: [String]
    var selectedAnswer: String?
    /// custom varaibel
    var givenAnswer: String? {
        if let saved = getSavedQuestion() {
            return saved.selectedAnswer
        }
        return nil
    }
    
    var answerGiven: Bool {
        return givenAnswer != nil && givenAnswer != ""
    }
    
    var quesAnswers: [AnswerValueModel] {
        var tempAnswers = answer
        if let id = id, id == 9 {
            tempAnswers = getAnswerListForQuestionID9(answerList: tempAnswers)
        }
        if let givenAnswer = givenAnswer {
            if let index = tempAnswers.firstIndex(where: {$0.ans == givenAnswer}) {
                tempAnswers[index].isActive = true
            }
        }
        return tempAnswers
    }

    private func getAnswerListForQuestionID9(answerList: [AnswerValueModel]) -> [AnswerValueModel] {
        var tempAnswers = answerList
        if let model = UserDefaultsHelper.getQuestionForID(9) {
            tempAnswers = model.answer
        }
        if let ques8Answer = getSelectedAnswerForQuesID8() {
            if let index = tempAnswers.firstIndex(where: {$0.ans == ques8Answer}) {
                let ans = tempAnswers[index].ans
                if ans == givenAnswer {
                    UserDefaultsHelper.removeQuestionForID(id ?? 0)
                }
                tempAnswers.remove(at: index)
            }
        }
        return tempAnswers
    }
    
    private func getSelectedAnswerForQuesID8() -> String? {
        if let model = UserDefaultsHelper.getQuestionForID(8) {
            return model.quesAnswers.first(where: {$0.isActive})?.ans
        }
        return nil
    }
    
    private func getSavedQuestion() -> AnswerModel? {
        return UserDefaultsHelper.getQuestionForID(id ?? 0)
    }
}
struct AnswerValueModel:Codable{
    var answer:String?
    var isSelected: Bool?
    var ans: String {
        return answer ?? ""
    }
    var isActive: Bool {
        get {
            return isSelected ?? false
        }
        set {
            isSelected = newValue
        }
    }
}

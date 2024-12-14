//
//  ChildQuetsionView.swift
//  MrArthur
//
//  Created by IPS-169 on 02/08/22.
//

import SwiftUI

struct ChildQuetsionView: View {
   
    @Binding var questionState:StateOfQuestion
    let  questionIndex:Int
    @State var selectedAnswer = false
    @State var isActive = false
    
    //observed object
    @StateObject private var observed = Observed()
    @StateObject private var observedquestion = ChildQuestionHelper()
    
    
    // For Loader
    @EnvironmentObject private var loaderObserver: LoaderObserver
    
    //For Toast
    @State private var showToast = false
    @State var strToastMessage = ""
    @Binding var pageIndex: Int
    
    let arrofscreenname = UtilityMethod().getvalueforkey(key: ConstantOfApp.kscreenNameList) as? [String] ?? [String]()
    
   
    @AppStorage("progressvalue", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var progressvalue : Double = 0.0
    @AppStorage("selectedAnswer", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var selectedstrAnswer : String = ""
    @AppStorage("arrOFChildQuestion", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var arrofChildQuestiondata : Data =  Data()
    
    
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                
                Text(observedquestion.selectedChildQuestion.question ?? "")
                    .fontModifier(font: .montserratBold, size: iPhoneFont25)
                    .frame(width: UIScreen.screenWidth - 32, alignment: .leading)
                    .padding(.bottom, 35)
                
                VStack(spacing: 16){
                    
                    ForEach(0..<observedquestion.selectedChildQuestion.answer.count, id: \.self) { i in
                        
                        AnswerTileView(
                            isActiveAnswer: $observedquestion.selectedChildQuestion.answer[i].isActive,
                            title: observedquestion.selectedChildQuestion.answer[i].answer,
                            onTap: {
                                loaderObserver.showLoader = true
                                
                                observedquestion.childquestionState = .answergiving
                                questionState = .answergiving
                                setSelection()
                                selectedstrAnswer = observedquestion.selectedChildQuestion.answer[i].answer
                                self.saveanswerinUSerDefault(answer: selectedstrAnswer)
                                let arrOfScreenName = UtilityMethod().getvalueforkey(key: ConstantOfApp.karrOfChildScreenList) as? [String] ?? [String]()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    observed.fetchChildAnwserList(stepname: arrOfScreenName[pageIndex], anwser: observedquestion.selectedChildQuestion.backendanswer) { error, obj in
                                        if(error?.count ?? 0 > 0){
                                            print("result is = \(String(describing: obj)),error is = \(String(describing: error))")
                                            loaderObserver.showLoader = false
                                            strToastMessage = error ?? ""
                                            showToast = true
                                        }else{
                                            progressvalue += ProgressBar.widthOfProgerss / CGFloat(arrofscreenname.count)
                                            pageIndex += 1
                                          //  childscreenno += 1
                                          
                                            
                                            observedquestion.selectedChildQuestion.selectedAnswer = observedquestion.selectedChildQuestion.answer[i].answer
                                            UtilityMethod().saveQuestion(question: observedquestion.selectedChildQuestion, key: ConstantOfApp.kselectedChildQuestion + "\(observedquestion.selectedChildQuestion.id ?? 0)")
                                            //                                    UtilityMethod().saveQuestion(question: observed.selectedQuestion, key: ConstantOfApp.kselectedQuestion + "\(observed.selectedQuestion.id ?? 0)")
                                            
                                       //     UtilityMethod().saveindefault(value: childscreenno, key: ConstantOfApp.kchildscreenno)
                                            questionState = .none
                                            loaderObserver.showLoader = false
                                            self.isActive = true
                                            
                                        }
                                    }
                                }
                            })
                        
                    }
                }
                
                Spacer()
            }
            .padding(.top, isiPad() ? 80 : 50)
            NavigationLink(destination: Manifesto(), isActive: $isActive, label: {})
                .labelsHidden()
        }.toast(message: strToastMessage,
                isShowing: $showToast,
                duration: Toast.short)
            .statusBarStyle(color: .statusBarColor)
            .fullScreenFrame
            .background(
                Group {
                    if (!selectedAnswer) {
                        LinearGradient(colors: [Color.primaryRed, Color.thirdRed],
                                       startPoint: .top,
                                       endPoint: .center)
                    } else {
                        LinearGradient(gradient: Gradient(colors: [.primaryBlue, .thirdRed]), startPoint: .top, endPoint: .bottomTrailing)
                    }
                }
            )
            .onAppear(){
                print("selected answe is = \(selectedstrAnswer) in questionview on appear")
                observedquestion.getListOfChildQuestions(questionIndex: questionIndex)
                questionState = observedquestion.childquestionState
                setSelection()
            }
            .hideNavigation
    }
    
    private func setSelection() {
        switch questionState {
        case .answerpending, .none:
            selectedAnswer = false
        case .answergiving:
            selectedAnswer = true
        case .answergiven:
            selectedAnswer = true
        }
    }
    
    func saveanswerinUSerDefault(answer:String){
        if let arrofQuestionfromdefault = APIHelper.dataToJSON(data: arrofChildQuestiondata) as? [[String:Any]]{
            var arrOfQuestion = arrofQuestionfromdefault
            var selectedQuestiondic =  arrOfQuestion[questionIndex]
            selectedQuestiondic["selectedAnswer"] = answer
            print("arr of question = \(arrOfQuestion)")
            arrOfQuestion.remove(at: questionIndex)
            arrOfQuestion.insert(selectedQuestiondic, at: questionIndex)
            print("arr of question = \(arrOfQuestion)")
            arrofChildQuestiondata =  APIHelper.stringArrayToData(stringArray: arrOfQuestion) ?? Data()
            UtilityMethod().saveindefault(value: arrOfQuestion, key: ConstantOfApp.karrOfChildQuestion)
        }
    }
}

//struct ChildQuetsionView_Previews: PreviewProvider {
////    static var previews: some View {
////        ChildQuetsionView()
////    }
//}

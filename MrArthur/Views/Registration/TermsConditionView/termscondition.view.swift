//
//  TermsConditionView.swift
//  MrArthur
//
//  Created by IPS-157 on 19/07/22.
//

import SwiftUI

struct TermsConditionView: View {
    @StateObject private var observed = Observed()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var checkTermsCondition : Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Group{
                    Text("YOUR PRIVACY RIGHTS".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Group{
                        Text("Date of last revision: ".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont20,
                                color: .secondaryBlue
                            )
                        +
                        Text("25 October 2022".localized)
                            .fontModifier(
                                font: .montserratRegular,
                                size: iPhoneFont20,
                                color: .secondaryBlue
                            )
                    }
                }
                Spacer(minLength: 16.h)
                
                Text("Welcome to Mr Arthur (“mrarthur,” “we,” or “us”). These Terms of Use (the “Agreement”) describe the terms and conditions that govern your use of the current and future websites, such as https://mrarthur.io (the “Site”) and applications, including those for use on mobile devices, tablets, personal computers, and any other devices that connect to the internet including, but not limited to applications owned and operated by Mr Arthur (collectively, the “Services”). By using the Service, you agree to and are subject to the terms and conditions of this Agreement. We are proud of giving parents the capability to negotiate a safe and sensible use of devices and the online world with their children. Mr Arthur does not sell to children, whether upfront or in-app: Parents are our customers and will be included in all communication with their children. As our cherished customers, parents gain control over their child’s device and key functionalities. As such, we invite our parent-customers to go through all steps required by the privacy or data protection laws applicable to them and communicate clearly with their children as to the use of Mr Arthur as intended. \n\nIf you do not agree with all of the provisions of this Agreement, please do not use the Service. This Agreement is the complete and exclusive agreement between you and Mr Arthur with respect to the subject matters hereof (including the Service, Site and Mr Arthur Applications) and supersedes and merges all prior discussions and agreements between the parties with respect to such subject matters (including any prior End User License Agreements or Terms of Service), with the exception of additional agreements about premium services if and to the extent Mr Arthur does require them to be accepted by users prior to using those services. All users shall still be subject to this Agreement. \n\nTo the extent a dispute is not related to the personal data of a Data Subject (as defined below) of the European Union, this Agreement requires the use of arbitration on an individual basis to resolve disputes, rather than jury trials or class actions, and also limits the remedies available to you in the event of a dispute. If you are a Data Subject of the European Union, please refer to our Privacy Policy located at https://mrarthur.io/privacy for rights regarding your and your child’s personal data, which is incorporated herein by reference.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                Spacer(minLength: 16.h)
                
                VStack(alignment: .leading, spacing: 0){
                    Text("1. End User License Agreement".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("1.1 License \n\nMr Arthur provides an online platform that allows parents to monitor and manage their child’s mobile or internet device usage. Certain features of our platform are provided to you free-of-charge; these features are referred to as Free Services (“Free Services”). Other features require payment before you can access them; these features are referred to as Premium Services (“Premium Services”). Certain aspects of the Premium Services may require the use of a desktop application provided by Mr Arthur. The use of this application and the additional functionality of the Premium Services provided are governed by this Agreement, along with additional terms you must agree to as a condition of installing and using the application. Subject to the terms of this Agreement, Mr Arthur grants you a non-transferable, non-exclusive, limited license to use the Service for your personal use. Also subject to the terms of this Agreement, Mr Arthur grants you a non-transferable, non-exclusive license to use a copy of the App downloaded solely in connection with the Service on a mobile device that you own or control (collectively the “License”). \n\n1.2 Certain Restrictions \n\nThe rights granted to you in this Agreement are subject to the following restrictions: (a) you shall not license, sell, rent, lease, transfer, assign, distribute, host, or otherwise commercially exploit the Service, Site or any App; (b) you shall not modify, translate, adapt, merge, make derivative works of, disassemble, decompile, reverse compile or reverse engineer any part of the Site or App, except to the extent the foregoing restrictions are expressly prohibited by applicable law; (c) you shall not access the Service, Site or any App in order to build a similar or competitive service or application; (d) except as expressly stated herein, no part of the Site or any App may be copied, reproduced, distributed, republished, downloaded, displayed, posted or transmitted in any form or by any means, or (e) you shall not remove or destroy any copyright notices or other proprietary markings contained on or in any App. Any future release, update, or other addition to functionality of the Service, Site or App shall be subject to the terms of this Agreement, unless otherwise provided in terms associated with such addition. All copyright and other proprietary notices on any Site content must be retained on any copies. This App is for personal/consumer use only and not for commercial purposes. Not more than fifteen (15) mobile devices may be paired with the Free Services of the App at any one time by a single user. Not more than quinze (15) mobile devices may be paired with the Premium Services of the App at any one time by a single user. No business or institution may access this service for commercial use, even if they remain under the fifteen (15) mobile devices limit for the Premium Services. By downloading and using the App and the Services, you represent that you are and will remain in compliance with the restrictions set forth in this Agreement. \n\n1.3 Compliance with Applicable Laws \n\nYou are solely responsible for your compliance with all applicable laws, including without limitation export and import regulations. \n\n1.4 Modification \n\nMr Arthur reserves the right, at any time, to modify, suspend, or discontinue the Service, Site or App or any part thereof with or without notice. In the future, we may offer additional services, features, functionalities, and in-app purchases. You agree that Mr Arthur will not be liable to you or to any third party for any modification, suspension, or discontinuance of the Site or App or any part thereof. \n\n1.5 Ownership \n\nApps provided to you are licensed to you and not sold. Mr Arthur (and its licensors, where applicable) own all right, title and interest, including all related intellectual property rights, in and to the Service, Site and all Apps, excluding your User Content and, to the degree required by law, your Personal Data (defined below). This Agreement is not a sale and does not convey to you any rights of ownership in or related to any App. The Mr Arthur name, logo, and the product names associated with the Service belong to Mr Arthur (or its licensors, where applicable), and no right or license is granted to use them by implication, estoppel, or otherwise. Mr Arthur (and its licensors, where applicable) reserve all rights not granted in this Agreement.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("2. User Content".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("2.1 User Content \n\nYou own the content you submit to Mr Arthur as well as any screenshots generated as a result of your use of the Services (“User Content”). As such, you are free to share your content with anyone else, wherever you want. To provide our Services, though, you give us some legal permission to use the User Content. Specifically, when you share, post, or upload User Content that is covered by intellectual property rights (like photos or videos) on or in connection with the Services, you grant us a non-exclusive, transferable, sub-licensable, royalty-free, and worldwide license to host, use, modify, run, or copy your User Content for the purpose of providing the Services. This means, for example, that if you share with us your User Content, you give us permission to store and share it with others (again, consistent with your settings) in accordance with our Privacy Policy. You can end this license any time by deleting your content or account. You should know that, for technical reasons, content you delete may persist for a limited period of time in backup copies (though it will not be visible to other users). \n\nPersonal Data \n\nAny information relating to an identified or identifiable natural person (“Data Subject”) is “Personal Data.” Personal Data allows the Data Subject to be identified, directly or indirectly, in particular by reference to an identifier such as a name, an identification number, location data, an online identifier or one or more factors specific to the physical, physiological, genetic, mental, economic, cultural or social identity of that natural person. \n\nFeedback \n\nIf you provide Mr Arthur any feedback or suggestions (“Feedback”), you hereby transfer and assign to Mr Arthur all rights in the Feedback and agree that Mr Arthur shall have the right to use such Feedback and related information in any manner it deems appropriate, within the law as it pertains to Personal Data. Mr Arthur will treat any Feedback you provide to Mr Arthur as non-confidential and non-proprietary. You agree that you will not submit to Mr Arthur any information or ideas that you consider to be confidential or proprietary, and that you do not provide to Mr Arthur the Personal Data of other Data Subjects without legal grounds. \n\n2.2 Acceptable Use Policy \n\nThe following sets forth Mr Arthur’s “Acceptable Use Policy”: \n\n(a) You acknowledge that you will only use the Services and any App, solely to monitor a device used by a person for which you are the legal parent or guardian. You acknowledge that you will not use the Services or any App, to monitor a device used by any person over the age of consent in the applicable jurisdiction. Further, for any individual using a device monitored through the use of the Services or any App, you acknowledge that all legal parents or guardians have provided informed consent for the monitoring taking place. \n\n(b) You agree not to use the Services to upload, distribute, or otherwise use any User Content (a) that violates any third-party right, including any copyright, trademark, patent, trade secret, moral right, privacy right, right of publicity, or any other intellectual property or proprietary right; (b) that is tortious, trade libelous, defamatory, false, or intentionally misleading, (c) that is harassing, abusive, threatening, harmful, vulgar, obscene, or offensive, or that contains pornography, nudity, or graphic or gratuitous violence, or that promotes violence, racism, discrimination, bigotry, hatred, or physical harm of any kind against any group or individual, or is otherwise objectionable, (d) that is harmful to minors in any way; (e) that constitutes unsolicited or unauthorized advertising, promotional materials, junk mail, spam, chain letters, pyramid schemes, or any other form of duplicative or unsolicited messages, whether commercial or otherwise; or (f) that violates of any law, regulation, or contractual obligations. \n\n(c) You agree not to use the Services to: (a) upload or distribute any computer viruses, worms, malicious code, or any software intended to damage or alter a computer system or data; (b) collect information or data regarding other users, including email addresses, without their consent (e.g., using harvesting bats, robots, spiders, or scrapers); (c) disable, overly burden, impair, or otherwise interfere with servers or networks connected to the Site (e.g., a denial of service attack); (d) attempt to gain unauthorized access to the Services or servers or networks connected to the Site (e.g., through password mining); or (e) interfere with another user’s use and enjoyment of the Services, Site or any App. \n\n2.3 Enforcement \n\nWe reserve the right (but have no obligation) to review any User Content from time to time in our sole discretion. We may remove or modify any User Content at any time for any reason in our sole discretion with or without notice to you.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("Term and Termination".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("3.1 \n\nThis Agreement commences on the date you accept this Agreement (as described in the preamble) and will remain in full force and effect while you use the Service, unless earlier terminated in accordance with this Agreement. \n\n3.2 \n\nNotwithstanding the forgoing, if you used the Service prior to the date you accepted this Agreement (as described in the preamble), you hereby acknowledge and agree that this Agreement commences on the date you first use the Service (whichever is earlier and which may be prior to the Last Revised Date of this Agreement) and will remain in full force and effect while you use the Service, unless earlier terminated in accordance with this Agreement. \n\n3.3 \n\nWe may (a) suspend your rights to use the Service, and/or any related services or (b) terminate this Agreement, at any time for any reason at our sole discretion with or without notice to you, including if we in good faith believe you have violated the Acceptable Use Policy or any other provision of this Agreement. Without limiting the foregoing, Mr Arthur reserves the right to terminate its Agreement with any user who infringes third party copyright rights upon prompt notification to Mr Arthur by the copyright owner or the copyright owner’s legal agent. \n\n3.4 \n\nUpon termination of this Agreement, your right to use the Services will automatically terminate immediately. You understand that any termination may involve deletion of your User Content associated therewith from our live databases.Mr Arthur will not have any liability whatsoever to you for any termination of this Agreement, including deletion of your User Content, with the exception of any liability with regard to your Personal Data, if applicable. Even after this Agreement is terminated, the following provisions of this Agreement will remain in effect: Sections 1.2, 1.3, 1.4, 1.5, 2, 3.4, 4, 6, 7, 8, 9, and 10.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("4. Indemnity".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("You agree to defend, indemnify and hold harmless Mr Arthur (and its suppliers) from and against any claims, suits, losses, damages, liabilities, costs, and expenses (including reasonable attorneys’ fees) brought by third parties resulting from or relating to: (i) your use of the Service, (ii) your User Content, or (iii) your violation of this Agreement. Mr Arthur reserves the right, at your expense, to assume the exclusive defense and control of any matter for which you are required to indemnify Mr Arthur, and you agree to cooperate with our defense of these claims. You agree not to settle any matter without the prior written consent of Mr Arthur. Mr Arthur will use reasonable efforts to notify you of any such claim, action, or proceeding upon becoming aware of it.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("5. Privacy and Data Collection".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("5.1 \n\nOur Privacy Policy, available at https://mrarthur.io/en/privacy-charter/ is incorporated into this Agreement by reference. \n\n5.2 \n\nYou agree that personal information, technical information, User Content, other information, and to the degree described in the Privacy Policy, Personal Data collected or received by Mr Arthur in connection with the Service, Site, and/or App may be transferred, stored and processed in the United States by Mr Arthur, our affiliates, or our third party data processing partners pursuant to the legal requirements. By downloading, installing, using the Service, Site, and/or App, and providing consent as required, you agree to the processing of both technical and personal information in the United States.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("6. Mobile Application".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("You may access the Services via a mobile device (“Mobile Application”). To use the Mobile Application, you must have a mobile device that is compatible with the Mobile Application. Mr Arthur does not warrant that the Mobile Application will be compatible with your mobile device. You may use mobile data in connection with the Mobile Application and may incur additional charges from your wireless provider for these services. You agree that you are solely responsible for any such charges. Mr Arthur hereby grants you a non-exclusive, non transferable, revocable license to use a compiled code copy of the Mobile Application for one account on one mobile device owned or leased solely by you, for your personal use. You agree not to: (i) modify, disassemble, decompile or reverse engineer the Mobile Application, except to the extent that such restriction is expressly prohibited by law; (ii) rent, lease, loan, resell, sublicense, distribute or otherwise transfer the Mobile Application to any third party or use the Mobile Application to provide time sharing or similar services for any third party; (iii) make any copies of the Mobile Application; (iv) remove, circumvent, disable, damage or otherwise interfere with security-related features of the Mobile Application, features that prevent or restrict use or copying of any content accessible through the Mobile Application, or features that enforce limitations on use of the Mobile Application; or (v) delete the copyright and other proprietary rights notices on the Mobile Application. You acknowledge that Mr Arthur may from time to time issue upgraded versions of the Mobile Application, and may automatically electronically upgrade the version of the Mobile Application that you are using on your mobile device. You consent to such automatic upgrading on your mobile device, and agree that the terms and conditions of this Agreement will apply to all such upgrades. Any third-party code that may be incorporated in the Mobile Application is covered by the applicable open source or third-party license EULA, if any, authorizing the use of such code. The foregoing license grant is not a sale of the Mobile Application or any copy thereof, and Mr Arthur or its third-party partners or suppliers retain all right, title, and interest in the Mobile Application (and any copy thereof). Any attempt by you to transfer any of the rights, duties or obligations hereunder, except as expressly provided for in this Agreement, is void. Mr Arthur reserves all rights not expressly granted under this Agreement. You agree to comply with all United States and foreign laws related to use of the Mobile Application and the Services. \n\n6.1 Mobile Application from App Store by Apple \n\nThe following applies to any Mobile Application you acquire from the App Store (“App Store-Sourced Application”): You acknowledge and agree that these Terms are solely between you and Mr Arthur, not Apple, and that Apple has no responsibility for the App Store-Sourced Application or content thereof. Your use of the App Store-Sourced Application must comply with the App Store Terms of Service. You acknowledge that Apple has no obligation whatsoever to furnish any maintenance and support services with respect to the App Store-Sourced Application. In the event of any failure of the App Store-Sourced Application to conform to any applicable warranty, you may notify Apple, and Apple will refund the purchase price for the App Store-Sourced Application to you; to the maximum extent permitted by applicable law, Apple will have no other warranty obligation whatsoever with respect to the App Store-Sourced Application, and any other claims, losses, liabilities, damages, costs or expenses attributable to any failure to conform to any warranty will be solely governed by this Agreement and any law applicable to Mr Arthur as provider of the software. You acknowledge that Apple is not responsible for addressing any of your claims or those of any third party relating to the App Store-Sourced Application or your possession and/or use of the App Store-Sourced Application, including, but not limited to: (i) product liability claims; (ii) any claim that the App Store-Sourced Application fails to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection or similar legislation, and all such claims are governed solely by this Agreement and any law applicable to Mr Arthur as a provider of the application. You acknowledge that, in the event of any third-party claim that the App Store-Sourced Application or your possession and use of that App Store-Sourced Application infringes that third party’s intellectual property rights, Mr Arthur, not Apple, will be solely responsible for the investigation, defense, settlement, and discharge of any such intellectual property infringement claim to the extent required by this Agreement. You and Mr Arthur acknowledge and agree that Apple, and Apple’s subsidiaries, are third-party beneficiaries of this Agreement as it relates to your license of the App Store-Sourced Application, and that, upon your acceptance of this Agreement, Apple will have the right (and will be deemed to have accepted the right) to enforce this Agreement as it relates to your license of the App Store-Sourced Application against you as a third-party beneficiary thereof.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("7. Disclaimers".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("7.1 \n\nTHE SERVICE, SITE, AND APP ARE PROVIDED “AS-IS” AND AS AVAILABLE AND MR ARTHUR (AND ITS SUPPLIERS) EXPRESSLY DISCLAIM ANY WARRANTIES AND CONDITIONS OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING THE WARRANTIES OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, QUIET ENJOYMENT, ACCURACY, OR NON- INFRINGEMENT. ETURI (AND ITS SUPPLIERS) MAKE NO WARRANTY THAT THE SERVICE, SITE OR APP: (A) WILL MEET YOUR REQUIREMENTS; (B) WILL BE AVAILABLE ON AN UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE BASIS; OR (C) WILL BE ACCURATE, RELIABLE, COMPLETE, LEGAL, OR SAFE. \n\n7.2 \n\nSOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF IMPLIED WARRANTIES, SO THE ABOVE EXCLUSION MAY NOT APPLY TO YOU.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("Limitation on Liability".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("8.1 \n\nIN NO EVENT SHALL MR ARTHURI (OR ITS SUPPLIERS) BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY LOST PROFIT OR ANY INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL OR PUNITIVE DAMAGES ARISING FROM OR RELATING TO THIS AGREEMENT OR ETURI’S PRIVACY PRACTICES, THE SERVICE, SITE OR APP, EVEN IF ETURI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. ACCESS TO, AND USE OF, THE SERVICE, SITE AND APP ARE AT YOUR OWN DISCRETION AND RISK, AND YOU WILL BE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR MOBILE DEVICE OR LOSS OF DATA RESULTING THEREFROM. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, ETURI’S LIABILITY TO YOU FOR ANY DAMAGES ARISING FROM OR RELATED TO THIS AGREEMENT OR MR ARTHUR’S PRIVACY PRACTICES (FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION), WILL AT ALL TIMES BE LIMITED TO THE GREATER OF (A) FIFTY U.S. DOLLARS (050) OR (B) AMOUNTS YOU’VE PAID MR ARTHUR IN THE PRIOR 12 MONTHS (IF ANY). IN NO EVENT SHALL MR ARTHUR’S SUPPLIERS HAVE ANY LIABILITY ARISING OUT OF OR IN ANYWAY CONNECTED TO THIS AGREEMENT. \n\n8.2 \n\nSOME JURISDICTIONS DO NOT ALLOW THE LIMITATION OR EXCLUSION OF LIABILITY FOR INCIDENTAL OF CONSEQUENTIAL DAMAGES, SO THE ABOVE LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU AND YOU MAY ALSO HAVE OTHER LEGAL RIGHTS THAT VARY FROM JURISDICTION TO JURISDICTION. EUROPEAN UNION DATA SUBJECTS’ DATA PROTECTION RIGHTS REMAIN UNAFFECTED.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("9. General".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("9.1 Changes to this Agreement \n\nThis Agreement is subject to occasional revision, and if we make any substantial changes, we may notify you by sending you an e-mail to the last email address you provided to Mr Arthur (if any) and/or by prominently posting notice of the changes on our Site. Any changes to this Agreement will be effective upon the earlier of thirty (30) calendar days following our dispatch of an e-mail notice to you (if applicable) or thirty (30) calendar days following our posting of notice of the changes on our Site. These changes will be effective immediately for new users of our Site or App. Continued use of our Site or App following notice of such changes shall indicate your acknowledgement of such changes and agreement to be bound by the terms and conditions of such changes. The date on which the latest update was made is indicated at the top of this document. We recommend that you print a copy of this Agreement for your reference and revisit this policy from time to time to ensure you are aware of any changes. \n\n9.2 Notice \n\nYou are responsible for providing Mr Arthur with your most current e-mail address. In the event that the last e-mail address you have provided to Mr Arthur is not valid, or for any reason is not capable of delivering to you any notices required/permitted by this Agreement,Mr Arthur ‘s dispatch of the e-mail containing such notice will nonetheless constitute effective notice. Any notice provided to Mr Arthuri pursuant to this Agreement should be sent to: contact@mrarthur.io. All notices under this Agreement must be in English. \n\n9.3 Governing Law and Dispute Resolution \n\nPLEASE READ THIS CAREFULLY. IT AFFECTS YOUR RIGHTS. \n\nThe Personal Data rights of Data Subjects of the European Union are not affected by the following paragraph. For all others: Except for disputes that can be brought in small claims court, all disputes between you and Mr Arthur, including any dispute regarding this Agreement, shall be exclusively settled through binding arbitration through the American Arbitration Association (“AAA”) pursuant to the AAA’s then-current rules for commercial arbitration. Any such arbitration proceeding will be conducted solely in English. There is no judge or jury in arbitration. Arbitration procedures are simpler and more limited than rules applicable in court and review by a court is limited. YOU AND MR ARTHUR AGREE THAT ANY SUCH ARBITRATION SHALL BE CONDUCTED ON AN INDIVIDUAL BASIS AND NOT IN A CLASS, CONSOLIDATED, OR REPRESENTATIVE ACTION. Notwithstanding any provision in this Agreement to the contrary, if the class-action waiver in the prior sentence is deemed invalid or unenforceable; however, neither you nor we are entitled to arbitration. This arbitration agreement is subject to the Federal Arbitration Act. The arbitrator’s award may be entered in any court of competent jurisdiction. Notwithstanding any provision in this Agreement to the contrary, we agree that if Mr Arthur makes any future material change to this dispute resolution provision, it will not apply to any individual claim(s) that you had already provided notice of Mr Arthur. Information on AAA and how to start arbitration can be found at https:www.adr.org or by calling 800-778-7879. \n\nThis Agreement is governed by the laws of the country of the United States of America without regard to conflict of law principles. If the arbitration in this section provision is found unenforceable or not to apply for a given dispute, then the proceeding must be brought exclusively in the court of competent jurisdiction in Bobigny, France. \n\n9.4 Severability \n\nIf any provision of this Agreement is, for any reason, held to be invalid or unenforceable, the other provisions of this Agreement will be unimpaired, and the invalid or unenforceable provision will be deemed modified so that it is valid and enforceable to the maximum extent permitted by law. \n\n9.5 Entire Agreement \n\nThis Agreement is the final, complete, and exclusive agreement of you and Mr Arthur with respect to the subject matters hereof (including the Service, Site, and App) and supersedes and merges all prior discussions and agreements between the parties with respect to such subject matters (including any prior End User License Agreements and Terms of Service or Privacy Policy). Certain Additional Premium Services (“APS”) will be subject to an APS Agreement that must be accepted by users prior to using those services. All users shall still be subject to this Agreement. Our failure to exercise or enforce any right or provision of this Agreement shall not operate as a waiver of such right or provision. The section titles in this Agreement are for convenience only and have no legal or contractual effect. The word including means including without limitation. Your relationship to Mr Arthur is that of an independent contractor, and neither party is an agent or partner of the other. This Agreement, and your rights and obligations herein, may not be assigned by you without Mr Arthur’s prior written consent, and any attempted assignment in violation of the foregoing will be null and void. Mr Arthur may assign this Agreement in connection with a merger, acquisition, reorganization or sale of all or substantially all of its assets, or other operation of law, without your consent. The terms of this Agreement shall be binding upon assignees.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("10. Application Store Additional Terms and Conditions".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("The following additional terms and conditions apply to you if you are using our App from the Application Store. To the extent the other terms and conditions of this Agreement are less restrictive than, or otherwise conflict with, the terms and conditions of this Section 10, the more restrictive or conflicting terms and conditions in this Section 10 apply, but solely with respect to Apps from the Application Store, as applicable. \n\n10.1 Acknowledgement \n\nMr Arthur and you acknowledge that this Agreement is concluded between Mr Arthur and you only, and not with a third party, and Mr Arthur, not a third party, is solely responsible for App and the content thereof. To the extent this Agreement provides for usage rules for the App that are less restrictive than the Usage Rules set forth for the App in, or otherwise is in conflict with, the Application Store Terms of Service, the more restrictive or conflicting third party terms applies, as applicable. \n\n10.2 Scope of License \n\nThe license granted to you for App is for personal use only and is limited to a non- transferable license to use App on a maximum of fifteen (15) mobile devices for Free Services and on a maximum of fifteen (15) mobile devices for Premium Services that you own or control and as permitted by the Usage Rules set forth in the third party App Store Terms and Conditions (the “Usage Rules”). \n\n10.3 Maintenance and Support \n\nMr Arthur is solely responsible for providing any maintenance and support services with respect to App, as specified in this Agreement (if any), or as required under applicable law. Mr Arthur and you acknowledge that third parties have no obligation whatsoever to furnish any maintenance and support services with respect to App. All support services will be offered in English. \n\n10.4 Warranty \n\nMr Arthur is solely responsible for any product warranties, whether express or implied by law, to the extent not effectively disclaimed. In the event of any failure of App to conform to any applicable warranty, you may notify the Application Store, and the Application Store may refund the purchase price for App to you; and to the maximum extent permitted by applicable law, third parties will have no other warranty obligation whatsoever with respect to App, and any other claims, losses, liabilities, damages, costs or expenses attributable to any failure to conform to any warranty will be Mr Arthur’s sole responsibility. \n\n10.5 Product Claims \n\nMr Arthur and you acknowledge that Mr Arthur, not any third party, is responsible for addressing any claims of you or any third party relating to App or your possession and/or use of App, including, but not limited to: (i) product liability claims; (ii) any claim that App fails to conform to any applicable legal or regulatory requirement; and (iii) claims arising under consumer protection or similar legislation. This Agreement does not limit Mr Arthur’s liability to you beyond what is permitted by applicable law. \n\n10.6 Intellectual Property Rights \n\nMr Arthur and you acknowledge that, in the event of any third party claim that App or your possession and use of App infringes that third party’s intellectual property rights, Mr arthur, not any third party, will be solely responsible for the investigation, defense, settlement and discharge of any such intellectual property infringement claim. \n\n10.7 Legal Compliance \n\nYou represent and warrant that (i) you are not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a “terrorist supporting” country; and (ii) you are not listed on any U.S. Government list of prohibited or restricted parties. \n\n10.8 Developer Name and Address \n\nMr Arthur's contact information for any end-user questions, complaints or claims with respect to App is set forth in Section 9.2. \n\n10.9 Third Party Terms of Agreement \n\nYou must comply with applicable third party terms of agreement when using App.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("11. Membership and Account".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("11.1 Membership Information \n\nWe may offer a number of membership plans, including plans with differing conditions and limitations, or membership rates, including special promotional rates or free trials. We reserve the right to modify, terminate, or otherwise amend our membership plans at any time. We do not guarantee that a specific membership plan or rate will always be available. We will provide you reasonable notice upon the modification of a membership plan or rate. Unless otherwise stated, month, year, monthly, yearly or annual refers to your billing cycle. \n\n11.2 Billing Information \n\nTo receive Premium Services, you must have Internet access and provide us with a current, valid and accepted method of payment (“Payment Method”). The day that you register for and purchase or activate your Premium Services (“Activation Date”) is the first day of your billing cycle. If you choose to engage in a “free trial” of Premium Services, after providing a current, valid, and accepted method of payment, you may cancel within the free trial period and will not be charged. \n\nIf you do not cancel, you authorize activation of Premium Services with an Activation Date as of the end of the free trial period. Your Premium Services will expire after the amount of time set forth in your subscription email, print out, gift or trial activation offer (“Subscription Term”), as calculated from the Activation Date, unless you renew it automatically or manually in accordance with the terms of your Subscription Term. \n\nBy purchasing or activating Premium Services, you authorize Mr Arthur to charge the stated Premium Services fee amount, and any applicable sales, telecommunication, excise or similar taxes to the payment method that you provided at the time of purchase or activation. If you elect automatic renewal, you also authorize Mr Arthur to charge the then- current Premium Services fee amount, and any applicable sales, telecommunication, excise or similar taxes, at the end of your Subscription Term. The Premium Services fee is exclusive of any applicable federal, state, municipal taxes or duties. Mr Arthur may change the Premium Services fee amount for new or renewal Subscription Terms upon 30 days’ prior notice to you via email. Any changes to the Premium Services fee will be effective upon your next billing cycle, and will not apply retroactively or to the remainder of your current Subscription Term. \n\nIf you affirmatively opt-in to the “Auto-Renew” option for your paid Premium Services, your Premium Services will automatically renew at the end of each Subscription Term unless you terminate your Premium Services prior to expiration of the then-current Subscription Term. At the time of renewal, Mr Arthur will charge the credit card you provided on the Activation Date, unless you provide Mr Arthur with an alternate payment method prior to expiration of the then-current Subscription Term. See “Cancellation” below for information on how to cancel your Premium Services. \n\n11.3 Payment Methods \n\nYou may edit your Payment Method by accessing Settings then Account Settings from within the Mr Arthur App or Mr Arthur web service. If a payment is not successfully settled, due to expiration, insufficient funds, or otherwise, and you do not edit your Payment Method information or cancel your account (see, “Cancellation” below), you remain responsible for any uncollected amounts and authorize us to continue billing the Payment Method, as it may be updated. For certain Payment Methods, the issuer of your Payment Method may charge you a foreign transaction fee or other charges. Check with your Payment Method service provider for details. \n\n11.4 Cancellation \n\nYou may cancel your Premium Services membership at any time. Your billing will commence until the end of the period you have selected. We do not provide refunds or credits for any partial time left on your account. To ensure proper cancellation of your service, please cancel at least 24 hours before the end of your next billing cycle. We are not responsible for any charges that are incurred as a result of failing to cancel your Premium Services within 24 hours of your next billing cycle. To cancel, please access Settings then Account Settings from within the Mr Arthur App or Mr Arthur web service. For assistance with your account or canceling your subscription, please contact: contact@mrarthur.io.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 25.h)
                }
                HStack {
                    Spacer()
                    BlueRoundedButton("ACCEPT ALL"){
                        AmplitudeService.sendEvent(
                            key: .OBS_MAIL_INPUT_1_BIS_ACCEPT_ALL
                        )
                        checkTermsCondition = true
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                }
                .padding(.bottom, CGFloat.dynamicValue(
                    foriPhone: 16,
                    foriPad: 50
                ))
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(colors: [Color.secondaryRed, Color.lightPink],
                               startPoint: .top,
                               endPoint: .center)
            )
            
        }
        .customNavigationViewWithoutBackWithAmplitudeEvent(
            title: "",
            color: .whiteColor,
            amplitudeEvent: .OBS_MAIL_INPUT_1_BIS_BACK
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

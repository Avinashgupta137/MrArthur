//
//  PrivacyPolicyView.swift
//  MrArthur
//
//  Created by IPS-157 on 08/08/22.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @StateObject private var observed = Observed()
    @State private var deviceName : String = ""
    @State var textColor: Color = .secondaryBlue
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading){
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
                
                Text("This Privacy Policy describes what information Mr Arthur (“mrarthur,” “we,” “our,” or “us”) may collect and how we use such information when you visit or use our website at https://mrarthur.io (the “Site”) and/or our applications, including those for use on mobile devices, tablets, personal computers, and any other devices that connect to the internet. The Site and Mr Arthur Applications are collectively referred to herein as the “Services. \n\nBy using the Services, you consent to the collection, use, and sharing of your and your children’s information by Mr Arthur in accordance with this Privacy Policy and consent to the Terms of Use and End User License Agreement, which are incorporated herein by reference. For users in the United States, the term “children,” as used herein, refers to minors under the age of 13. For users outside of the United States, “children” refers to those under the age of digital majority. For additional information about our practices regarding children’s personal information, please see Section 1.1.1 (Children’s Personal Information) and Section 5 (Children’s Privacy Rights) below. \n\nIt is important for users of the Services to read the Privacy Policy carefully. The Privacy Policy may change over time in coordination with new or different services that we may provide in the future, or for other reasons. We have provided a “Last Revised Date” at the top of the Privacy Policy, which reflects the date that this Privacy Policy was most recently updated so that users can be aware of the Privacy Policy in effect at all times. We encourage all users to occasionally refer to this Privacy Policy so that they can remain aware of our current privacy practices.".localized)
                    .fontModifier(
                        font: .montserratRegular,
                        size: iPhoneFont18,
                        color: .secondaryBlue
                    )
                Spacer(minLength: 16.h)
                
                VStack(alignment: .leading, spacing: 0){
                    Text("1. INFORMATION WE COLLECT".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("1.1. Personal Information: Mr Arthur collects “Personal Information” from you at various times and places on the Site and Mr Arthur applications. Personal Information means information relating to a particular individual, such as the individual’s name, postal address, email address, and telephone number. Personal Information also includes your “Children’s Personal Information,” as defined below in Section 1.1.1. \n\n1.1.1. Children’s Personal Information: With your consent, Mr Arthur may collect your “Children’s Personal Information.” Children’s Personal Information may include information you voluntarily submit to us such as your child’s first, middle and last name, date of birth, age, gender, and profile photo, or it may include information we collect from your child as a result of your use of the Services, such as your child’s device access times (e.g., we may collect information relating to how long your child uses or accesses his or her device to support our “allowance” feature), device identifier numbers, serial numbers, geolocation information, and other internet, device, or electronic network activity information, including, but not limited to, encrypted screenshots generated by your Mr Arthur Applications account and the transcribed content from the screenshots (e.g., through optical character recognition), as authorized by you (“Screenshots”). Screenshots may capture your children’s browsing activity, search activity, messaging activity, and other information regarding your child’s interaction with an internet website, application, advertisement, device, or interactions with a device in general. \n\nIn order to provide the Services, we may also collect from your child’s device information relating to which apps are installed on your child’s device and information relating to your child’s device permission status (e.g., if your child has disabled the usage permissions on his/her device required to provide the Services, that information may be collected or if the device can no longer be “seen”). We may also collect information from your child’s device about your child’s usage and activity in connection with the Services (e.g., error/crash reporting, usage analytics such as screen views, your child’s use of any hyperlinks available within the Services, time on page, and page hits). \n\nFor additional information about our practices regarding Children’s Personal Information, please see Section 5 (Children’s Privacy Rights) below. \n\nIn regard to the European Union, our collection of personal information from a child is limited and controlled by the parent. \n\n1.2. Non-Personal Information: Non-Personal Information means information that does not identify, and cannot reasonably be used to identify, an individual. We collect Non-Personal Information, for example, when we track the total number of visitors to the Site, the number of visitors to a particular page of the Site, and/or other such technical information. This data may be used to diagnose problems with the Services, gather demographic and geographic information to improve our Services or marketing efforts, improve our Services, and for similar purposes. Non-Personal Information includes aggregated and/or de-identified information. Mr Arthur reserves the right to use and disclose Non-Personal Information in its sole discretion.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("2. HOW WE COLLECT INFORMATION".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("2.1. Voluntarily Provided Information: Mr Arthur may collect Personal Information, including your Children’s Personal Information, whenever you voluntarily provide such information including, for example, when you conduct business with us, use our Services, request information or materials from us, create or update any Mr Arthur accounts, when you voluntarily send Screenshots, or when you communicate with us about questions or concerns. \n\nExamples of the type of information you may voluntarily provide include: \n\nYour first name, last name, email address, and any updates to that information thereafter; \n\nInformation relating to your child, such as your child’s name, age, birthdate, gender, and profile photo (see Section 1.1.1. (Children’s Personal Information) for more information); and \n\nIf you sign up for any of our paid Services, your credit card or debit card information (such as card type, last four digits of your card, and expiration date) and other financial data and transaction history that we need to process your payment and provide the paid Services. \n\n2.2 Services-Related Information: We may collect Personal Information, including your Children’s Personal Information, as a result of your use of the Services. This includes, for example: \n\nCustom word lists you create to allow the Services to flag specific words of interest to you and the number of times the words appear within screenshots; \n\nInformation you may provide to us relating to the desired preferences of the Services (e.g., determining the preferred units of measurement for geofencing notifications). \n\nSchedules you may create as part of the Services (e.g., to schedule device access for your child’s device and related screen time allowance information); and \n\nInformation relating to which apps are installed on your child’s device and information relating to your child’s device status/permission status (e.g., if your child has disabled the usage permissions on his/her device required to provide the Services, that information may be collected or if the device can no longer be “seen”) (see Section 1.1.1. (Children’s Personal Information) for more information). \n\n2.3. Information Obtained from Third Parties: In limited circumstances, we may collect your Personal Information from third parties. For example, the payment processors we work with generally provide us with information related to you, such as a unique token that enables you to make additional purchases using the information they’ve stored, including recurring payments if you authorize automatic renewals, and your card’s type, expiration date, and certain digits of your card number. We do not collect your Children’s Personal Information from third parties. \n\n2.4. Cookies and Similar Technologies: When you use the Services, we and certain third parties may use “cookies” and similar technologies like pixels, web beacons, and local storage (collectively, “Collection Technology“) \n\nto collect information. We do not use Collection Technology to collect Children’s Personal Information. \n\nFor example, when you use our Services, we may use Collection Technology to collect certain device information, such as: device operating system, device operating system version, IP addresses, access times, browser type and language, browser version, and device identifier numbers. We may also use Collection Technology to collect information about your usage and activity related to the Services (e.g., error/crash reporting, usage analytics, your use of any hyperlinks available within the Services, time on page, and page hits), and chat analytics when the chat feature is used. \n\nYou have the right to choose whether or not to accept cookies. However, they are an important part of how the Services work, so you should be aware that if you choose to refuse or remove cookies, it could affect the availability and functionality of the Services. Most web browsers are set to accept cookies by default. If you prefer, you can usually choose to set your browser to remove or reject browser cookies. To do so, please follow the instructions provided by your browser. \n\nRemoving or rejecting browser cookies does not necessarily affect third-party flash cookies or other web trackers, which may be used by us or our partners in connection with the Sites. To delete or disable flash cookies, please visit this site for more information. For further information about cookies, including how to see what cookies have been set on your device and how to manage and delete them, you can visit https://www.allaboutcookies.org/.\n\n2.5. Third-Party Analytics: We may use third-party analytics tools including, for example, Amplitude, to help us measure traffic and usage trends for the Services. These tools may collect your Personal Information, including Children’s Personal Information, sent by your devices or our Services that assists us in improving the Services. You can read Amplitude’s privacy policy, by visiting this link: https://amplitude.com/privacy".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("3. HOW WE USE THE PERSONAL INFORMATION WE COLLECT".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("Personal Information we collect may be used for the purposes listed below. Children’s Personal Information is used in accordance with Section 5.3 below. \n\n3.1. To provide, develop, maintain, operate, and improve our Services; \n\n3.2. To understand you and your preferences to enhance your experience and provide a more personalized Service; \n\n3.3. To process and fulfill a request or other transaction submitted by you, including, for example, to process payment transactions and to respond to your comments and questions and provide customer support; \n\n3.4. To communicate with you including, for example, to send you Services-related information (e.g., geofencing notifications), including confirmations, invoices, technical notices, updates, security alerts, and support and administrative messages; \n\n3.5. For our own marketing purposes. To this end, we may communicate with you about new contests, promotions, rewards, upcoming events, and other news about our Services and our selected partners; \n\n3.6. For our business operations (e.g., billing, auditing, reporting, and statistical analysis); \n\n3.7. To meet or comply with any applicable law, regulation, legal process, or other legal obligation; protect or prevent harm, fraud, or financial loss; or promote, detect, investigate and help prevent security, fraud or technical issues; and protect our legitimate business interests and legal rights; and \n\n3.8. In connection with corporation transactions, which refers to transfers of Personal Information in the event we sell or transfer, or are considering selling or transferring, all or a portion of our business or assets.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("4. DISCLOSURE OF YOUR INFORMATION TO THIRD PARTIES".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("Mr Arthur may share your Personal Information to third parties as listed below. Disclosure of Children’s Personal Information shall occur in accordance with Section 5.4 below. \n\n4.1. With Your Consent: We may share your information, including Personal Information, with another company when you allow us to do so (i.e., when we have obtained your consent). \n\n4.2. Service Providers: We may share your information, including Personal Information, with third parties to assist in our business operations (e.g., to process payments, store data, deliver information, and perform other similar functions); administrative functions; marketing functions; and/or to provide the Mr Arthur Applications services you have requested (collectively, “Service Providers”). Service Providers are prohibited from using your Personal Information for purposes other than those requested by us or required by law. \n\n4.3. Major Transactions: We may share your information, including Personal Information, as part, of or in connection with, a merger, acquisition, assignment, as part of debt financing, the sale of company assets, or in any similar transaction, or to the extent as may be required in the unlikely event of insolvency bankruptcy, or a receivership. \n\n4.4. Professional Advisors: We may share information with our legal, financial, and other advisors in connection with the corporate transactions described above or in connection with the management of our business and operations. \n\n4.5. Disclosures Under Special Circumstances: We may share your information, including Personal Information, when we believe doing so may be appropriate, including but not limited to when it may be legally required, necessary to comply with laws, or in response to lawful requests or legal process. We may also share such information where we believe it may limit our liability in an actual or potential lawsuit, or where otherwise necessary to protect our rights, interests and/or property (including, without limitation, to enforce our agreements), or the rights, interests and/or property of our agents, independent contractors, customers, and others.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("5. CHILDREN’S PRIVACY RIGHTS".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("Mr Arthur does not sell products or services to children. The Services are not intended for children to submit Personal Information to Mr Arthur without the consent of their legal guardians. In compliance with the Children’s Online Privacy Protection Act (“COPPA”), please see below: \n\n5.1. The types of Personal Information we collect from children are detailed above in Section 1.1.1 (Children’s Personal Information). \n\n5.2. How we collect information from children is detailed above in Section 2 (How We Collect Information). \n\n5.3. Mr Arthur uses Children’s Personal Information for the purposes listed below: \n\nProvide, develop, maintain, operate, and improve our Services, \n\nProcess and fulfill a request or other transaction submitted by you, including, for example, to respond to comments and questions and provide customer support; \n\nCommunicate with you including, for example, to send you Services-related information, including confirmations, invoices, technical notices, updates, security alerts, and support and administrative messages; \n\nFor our business operations (e.g., auditing, reporting, and statistical analysis); \n\nTo meet or comply with any applicable law, regulation, legal process or other legal obligation; protect or prevent harm, fraud, or financial loss; or promote, detect, investigate and help prevent security, fraud or technical issues; and protect our legitimate business interests and legal rights; and \n\nFor corporation transactions, which refers to transfers of Personal Information in the event we sell or transfer, or are considering selling or transferring, all or a portion of our business or assets. \n\n5.4. We may share or disclose Children’s Personal Information in a limited number of instances, including the following: \n\nWe may share Children’s Personal Information with our Service Providers if necessary for them to perform a business, professional, or technology support function for us. Please see Appendix A for a list of Service Providers (i.e., third-party operators) who may collect Children’s Personal Information through the Services. Please contact us at the mailing address, email, or phone number listed in Section 15 (Contact Us) with questions about our, or our Service Providers’, privacy policies and practices. \n\nWe may disclose Children’s Personal Information if permitted or required by law, for example, in response to a court order or a subpoena. To the extent permitted by applicable law, we also may disclose personal information collected from children (i) in response to a law enforcement or public agency’s request; (ii) if we believe disclosure may prevent the instigation of a crime, facilitate an investigation related to public safety or protect the safety of a child; (iii) to protect the security or integrity of our Services; or (iv) enable us to take precautions against liability. \n\n5.5. We will not collect more information from your children than is reasonably necessary to provide the Services. \n\nIn accordance with COPPA, you may upon request, review the Children’s Personal Information we have collected from your child, such as name, address, telephone number, email address, and direct us to delete such information, and/or refuse us to allow any further collection or use of your Children’s Personal Information. To exercise your rights, please contact us by email at contact@mrarthur.io \n\nFor European Union data subjects, our collection of personal data from a child is limited and controlled by the parent.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("6. SECURITY".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("We maintain reasonable security procedures to protect the confidentiality, security, and integrity of the Personal Information we collect. Such practices include using technical controls to secure the information that we collect, as appropriate, including Secure Socket Layer (SSL) and password protections. \n\nMr Arthur cannot guarantee the security of the information on and sent from the Services. No transmission of data over the internet is guaranteed to be completely secure. It may be possible for third parties not under the control of Mr Arthur to intercept or access transmissions or private communications unlawfully. Neither Mr Arthur nor any of our service providers can ensure or warrant the security of any information you transmit to us over the internet. Any such transmission is done at your own risk.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("7. THIRD-PARTY WEBSITES".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("The Services may contain third-party links or include third-party integrations. Through these links and integrations, you may be providing information (including Personal Information) directly to the third-party, us, or both. You acknowledge and agree that we are not responsible for how those third parties collect or use your information. The information we collect is covered by this privacy policy, and the information the third-party collects is subject to the third-party’s privacy practices. Privacy choices you have made on any third-party site or platform will not apply to our use of the information we have collected directly through our Services. You should review the privacy policies of every third-party service that you visit or see, including those third parties you interact with through our Services.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("8. CORRECTING YOUR PERSONAL INFORMATION".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("You may request to view and, if necessary, correct Personal Information we collect about you. To do so, please contact us by using one of the contact methods provided in Section 11 (Contact Us) below. Please include your full name, mailing address and phone number in all requests.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("9. OPTING OUT OF PROMOTIONAL EMAILS".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("We allow you to choose which forms of communication you receive from us. You may opt out of receiving promotional emails from us by following the instructions in those emails. If you opt out of receiving promotional emails, we may still send you non-promotional emails, such as emails about your accounts or our ongoing business relations.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("10. NOTICE TO CALIFORNIA RESIDENTS – YOUR CALIFORNIA PRIVACY RIGHTS".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("10.1. Shine the Light: We do not sell, disclose, trade, or rent your Personal Information to third parties to market their own products or services. \n\n10.2. Do Not Track: Some Internet browsers may be configured to send “Do Not Track” signals to the online services that you visit. We currently do not respond to “Do Not Track” or similar signals. To find out more about “Do Not Track,” please visit https://www.allaboutdnt.com. \n\n10.3. California Consumer Privacy Act: The California Consumer Privacy Act (“CCPA”) affords California consumers certain rights over their Personal Information. Please see our California Privacy Notice for an outline of those rights and an explanation of how such rights may be exercised.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("11. NOTICE TO EUROPEAN UNION DATA SUBJECTS – GENERAL DATA PROTECTION REGULATION".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("This Section 11 (Notice to European Union Data Subject – General Data Protection Regulation) applies specifically to European Union data subjects. For the purpose of this section, terms used but not defined shall have the meaning ascribed to them in the General Data Protection Regulation. \n\n11.1. Data Subject Rights: You have the following rights with respect to your Personal Information where and to the extent they apply to your particular processing: \n\nThe right to request a copy of your Personal Information which the Mr Arthur holds about you; \n\nThe right to request that Mr Arthur corrects any Personal Information if it is found to be inaccurate or out of date; \n\nThe right to request your Personal Information is erased where it is no longer necessary for Mr Arthur to retain such data; \n\nThe right to withdraw your consent to the processing of your Personal Information at any time; \n\nThe right to request that Mr Arthur provides you with your Personal Information and where possible, to transmit that data directly to another data controller (where applicable); \n\nThe right, where there is a dispute in relation to the accuracy or processing of your Personal Information, to request a restriction is placed on further processing; and \n\nThe right to lodge a complaint with a European Union Data Protection or Supervisory Authority. \n\n11.2. Exercise of Data Subject Rights: You may let us know of your desire to enforce any of the rights described in this Privacy Policy by sending an email to contact@mrarthur.io, and we will respond within the time required by applicable. Please note that we may ask you to verify your identity before taking further action on your request. Please also note that laws and contractual frameworks limit your exercise of these data rights; we welcome you to ask us questions any time, and we will answer them as described above. \n\n11.3. Right to Withdraw Consent to Processing: Where you have provided your consent to the processing of your Personal Information by Mr Arthur you may withdraw your consent at any time by sending a communication to Mr Arthur specifying which consent you are withdrawing. Please note that the withdrawal of your consent does not affect the lawfulness of any processing activities based on such consent before its withdrawal. Additionally, in some jurisdictions, applicable law may give you the right to limit the ways in which we use your Personal Information, in particular where: \n\nyou contest the accuracy of your Personal Information; \n\nthe processing is unlawful, and you oppose the erasure of your Personal Information; \n\nwe no longer need your Personal Information for the purposes of the processing, but you require the information for the establishment, exercise or defense of legal claims; or \n\nyou have objected to the processing and pending the verification whether the legitimate grounds of Mr Arthur overrides your own. \n\n11.4. Complaints to Supervisory Authorities: We invite you to let us know about any and all issues regarding our data processing activities or this Privacy Policy, and we will respond to you within 30 days of receipt of such notification. If you consider that our processing of your Personal Information infringes European Union data protection laws, in particular if you are an EU resident, you have a legal right to lodge a complaint with a supervisory authority responsible for data protection. You may do so in the EU member state of your habitual residence, your place of work, or the place of the alleged infringement. For example, in the United Kingdom this is the Information Commissioner’s Office, and in Ireland this is the Data Protection Commissioner.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("12. STORAGE AND TRANSFER OF YOUR PERSONAL INFORMATION".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("The data that we collect from you will be processed and stored at a destination located in Europe. \n\nWe transfer data to destinations outside of the European Union as a necessary part of the performance of the Services, or with your consent, as applicable.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                VStack(alignment: .leading, spacing: 0){
                    Text("13. RETENTION OF YOUR PERSONAL INFORMATION".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("We keep your personal data to enable your continued use of the Services, for as long as it is required to fulfill the relevant purposes described in this Privacy Policy, as may be required by law such as for tax and accounting purposes, or as otherwise communicated to you.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("14. CHANGES TO PRIVACY POLICY".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("We reserve the right to modify this Privacy Policy at any time. If we make material changes to this Privacy Policy, we will notify you by updating the date of this Privacy Policy and posting it on the Site. We may, and if required by law, will also provide notification of changes in another way that we believe is reasonably likely to reach you, such as via email (if you have an account where we have your contact information) or another manner through the Site. \n\nAny modifications to this Privacy Policy will be effective upon our posting the new terms and/or upon implementation of the new changes on the Sites (or as otherwise indicated at the time of posting). In all cases, your continued use of the Services after the posting of any modified Privacy Policy indicates your acceptance of the terms of the modified Privacy Policy. If you do not accept this Privacy Policy, you must discontinue use of the Services.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                    
                    Text("15. CONTACT US".localized)
                        .fontModifier(
                            font: .montserratBold,
                            size: iPhoneFont22,
                            color: .secondaryBlue
                        )
                        .padding(.bottom, 2)
                    Text("If you have any questions regarding this Privacy Policy, please contact us at contact@mrarthur.io or, by mail, to: Mr Arthur, Attn: Grégoire Thomas, 4 bis Rue Lamartine, 93310 Le Pré-Saint-Gervais Paris, France.".localized)
                        .fontModifier(
                            font: .montserratRegular,
                            size: iPhoneFont18,
                            color: .secondaryBlue
                        )
                    Spacer(minLength: 16.h)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 24)
        }
        .background(
            LinearGradient(colors: [Color.lightPink, Color.secondaryRed],
                           startPoint: .top,
                           endPoint: .bottomTrailing)
        )
        .customNavigationViewWithBackWidgit(
            title: "Privacy policy".localized,
            color: .navigationBarColor
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}

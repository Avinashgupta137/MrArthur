//
//  amplitude.event.key.enum.swift
//  MrArthur
//
//  Created by Reille Sebastien on 13/09/2022.
//

import Foundation
import SwiftUI

// AT prefix for "Amplitude Tracking"
enum EAmplitudeEventKey: String {
    case APP_START = "app_start"
    //MARK: - OBS SPLASH 1
    case OBS_SPLASH_1 = "OBS_SPLASH_1"
    
    //MARK: - OBS 1ST SCREEN
    case OBS_1ST_SCREEN_1_START = "OBS_1ST_SCREEN_1_START"
    case OBS_1ST_SCREEN_1_SIGN_IN = "OBS_1ST_SCREEN_1_SIGN_IN"
    
    //MARK: - PRIVACY POLICY
    case OBS_ADD_UP_PRIVACY_1_APPLY = "OBS_ADD_UP_PRIVACY_1_APPLY"
    case OBS_ADD_UP_PRIVACY_1_AGREE_PRIVACY = "OBS_ADD_UP_PRIVACY_1_AGREE_PRIVACY"
    case OBS_ADD_UP_PRIVACY_POP_UP_3_ASK_APP_NOT_TO_TRACK = "OBS_ADD_UP_PRIVACY_POP_UP_3_ASK_APP_NOT_TO_TRACK"
    case OBS_ADD_UP_PRIVACY_POP_UP_3_ALLOW = "OBS_ADD_UP_PRIVACY_POP_UP_3_ALLOW"
    
    //MARK: - Observer Manifesto
    case OBS_MANIFESTO_INTRO_NEXT = "OBS_MANIFESTO_INTRO_NEXT"
    case OBS_MANIFESTO_INTRO_BACK = "OBS_MANIFESTO_INTRO_BACK"
    case OBS_MANIFESTO_01_NEXT = "OBS_MANIFESTO_01_NEXT"
    case OBS_MANIFESTO_01_BACK = "OBS_MANIFESTO_01_BACK"
    case OBS_MANIFESTO_02_NEXT = "OBS_MANIFESTO_02_NEXT"
    case OBS_MANIFESTO_02_BACK = "OBS_MANIFESTO_02_BACK"
    case OBS_MANIFESTO_03_NEXT = "OBS_MANIFESTO_03_NEXT"
    case OBS_MANIFESTO_03_BACK = "OBS_MANIFESTO_03_BACK"
    case OBS_QT_INTRO_NEXT = "OBS_QT_INTRO_NEXT"
    case OBS_QT_INTRO_BACK = "OBS_QT_INTRO_BACK"
    case OBS_QT_1_NEXT = "OBS_QT_1_NEXT"
    case OBS_QT_1_BACK = "OBS_QT_1_BACK"
    case OBS_QT_2_NEXT = "OBS_QT_2_NEXT"
    case OBS_QT_2_BACK = "OBS_QT_2_BACK"
    case OBS_QT_3_NEXT = "OBS_QT_3_NEXT"
    case OBS_QT_3_BACK = "OBS_QT_3_BACK"
    case OBS_QT_4_NEXT = "OBS_QT_4_NEXT"
    case OBS_QT_4_BACK = "OBS_QT_4_BACK"
    case OBS_QT_5_NEXT = "OBS_QT_5_NEXT"
    case OBS_QT_5_BACK = "OBS_QT_5_BACK"
    case OBS_QT_CARTON_1_NEXT = "OBS_QT_CARTON_1_NEXT"
    case OBS_QT_CARTON_1_BACK = "OBS_QT_CARTON_1_BACK"
    case OBS_QT_6_NEXT = "OBS_QT_6_NEXT"
    case OBS_QT_6_BACK = "OBS_QT_6_BACK"
    case OBS_QT_7_NEXT = "OBS_QT_7_NEXT"
    case OBS_QT_7_BACK = "OBS_QT_7_BACK"
    case OBS_QT_8_NEXT = "OBS_QT_8_NEXT"
    case OBS_QT_8_BACK = "OBS_QT_8_BACK"
    case OBS_MANIFESTO_4_NEXT = "OBS_MANIFESTO_4_NEXT"
    case OBS_MANIFESTO_4_BACK = "OBS_MANIFESTO_4_BACK"
    case OBS_MANIFESTO_5_NEXT = "OBS_MANIFESTO_5_NEXT"
    case OBS_MANIFESTO_5_BACK = "OBS_MANIFESTO_5_BACK"
    case OBS_MANIFESTO_6_NEXT = "OBS_MANIFESTO_6_NEXT"
    case OBS_MANIFESTO_6_BACK = "OBS_MANIFESTO_6_BACK"
    case OBS_MANIFESTO_7_NEXT = "OBS_MANIFESTO_7_NEXT"
    case OBS_MANIFESTO_7_BACK = "OBS_MANIFESTO_7_BACK"
    case OBS_MANIFESTO_8_NEXT = "OBS_MANIFESTO_8_NEXT"
    case OBS_MANIFESTO_8_BACK = "OBS_MANIFESTO_8_BACK"
    case OBS_MANIFESTO_9_NEXT = "OBS_MANIFESTO_9_NEXT"
    case OBS_MANIFESTO_9_BACK = "OBS_MANIFESTO_9_BACK"
    case OBS_QT_9_NEXT = "OBS_QT_9_NEXT"
    case OBS_QT_9_BACK = "OBS_QT_9_BACK"
    case OBS_QT_10_NEXT = "OBS_QT_10_NEXT"
    case OBS_QT_10_BACK = "OBS_QT_10_BACK"
    case OBS_QT_11_NEXT = "OBS_QT_11_NEXT"
    case OBS_QT_11_BACK = "OBS_QT_11_BACK"
    case OBS_DATA_01_NEXT = "OBS_DATA_01_NEXT"
    case OBS_DATA_02_BACK = "OBS_DATA_02_BACK"
    case OBS_QT_FINISH_NEXT = "OBS_QT_FINISH_NEXT"
    case OBS_MAIL_FINISH_NEXT = "OBS_MAIL_FINISH_NEXT"
    
    //MARK: - SIGN UP
    case OBS_MAIL_INPUT_1_CONFIRM = "OBS_MAIL_INPUT_1_CONFIRM"
    case OBS_MAIL_INPUT_1_AGREE_PRIVACY = "OBS_MAIL_INPUT_1_AGREE_PRIVACY"
    case OBS_MAIL_INPUT_1_DID_NOT_RECEIVE_A_PIN = "OBS_MAIL_INPUT_1_DID_NOT_RECEIVE_A_PIN"
    case OBS_MAIL_INPUT_1_SIGN_UP = "OBS_MAIL_INPUT_1_SIGN_UP"
    case OBS_MAIL_INPUT_1_BACK = "OBS_MAIL_INPUT_1_BACK"
    case OBS_MAIL_INPUT_1_ERROR = "OBS_MAIL_INPUT_1_ERROR"
    
    //MARK: - SIGN IN
    case OBS_LOG_1_BIS_CONFIRM = "OBS_LOG_1_BIS_CONFIRM"
    case OBS_LOG_1_BIS_BACK = "OBS_LOG_1_BIS_BACK"
    case OBS_LOG_2_1_SUBMIT = "OBS_LOG_2_1_SUBMIT"
    case OBS_LOG_2_1_DID_NOT_RECEIVE_A_PIN = "OBS_LOG_2_1_DID_NOT_RECEIVE_A_PIN"
    case OBS_LOG_2_1_BACK = "OBS_LOG_2_1_BACK"
    
    //MARK: - Attendee Manifesto
    case ATT_START_INTRO_1_NEXT = "ATT_START_INTRO_1_NEXT"
    case ATT_START_INTRO_1_BACK = "ATT_START_INTRO_1_BACK"
    case ATT_MANIFESTO_1_NEXT = "ATT_MANIFESTO_1_NEXT"
    case ATT_MANIFESTO_1_BACK = "ATT_MANIFESTO_1_BACK"
    case ATT_MANIFESTO_2_NEXT = "ATT_MANIFESTO_2_NEXT"
    case ATT_MANIFESTO_2_BACK = "ATT_MANIFESTO_2_BACK"
    case ATT_MANIFESTO_3_NEXT = "ATT_MANIFESTO_3_NEXT"
    case ATT_MANIFESTO_3_BACK = "ATT_MANIFESTO_3_BACK"
    case ATT_MANIFESTO_4_NEXT = "ATT_MANIFESTO_4_NEXT"
    case ATT_MANIFESTO_4_BACK = "ATT_MANIFESTO_4_BACK"
    case ATT_MANIFESTO_5_NEXT = "ATT_MANIFESTO_5_NEXT"
    case ATT_MANIFESTO_5_BACK = "ATT_MANIFESTO_5_BACK"
    case ATT_MANIFESTO_6_NEXT = "ATT_MANIFESTO_6_NEXT"
    case ATT_MANIFESTO_6_BACK = "ATT_MANIFESTO_6_BACK"
    case ATT_MANIFESTO_7_NEXT = "ATT_MANIFESTO_7_NEXT"
    case ATT_MANIFESTO_7_BACK = "ATT_MANIFESTO_7_BACK"
    case ATT_MANIFESTO_8_NEXT = "ATT_MANIFESTO_8_NEXT"
    case ATT_MANIFESTO_8_BACK = "ATT_MANIFESTO_8_BACK"
    case ATT_QT_1_NEXT = "ATT_QT_1_NEXT"
    case ATT_QT_1_BACK = "ATT_QT_1_BACK"
    case ATT_QT_2_NEXT = "ATT_QT_2_NEXT"
    case ATT_QT_2_BACK = "ATT_QT_2_BACK"
    case ATT_QT_3_NEXT = "ATT_QT_3_NEXT"
    case ATT_QT_3_BACK = "ATT_QT_3_BACK"
    case ATT_QT_4_NEXT = "ATT_QT_4_NEXT"
    case ATT_QT_4_BACK = "ATT_QT_4_BACK"
    case ATT_QT_CARTON_1_NEXT = "ATT_QT_CARTON_1_NEXT"
    case ATT_QT_CARTON_1_BACK = "ATT_QT_CARTON_1_BACK"
    case ATT_QT_5_NEXT = "ATT_QT_5_NEXT"
    case ATT_QT_5_BACK = "ATT_QT_5_BACK"
    case ATT_QT_6_NEXT = "ATT_QT_6_NEXT"
    case ATT_QT_6_BACK = "ATT_QT_6_BACK"
    case ATT_QT_7_NEXT = "ATT_QT_7_NEXT"
    case ATT_QT_7_BACK = "ATT_QT_7_BACK"
    case ATT_QT_8_NEXT = "ATT_QT_8_NEXT"
    case ATT_QT_8_BACK = "ATT_QT_8_BACK"
    case ATT_QT_CARTON_2_NEXT = "ATT_QT_CARTON_2_NEXT"
    case ATT_QT_CARTON_2_BACK = "ATT_QT_CARTON_2_BACK"
    case ATT_DATA_1_NEXT = "ATT_DATA_1_NEXT"
    
    //MARK: - Create Attendee
    case OBS_ADD_UP_2_FILLE_NEXT = "OBS_ADD_UP_2_FILLE_NEXT"
    case OBS_ADD_UP_2_FILLE_CANCEL = "OBS_ADD_UP_2_FILLE_CANCEL"
    case OBS_ADD_UP_2_FILLE_BACK = "OBS_ADD_UP_2_FILLE_BACK"
    
    case OBS_ADD_UP_ESTIM_1_NEXT = "OBS_ADD_UP_ESTIM_1_NEXT"
    case OBS_ADD_UP_ESTIM_1_BACK = "OBS_ADD_UP_ESTIM_1_BACK"
    case OBS_ADD_UP_ESTIM_2_NEXT = "OBS_ADD_UP_ESTIM_2_NEXT"
    case OBS_ADD_UP_ESTIM_2_BACK = "OBS_ADD_UP_ESTIM_2_BACK"
    case OBS_ADD_UP_ESTIM_3_NEXT = "OBS_ADD_UP_ESTIM_3_NEXT"
    case OBS_ADD_UP_ESTIM_3_BACK = "OBS_ADD_UP_ESTIM_3_BACK"
    case OBS_ADD_UP_ESTIM_4_NEXT = "OBS_ADD_UP_ESTIM_4_NEXT"
    case OBS_ADD_UP_ESTIM_4_BACK = "OBS_ADD_UP_ESTIM_4_BACK"
    case OBS_ADD_UP_ESTIM_5_NEXT = "OBS_ADD_UP_ESTIM_5_NEXT"
    case OBS_ADD_UP_ESTIM_5_BACK = "OBS_ADD_UP_ESTIM_5_BACK"
    case OBS_ADD_UP_ESTIM_6_NEXT = "OBS_ADD_UP_ESTIM_6_NEXT"
    case OBS_ADD_UP_ESTIM_6_BACK = "OBS_ADD_UP_ESTIM_6_BACK"
    

    //MARK: - ATTENDEE PAIRING SETUP
    case OBS_ON_ATTENDEE_SET_UP_1_1_SET_UP_FAMILY_SHARING = "OBS_ON_ATTENDEE_SET_UP_1_1_SET_UP_FAMILY_SHARING"
    case OBS_ON_ATTENDEE_SET_UP_1_27_DONE = "OBS_ON_ATTENDEE_SET_UP_1_27_DONE"
    case OBS_ON_ATTENDEE_SET_UP_1_2_PAIRING_DEVICE = "OBS_ON_ATTENDEE_SET_UP_1_2_PAIRING_DEVICE"
    case OBS_ON_ATTENDEE_SET_UP_1_3_NEXT = "OBS_ON_ATTENDEE_SET_UP_1_3_NEXT"
    case OBS_ON_ATTENDEE_SET_UP_1_4_APP_CATEGORIES_PICKING = "OBS_ON_ATTENDEE_SET_UP_1_4_APP_CATEGORIES_PICKING"
    case OBS_ON_ATTENDEE_SET_UP_1_6_NEXT = "OBS_ON_ATTENDEE_SET_UP_1_6_NEXT"
    case OBS_ON_ATTENDEE_SET_UP_1_DEFAULT = "OBS_ON_ATTENDEE_SET_UP_1_DEFAULT"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_0 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_0"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_1 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_1"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_2 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_2"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_3 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_3"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_4 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_4"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_5 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_5"
    case OBS_ON_ATTENDEE_SET_UP_1_CASE_6 = "OBS_ON_ATTENDEE_SET_UP_1_CASE_6"
    case OBS_ON_ATTENDEE_SET_UP_1_8 = "OBS_ON_ATTENDEE_SET_UP_1_8"
    case OBS_ON_ATTENDEE_SET_UP_1_8_BACK = "OBS_ON_ATTENDEE_SET_UP_1_8_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_11_PICK_CATEGORIES = "OBS_ON_ATTENDEE_SET_UP_1_11_PICK_CATEGORIES"
    case OBS_ON_ATTENDEE_SET_UP_1_11_BACK = "OBS_ON_ATTENDEE_SET_UP_1_11_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_12_PICK_CATEGORIES_CANCEL = "OBS_ON_ATTENDEE_SET_UP_1_12_PICK_CATEGORIES_CANCEL"
    case OBS_ON_ATTENDEE_SET_UP_1_12_PICK_CATEGORIES_DONE = "OBS_ON_ATTENDEE_SET_UP_1_12_PICK_CATEGORIES_DONE"
    case OBS_ON_ATTENDEE_SET_UP_1_13 = "OBS_ON_ATTENDEE_SET_UP_1_13"
    case OBS_ON_ATTENDEE_SET_UP_1_14_PICK_CATEGORIES = "OBS_ON_ATTENDEE_SET_UP_1_14_PICK_CATEGORIES"
    case OBS_ON_ATTENDEE_SET_UP_1_15_PICK_CATEGORIES_CANCEL = "OBS_ON_ATTENDEE_SET_UP_1_15_PICK_CATEGORIES_CANCEL"
    case OBS_ON_ATTENDEE_SET_UP_1_15_PICK_CATEGORIES_DONE = "OBS_ON_ATTENDEE_SET_UP_1_15_PICK_CATEGORIES_DONE"
    case OBS_ON_ATTENDEE_SET_UP_1_14_BACK = "OBS_ON_ATTENDEE_SET_UP_1_14_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_16 = "OBS_ON_ATTENDEE_SET_UP_1_16"
    case OBS_ON_ATTENDEE_SET_UP_1_19_BACK = "OBS_ON_ATTENDEE_SET_UP_1_19_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_19_PICK_CATEGORIES = "OBS_ON_ATTENDEE_SET_UP_1_19_PICK_CATEGORIES"
    case OBS_ON_ATTENDEE_SET_UP_1_17_PICK_CATEGORIES_CANCEL = "OBS_ON_ATTENDEE_SET_UP_1_17_PICK_CATEGORIES_CANCEL"
    case OBS_ON_ATTENDEE_SET_UP_1_17_PICK_CATEGORIES_DONE = "OBS_ON_ATTENDEE_SET_UP_1_17_PICK_CATEGORIES_DONE"
    case OBS_ON_ATTENDEE_SET_UP_1_18 = "OBS_ON_ATTENDEE_SET_UP_1_18"
    case OBS_ON_ATTENDEE_SET_UP_1_44_BACK = "OBS_ON_ATTENDEE_SET_UP_1_44_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_44_PICK_APP = "OBS_ON_ATTENDEE_SET_UP_1_44_PICK_APP"
    case OBS_ON_ATTENDEE_SET_UP_1_42_PICK_APP_CANCEL = "OBS_ON_ATTENDEE_SET_UP_1_17_PICK_APP_CANCEL"
    case OBS_ON_ATTENDEE_SET_UP_1_42_PICK_APP_DONE = "OBS_ON_ATTENDEE_SET_UP_1_42_PICK_APP_DONE"
    case OBS_ON_ATTENDEE_SET_UP_1_42_SKIP = "OBS_ON_ATTENDEE_SET_UP_1_42_SKIP"
    case OBS_ON_ATTENDEE_SET_UP_1_43 = "OBS_ON_ATTENDEE_SET_UP_1_43"
    case OBS_ON_ATTENDEE_SET_UP_1_45 = "OBS_ON_ATTENDEE_SET_UP_1_45"
    case OBS_ON_ATTENDEE_SET_UP_1_5_CONTENT_FILTER = "OBS_ON_ATTENDEE_SET_UP_1_5_CONTENT_FILTER"
    case OBS_ON_ATTENDEE_SET_UP_1_20_LOW_LEVEL_SELECT = "OBS_ON_ATTENDEE_SET_UP_1_20_LOW_LEVEL_SELECT"
    case OBS_ON_ATTENDEE_SET_UP_1_20_MEDIUM_LEVEL_SELECT = "OBS_ON_ATTENDEE_SET_UP_1_20_MEDIUM_LEVEL_SELECT"
    case OBS_ON_ATTENDEE_SET_UP_1_20_HIGH_LEVEL_SELECT = "OBS_ON_ATTENDEE_SET_UP_1_20_HIGH_LEVEL_SELECT"
    case OBS_ON_ATTENDEE_SET_UP_1_20_NO_CONTECT_SELECT = "OBS_ON_ATTENDEE_SET_UP_1_20_NO_CONTECT_SELECT"
    case OBS_ON_ATTENDEE_SET_UP_1_20_BACK = "OBS_ON_ATTENDEE_SET_UP_1_20_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_36_EDUCATIONAL_APP_INSTALLATION = "OBS_ON_ATTENDEE_SET_UP_1_36_EDUCATIONAL_APP_INSTALLATION"
    case OBS_ON_ATTENDEE_SET_UP_1_37_DONE = "OBS_ON_ATTENDEE_SET_UP_1_37_DONE"
    case OBS_ON_ATTENDEE_SET_UP_1_37_BACK = "OBS_ON_ATTENDEE_SET_UP_1_37_BACK"
    case OBS_ON_ATTENDEE_SET_UP_1_38_SEE_ON_APPSTORE = "OBS_ON_ATTENDEE_SET_UP_1_38_SEE_ON_APPSTORE"
    case OBS_ON_ATTENDEE_SET_UP_1_38_SHARE = "OBS_ON_ATTENDEE_SET_UP_1_38_SHARE"
    case OBS_ON_ATTENDEE_SET_UP_1_38_INSTALL_APP = "OBS_ON_ATTENDEE_SET_UP_1_38_INSTALL_APP"
    
    
    //MARK: - ATTENDEE DASHBOARD
    case OBS_SIGN_IN_USER_CHOICE_2_ATTENDEE = "OBS_SIGN_IN_USER_CHOICE_2_ATTENDEE"
    case OBS_SIGN_IN_USER_CHOICE_2_ADD_NEW_CHILD = "OBS_SIGN_IN_USER_CHOICE_2_ADD_NEW_CHILD"
    case OBS_SIGN_IN_USER_CHOICE_2_BACK = "OBS_SIGN_IN_USER_CHOICE_2_BACK"
    
    //MARK: - TERMS & CONDITIONS
    case OBS_MAIL_INPUT_1_BIS_ACCEPT_ALL = "OBS_MAIL_INPUT_1_BIS_ACCEPT_ALL"
    case OBS_MAIL_INPUT_1_BIS_BACK = "OBS_MAIL_INPUT_1_BIS_BACK"
    
    case ATT_START_INTRO_2_OK = "ATT_START_INTRO_2_OK"
    
    //MARK: - OBSERVER GOAL VIEW
    case OBS_CO_3_REFUSE = "OBS_CO_3_REFUSE"
    case OBS_CO_3_ACCEPT = "OBS_CO_3_ACCEPT"
    case OBS_CO_3_BACK = "OBS_CO_3_BACK"
    
    //MARK: - OBSERVER DASHBOARD
    case OBS_CO_1_ATTENDEE_LIST = "OBS_CO_1_ATTENDEE_LIST"
    case OBS_CO_1_DASHBOARD = "OBS_CO_1_DASHBOARD"
    case OBS_CO_1_ATTENDEE_PROFILE = "OBS_CO_1_ATTENDEE_PROFILE"
    case OBS_CO_2_SEE_CHILD_GOAL = "OBS_CO_2_SEE_CHILD_GOAL"
    case OBS_CO_4_SEE_MORE = "OBS_CO_4_SEE_MORE"
    case ATT_CO_3_3_IMPROVE = "ATT_CO_3_3_IMPROVE"
    case ATT_CO_3_3_CONFIRM = "ATT_CO_3_3_CONFIRM"
    
    //MARK: - OBSERVER MORE
    case OBS_PLUS_1_1_ADD_NEW_CHILD = "OBS_PLUS_1_1_ADD_NEW_CHILD"
    case OBS_PLUS_1_1_PRIVACY_POLICY = "OBS_PLUS_1_1_PRIVACY_POLICY"
    case OBS_PLUS_1_1_ACCOUNT = "OBS_PLUS_1_1_ACCOUNT"
    case OBS_PLUS_1_1_FREQUENT_QUESTION = "OBS_PLUS_1_1_FREQUENT_QUESTION"
    case OBS_PLUS_1_1_LOGOUT = "OBS_PLUS_1_1_LOGOUT"
    case OBS_PLUS_4_1_LOGOUT_CONFIRM = "OBS_PLUS_4_1_LOGOUT_CONFIRM"
    case OBS_PLUS_3_1_BACK = "OBS_PLUS_3_1_BACK"
    case OBS_PLUS_3_1_DELETE_MY_ACCOUNT = "OBS_PLUS_3_1_DELETE_MY_ACCOUNT"
    
    //MARK: - ATTENDEE EDIT PROFILE
    
    case OBS_SETTING_2_BACK = "OBS_SETTING_2_BACK"
    case OBS_SETTING_2_EDIT_FIRST_NAME = "OBS_SETTING_2_EDIT_FIRST_NAME"
    case OBS_SETTING_2_EDIT_DOB = "OBS_SETTING_2_EDIT_DOB"
    case OBS_SETTING_2_DONE = "OBS_SETTING_2_DONE"
    case OBS_SETTING_5_DELETE_CHILD_PROFILE = "OBS_SETTING_5_DELETE_CHILD_PROFILE"
    case OBS_SETTING_5_BACK = "OBS_SETTING_5_BACK"
    case OBS_PLUS_3_ACCOUNT_DETAILS = "OBS_PLUS_3_ACCOUNT_DETAILS"
    case OBS_PLUS_4_1_LOGOUT = "OBS_PLUS_4_1_LOGOUT"
    
    //MARK: - NOTIFICATION
    
    case OBS_ADD_UP_NOTIFICATIONS_1_ENABLE_NOTIFICATIONS = "OBS_ADD_UP_NOTIFICATIONS_1_ENABLE_NOTIFICATIONS"
    case OBS_ADD_UP_NOTIFICATIONS_1_MAYBE_LATER = "OBS_ADD_UP_NOTIFICATIONS_1_MAYBE_LATER"
    
    //MARK: - OBS ADD UP
    case OBS_ADD_UP_FINISH_NEXT = "OBS_ADD_UP_FINISH_NEXT"
    case OBS_ADD_UP_FINISH_BACK = "OBS_ADD_UP_FINISH_BACK"
    case OBS_ADD_UP_FINISH_3_BACK = "OBS_ADD_UP_FINISH_3_BACK"
    case OBS_ADD_UP_FINISH_3_ALL_IS_DONE = "OBS_ADD_UP_FINISH_3_ALL_IS_DONE"
    case OBS_DATA_GAIN_01_NEXT = "OBS_DATA_GAIN_01_NEXT"
    case OBS_DATA_GAIN_01_BACK = "OBS_DATA_GAIN_01_BACK"
    case OBS_DATA_GAIN_02_NEXT = "OBS_DATA_GAIN_02_NEXT"
    case OBS_DATA_GAIN_02_BACK = "OBS_DATA_GAIN_02_BACK"
    case OBS_DATA_GAIN_02_NEXT_PAYWALL = "OBS_DATA_GAIN_02_NEXT_PAYWALL"
    
    //MARK: - SCREEN TIME DASHBOARD
    case OBS_DASH_BENEFITS_01_BACK = "OBS_DASH_BENEFITS_01_BACK"
    case OBS_DASH_BENEFITS_01_SHARE = "OBS_DASH_BENEFITS_01_SHARE"
    case OBS_DASH_BENEFITS_01_2_BACK = "OBS_DASH_BENEFITS_01_2_BACK"
    case OBS_DASH_BENEFITS_01_2_SHARE = "OBS_DASH_BENEFITS_01_2_SHARE"
    case OBS_DASH_TIME_01_START_ATTENDEE_LIST = "OBS_DASH_TIME_01_START_ATTENDEE_LIST"
    case OBS_DASH_TIME_01_START_ATTENDEE_PROFILE = "OBS_DASH_TIME_01_START_ATTENDEE_PROFILE"
    case OBS_DASH_TIME_01_START_EDUCATIONAL_PROFIT = "OBS_DASH_TIME_01_START_EDUCATIONAL_PROFIT"
    case OBS_DASH_TIME_01_START_TIME_SAVED_FROM_SCREENS = "OBS_DASH_TIME_01_START_TIME_SAVED_FROM_SCREENS"
    case ATT_CO_3_CONFIRM = "ATT_CO_3_CONFIRM"

    //MARK: - WHICH DEVICE ARE YOU USING
    case OBS_ADD_UP_DEVICE_1_1_MINE_AS_A_PARENT = "OBS_ADD_UP_DEVICE_1_1_MINE_AS_A_PARENT"
    case OBS_ADD_UP_DEVICE_1_1_MINE_AS_MY_CHILD = "OBS_ADD_UP_DEVICE_1_1_MINE_AS_MY_CHILD"
    
    
    //MARK: - ATTENDEE DASHBOARD
    case ATT_CO_1_CREATE_GOAL = "ATT_CO_1_CREATE_GOAL"
    case ATT_CO_5_SEE_MY_GOAL = "ATT_CO_5_SEE_MY_GOAL"
    case ATT_CO_6_LETS_GET_STARTED = "ATT_CO_6_LETS_GET_STARTED"
    case ATT_CO_7_BIS_I_CAN_DO_BETTER = "ATT_CO_7_BIS_I_CAN_DO_BETTER"
    case OBS_CO_8_RESET = "OBS_CO_8_RESET"
    case OBS_CO_8_AUTO_EDUCATION = "OBS_CO_8_AUTO_EDUCATION"
    case OBS_CO_8_AUTO_TOTAL_SCREEN_TIME = "OBS_CO_8_AUTO_TOTAL_SCREEN_TIME"
    case OBS_CO_8_PLUS_EDUCATION = "OBS_CO_8_PLUS_EDUCATION"
    case OBS_CO_8_MINUS_TOTAL_SCREEN_TIME = "OBS_CO_8_MINUS_TOTAL_SCREEN_TIME"
    
    case OBS_CO_8_SEND = "OBS_CO_8_SEND"
    case OBS_CO_8_BACK = "OBS_CO_8_BACK"
    case ATT_PLUS_MENU_SETTINGS = "ATT_PLUS_MENU_SETTINGS"
    case ATT_PLUS_MENU_PRIVACY_POLICY = "ATT_PLUS_MENU_PRIVACY_POLICY"
    case ATT_PLUS_MENU_FREQUENT_QUESTIONS = "ATT_PLUS_MENU_FREQUENT_QUESTIONS"
    case ATT_PLUS_SETTING_ALERT_1_OK = "ATT_PLUS_SETTING_ALERT_1_OK"
    case ATT_PLUS_SETTING_ALERT_1_BACK = "ATT_PLUS_SETTING_ALERT_1_BACK"
    case ATT_PLUS_SETTING_ALERT_1_CANCEL = "ATT_PLUS_SETTING_ALERT_1_CANCEL"
    case ATT_PLUS_LOG_OUT_MAIL_1_CONFIRM = "ATT_PLUS_LOG_OUT_MAIL_1_CONFIRM"
    case ATT_PLUS_LOG_OUT_1_APP_CATEGORIES_PICKING = "ATT_PLUS_LOG_OUT_1_APP_CATEGORIES_PICKING"
    case ATT_PLUS_LOG_OUT_1_CONTENT_FILTERING_SELECTION = "ATT_PLUS_LOG_OUT_1_CONTENT_FILTERING_SELECTION"
    case ATT_PLUS_LOG_OUT_1_EDUCATIONAL_APP_INSTALLATION = "ATT_PLUS_LOG_OUT_1_EDUCATIONAL_APP_INSTALLATION"
    case ATT_PLUS_LOG_OUT_1_BACK = "ATT_PLUS_LOG_OUT_1_BACK"
    case ATT_PLUS_LOG_OUT_1_CANCEL = "ATT_PLUS_LOG_OUT_1_CANCEL"
    case ATT_PLUS_LOG_OUT_MAIL_1_BACK = "ATT_PLUS_LOG_OUT_MAIL_1_BACK"
    case ATT_PLUS_LOG_OUT_MAIL_1_CANCEL = "ATT_PLUS_LOG_OUT_MAIL_1_CANCEL"
    case ATT_PLUS_LOG_OUT_PIN_1_ACCESS_SETTINGS = "ATT_PLUS_LOG_OUT_PIN_1_ACCESS_SETTINGS"
    case ATT_PLUS_LOG_OUT_PIN_1_DID_NOT_RECEIVE_A_PIN = "ATT_PLUS_LOG_OUT_PIN_1_DID_NOT_RECEIVE_A_PIN"
    case ATT_PLUS_LOG_OUT_PIN_1_BACK = "ATT_PLUS_LOG_OUT_PIN_1_BACK"
    case ATT_PLUS_LOG_OUT_PIN_1_CANCEL = "ATT_PLUS_LOG_OUT_PIN_1_CANCEL"
    case ATT_PLUS_PIN_ERROR_1 = "ATT_PLUS_PIN_ERROR_1"
    case ATT_PLUS_LOG_OUT_MAIL_ERROR_1 = "ATT_PLUS_LOG_OUT_MAIL_ERROR_1"
    case ATT_MEDIAS_MAIN_LIBRARY_2_PLAY = "ATT_MEDIAS_MAIN_LIBRARY_2_PLAY"
    case ATT_MEDIAS_MAIN_LIBRARY_4 = "ATT_MEDIAS_MAIN_LIBRARY_4"
    case ATT_MEDIAS_MAIN_LIBRARY_2_SHARE = "ATT_MEDIAS_MAIN_LIBRARY_2_SHARE"
    case ATT_CO_4_BIS_BACK = "ATT_CO_4_BIS_BACK"
    case OBS_HOW_IT_WORKS_2_11_OK = "OBS_HOW_IT_WORKS_2_11_OK"
    case ATT_PLUS_MENU = "ATT_PLUS_MENU"

}

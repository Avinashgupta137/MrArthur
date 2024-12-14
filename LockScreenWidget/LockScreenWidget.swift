//
//  LockScreenWidget.swift
//  LockScreenWidget
//
//  Created by BAPS on 11/01/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        WigetAPIService.getDataFromServer { attendee, todayDataResponse in
            let entry = SimpleEntry(
                date: Date(),
                attendee: attendee,
                todayDataResponse: todayDataResponse
            )
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
//        let currentDate = Date()
//        let nextDate = Calendar.current.date(byAdding: .second, value: 20, to: currentDate)!
//
        WigetAPIService.getDataFromServer { attendee, todayDataResponse in
            let entries = [
                SimpleEntry(
                    date: Date(),
                    attendee: attendee,
                    todayDataResponse: todayDataResponse
                )
            ]
            let timeline = Timeline(entries: entries, policy: .after(.now.advanced(by: 2)))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var attendee: AttendeeListResponseModel?
    var todayDataResponse: GetAttendeeScreenTimeTodayDataResponse?
    
    var name: String {
        return attendee?.attendeeName ?? ""
    }
    var eduTimeSpent: String {
        return WidgetUtility.getTimeString(todayDataResponse?.eduTimeSpent ?? 0)
    }
    
    var entTimeLeft: String {
        let iEntTimeLeft = (todayDataResponse?.unlockedTime ?? 0) - (todayDataResponse?.entTimeSpent ?? 0)
        return WidgetUtility.getTimeString(iEntTimeLeft)
    }
    var totalTimeSaved: String {
        return WidgetUtility.getTotalTimeSave(todayDataResponse?.totalSecondSaved ?? 0)
    }
    var restPeriod: String {
        return WidgetUtility.getStringFromERestPeriod(restPeriod: attendee?.parentalControlSettings?.restPeriod)// attendee?.parentalControlSettings?.restPeriod ?? "NOT SET"
    }
}

struct LockScreenWidgetEntryView : View {
    
    var entry: Provider.Entry
    var seprator: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: 0.2.h)
            .padding(.vertical, 1.5.r)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(entry.name)
                .font(.system(size: 13.sp, weight: .bold, design: .rounded))
//            +
//            Text(" "+entry.date.getFormattedDate(format: "hh:mm:ss"))
//                .font(.system(size: 10.sp, weight: .regular, design: .rounded))
            WidgetRowView(
                icon: "ic_widget_education_time_spent",
                label: "Educational time spent",
                value: entry.eduTimeSpent
            )
            seprator
            WidgetRowView(
                icon: "ic_widget_entertainment_time_left",
                label: "Entertainment time left",
                value: entry.entTimeLeft
            )
            seprator
            WidgetRowView(
                icon: "ic_widget_total_time_saved",
                label: "Total time saved",
                value: entry.totalTimeSaved
            )
            seprator
            WidgetRowView(
                icon: "ic_widget_rest_period",
                label: "Rest period",
                value: entry.restPeriod
            )
        }
    }
}

struct LockScreenWidget: Widget {
    let kind: String = "LockScreenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LockScreenWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryRectangular])
    }
}
    

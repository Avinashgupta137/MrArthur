//
//  AttendeeDashboardWhatYouGetOutView.swift
//  MrArthur
//
//  Created by Troo on 02/08/22.
//

import SwiftUI

struct AttendeeDashboardWhatYouGetOutView: View {
    let comics:Int
    let bikeTrip:Int
    let movies:Int
    var body: some View {
        
        let comicTitle = "\((comics))" + " " + "comics".localized
        let FomoBikeTitle = "\((bikeTrip))" + " " + "miles/\nbike rides".localized
        let moviesTitle = "\((movies))" + " " + "afternoons".localized
        
        return HStack(spacing: 5) {
            AttendeeDashboardWhatYouGetOutCardView(
                icon: "FomoBook",
                title: comicTitle/*"\(comics) comics".localized*/,
                subTitle: "per year".localized
            )
            
            AttendeeDashboardWhatYouGetOutCardView(
                icon: "FomoBike",
                title: FomoBikeTitle/*"\(bikeTrip) Paris/\nMarseille".localized*/,
                subTitle: "bike trips".localized
            )
            
            AttendeeDashboardWhatYouGetOutCardView(
                icon: "FomoFriendsMovie",
                title: moviesTitle/*"\(movies) afternoons".localized*/,
                subTitle: "with friends".localized
            )
        }
    }
}

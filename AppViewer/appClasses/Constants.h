//
//  Constants.h
//  AppViewer
//
//  Created by Mark Dubouzet on 9/10/12.
//
//


//*** This is added ADDED IN: AppViewer-Prefix.pch

#define SERVER_URI @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json"
#define NUMBER_OF_DETAIL_ATTRIBUTES 9
#define EMAIL_LAUNCHED_NOTIFICATION @"EMAIL_LAUNCHED_NOTIFICATION"

enum ServerFeedbackTypes{
    ServerFeedbackTypeLoading = 0,
    ServerFeedbackTypeSuccess,
    ServerFeedbackTypeNone,
    ServerFeedbackTypeFail
};

enum TabBarSectionTypes{
    TabBarSectionApps = 0,
    TabBarSectionSavedApps
};

enum DetailTableRow{
    DetailRowImageAndTitle =0,
    DetailRowShare,
    DetailRowPrice,
    DetailRowSummary,
    DetailRowDatelabel,
    DetailRowURLLink,
    DetailRowID,
    DetailRowArtist,
    DetailRowCategory,
    
};

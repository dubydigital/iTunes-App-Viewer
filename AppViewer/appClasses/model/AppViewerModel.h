//
//  AppViewerModel.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//
//



#import <Foundation/Foundation.h>
#import "WebServiceUtil.h"
#import "AppObject.h"
//#import "Constants.h"

@interface AppViewerModel : NSObject{
    NSMutableArray *_appsArray;
    AppObject *_currentAppInPlay;
}
@property(nonatomic,retain)AppObject *currentAppInPlay;
@property(nonatomic,retain) NSMutableArray *appsArray;
-(NSArray *)getAppsArr;


#pragma mark - Singleton Methods
+ (AppViewerModel *)sharedInstance;

@end


/*
 //------------------------------------------------------
 JSON SAMPLE
 //------------------------------------------------------
 
 {
 "im:name": {
 "label": "Pandora Radio"
 },
 "im:image": [
 {
 "label": "http://a2.mzstatic.com/us/r1000/079/Purple/v4/8a/1f/fc/8a1ffc4b-ea2d-8050-fdb0-2ccbc6ca6525/mzl.apbtuehg.53x53-50.png",
 "attributes": {
 "height": "53"
 }
 },
 {
 "label": "http://a5.mzstatic.com/us/r1000/079/Purple/v4/8a/1f/fc/8a1ffc4b-ea2d-8050-fdb0-2ccbc6ca6525/mzl.apbtuehg.75x75-65.png",
 "attributes": {
 "height": "75"
 }
 },
 {
 "label": "http://a5.mzstatic.com/us/r1000/079/Purple/v4/8a/1f/fc/8a1ffc4b-ea2d-8050-fdb0-2ccbc6ca6525/mzl.apbtuehg.100x100-75.png",
 "attributes": {
 "height": "100"
 }
 }
 ],
 "summary": {
 "label": "Pandora Radio is free personalized radio that only plays music you’ll love. Just start with the name of one of your favorite artists, songs or classical composers and Pandora will create a custom \"station\" that plays similar music.\n \nAlready a Pandora listener? Even easier. Just log in. Pandora on iPhone is fully integrated with Pandora on the web. Enjoy all your existing stations - and create new ones right from youriPhone, iPod Touch or iPad.\n \nYou can also subscribe to Pandora One for $3.99 per month. \nPandora One gives you:\n• No Ads everywhere you listen to Pandora\nPlus the following features on the web:\n• Higher Quality Audio\n• Desktop Application\n• Custom Skins\n• Fewer Interruptions\n \nYour Pandora One subscription will automatically renew each month and your credit card will be charged through your iTunes account. You can turn off auto-renew at any time from your iTunes account settings.\n\nSUBSCRIBERS’ AUTOMATIC-RENEWAL FEATURE: Your subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Your iTunes account will automatically be charged at the same price for renewal within 24-hours prior to the end of the current monthly period unless you change your subscription preferences in your account settings. You can manage your subscriptions through your Account Settings after purchase. No cancellation of the current subscription is allowed during active subscription period. Please go to www.pandora.com/privacy and pandora.com/legal_apple for more information."
 },
 "im:price": {
 "label": "Free",
 "attributes": {
 "amount": "0.00000",
 "currency": "USD"
 }
 },
 "im:contentType": {
 "attributes": {
 "term": "Application",
 "label": "Application"
 }
 },
 "rights": {
 "label": "© 2008 Pandora Media, Inc."
 },
 "title": {
 "label": "Pandora Radio - Pandora Media, Inc."
 },
 "link": [
 {
 "attributes": {
 "rel": "alternate",
 "type": "text/html",
 "href": "http://itunes.apple.com/us/app/pandora-radio/id284035177?mt=8&uo=2"
 }
 },
 {
 "im:duration": {
 "label": "0"
 },
 "attributes": {
 "title": "Preview",
 "rel": "enclosure",
 "type": "image/jpeg",
 "href": "http://a2.mzstatic.com/us/r1000/063/Purple/v4/33/fa/da/33fada33-cca7-af32-5e04-1d05879c3eb1/mzl.uotpmbbk.1024x1024-65.jpg",
 "im:assetType": "preview"
 }
 }
 ],
 "id": {
 "label": "http://itunes.apple.com/us/app/pandora-radio/id284035177?mt=8&uo=2",
 "attributes": {
 "im:id": "284035177",
 "im:bundleId": "com.pandora"
 }
 },
 "im:artist": {
 "label": "Pandora Media, Inc.",
 "attributes": {
 "href": "http://itunes.apple.com/us/artist/pandora-media-inc./id284035180?mt=8&uo=2"
 }
 },
 "category": {
 "attributes": {
 "im:id": "6011",
 "term": "Music",
 "scheme": "http://itunes.apple.com/us/genre/ios-music/id6011?mt=8&uo=2",
 "label": "Music"
 }
 },
 "im:releaseDate": {
 "label": "2008-07-11T00:00:00-07:00",
 "attributes": {
 "label": "July 11, 2008"
 }
 }
 }
 */

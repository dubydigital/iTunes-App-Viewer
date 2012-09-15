//
//  WebServiceUtil.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//
//

#import <Foundation/Foundation.h>


@interface WebServiceUtil : NSObject


+ (NSDictionary *)getiTunesAppsService:(NSString *)server_uri;
@end

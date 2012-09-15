//
//  CoreDataUtil.h
//  AppViewer
//
//  Created by Mark Dubouzet on 9/10/12.
//
//

#import <Foundation/Foundation.h>
#import "DDAppDelegate.h"
#import "AppEntity.h"
//#import "Constants.h"
#import "AppObject.h"


@interface CoreDataUtil : NSObject

+(void)saveAppToFavorites:(AppObject*) appObject;
+(void)deleteSavedAppWithId:(NSString*)idString;
+(NSArray*)getAllSavedApps;
@end

//
//  CoreDataUtil.m
//  AppViewer
//
//  Created by Mark Dubouzet on 9/10/12.
//
//

#import "CoreDataUtil.h"


@implementation CoreDataUtil: NSObject

+(void)saveAppToFavorites:(AppObject*) appObject{
    NSManagedObjectContext *context =  [(DDAppDelegate*)[[UIApplication sharedApplication] delegate]managedObjectContext];

    AppEntity *appEntity = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"AppEntity"
                                      inManagedObjectContext:context];

    appEntity.name = appObject.name;
    appEntity.imgURLString = appObject.imgURLString;
    appEntity.imgDetailURLString = appObject.imgDetailURLString;
    appEntity.summary = appObject.summary;
    appEntity.title = appObject.title;
    appEntity.linkURLString = appObject.linkURLString;
    appEntity.idString = appObject.idString;
    appEntity.artist = appObject.artist;
    appEntity.category = appObject.category;
    appEntity.dateLabel = appObject.dateLabel;
    appEntity.price = [NSNumber numberWithInt:appObject.price];

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

+(void)deleteSavedAppWithId:(NSString*)idString{
    NSManagedObjectContext *context = [(DDAppDelegate*)[[UIApplication sharedApplication] delegate]managedObjectContext];
    
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"AppEntity" inManagedObjectContext:context]];
	
	NSError * error = nil;
	NSArray * appsArr = [context executeFetchRequest:fetchRequest error:&error];
    
	for (AppEntity * appEntity in appsArr) {
		if([appEntity.idString isEqualToString: idString]){
			[context  deleteObject:appEntity];
		}
	}
	
	//SAVE
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    } else {
        NSLog(@"ON BRABBLE DELETE NOTIFICATION BEING CALLED");
    }
    
    [fetchRequest release];
    
}

+(NSArray*)getAllSavedApps{
    // Test listing all FailedBankInfos from the store
    NSManagedObjectContext *context = [(DDAppDelegate*)[[UIApplication sharedApplication] delegate]managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AppEntity"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError * error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray * appsArr = [[NSMutableArray alloc] initWithCapacity:1000];// auto released
    for (AppEntity *appEntity in fetchedObjects) {
        NSLog(@"----------------------------------------");
        NSLog(@"name: %@", appEntity.name);
        NSLog(@"category: %@", appEntity.category);
        NSLog(@"artist: %@", appEntity.artist);
        NSLog(@"----------------------------------------\n");
        
        AppObject * appObject = [AppObject new];
        appObject.name = appEntity.name;
        appObject.imgURLString  = appEntity.imgURLString;
        appObject.imgDetailURLString = appEntity.imgDetailURLString;
        appObject.summary = appEntity.summary;
        appObject.title = appEntity.title;
        appObject.linkURLString = appEntity.linkURLString;
        appObject.idString = appEntity.idString;
        appObject.artist = appEntity.artist;
        appObject.category = appEntity.category;
        appObject.dateLabel = appEntity.dateLabel;
        appObject.price = [appEntity.price floatValue];
        [appsArr addObject:appObject];
        
        [appObject release];
    }
    [fetchRequest release];
    
    return [appsArr autorelease];
}



@end

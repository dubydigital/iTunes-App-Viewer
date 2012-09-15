//
//  AppViewerModel.m
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//
//

#import "AppViewerModel.h"

@implementation AppViewerModel
@synthesize appsArray =_appsArray;
@synthesize currentAppInPlay =_currentAppInPlay;
static AppViewerModel * _sharedInstance = nil;



- (id)init
{
    if (self = [super init]) 
    {
        
    }
    return self;
}

-(NSArray *)getAppsArr{

    NSMutableArray * returnValueArray= [[NSMutableArray alloc] initWithCapacity:50];
    NSDictionary *feedDictionary =  [[WebServiceUtil getiTunesAppsService:SERVER_URI] objectForKey:@"feed"];
    
    if ([NSNull null] !=  [feedDictionary objectForKey:@"entry"]){
        NSArray * tempArr = (NSArray*)[feedDictionary objectForKey:@"entry"];
        
        NSLog(@"[tempArr count]:%d",[tempArr count] );
        for (int i =0; i< [tempArr count]; i++) {

            // PARSE JSON ATTRIBUTES
            AppObject *appObject = [AppObject new];
            NSDictionary* tempAppDictionary =  [tempArr objectAtIndex:i];
            NSArray *imagesArr = [tempAppDictionary objectForKey:@"im:image"];
            NSDictionary *imgDictionary = (NSDictionary*)[imagesArr objectAtIndex:0];//53x53
            NSDictionary *imgDetailDictionary = (NSDictionary*)[imagesArr objectAtIndex:2];// 100x100
            
            NSArray *linkArr = [tempAppDictionary objectForKey:@"link"];
            NSDictionary *linkDictionary = (NSDictionary*)[linkArr objectAtIndex:0];
            
            // NAME
            appObject.name = [[tempAppDictionary objectForKey:@"im:name"] objectForKey:@"label"];
            // THUMB IMAGE
            appObject.imgURLString = [imgDictionary objectForKey:@"label"];
            // THUMB DETAIL IMAGE
            appObject.imgDetailURLString = [imgDetailDictionary objectForKey:@"label"];
            // SUMMARY
            appObject.summary = [[tempAppDictionary objectForKey:@"summary"] objectForKey:@"label"];
            // TITLE
            appObject.title = [[tempAppDictionary objectForKey:@"title"] objectForKey:@"label"];
            // LINK URL
            appObject.linkURLString = [[linkDictionary objectForKey:@"attributes"] objectForKey:@"href"];
            // ID
            appObject.idString = [[[tempAppDictionary objectForKey:@"id"] objectForKey:@"attributes"] objectForKey:@"im:id"];
            // ARTIST
            appObject.artist =[[tempAppDictionary objectForKey:@"im:artist"] objectForKey:@"label"];
            // CATEGORY
            appObject.category =[[[tempAppDictionary objectForKey:@"category"] objectForKey:@"attributes"] objectForKey:@"label"];
            // RELEASE DATE
            appObject.dateLabel =[[[tempAppDictionary objectForKey:@"im:releaseDate"] objectForKey:@"attributes"] objectForKey:@"label"];
            
            // ADD OBJECT
            [returnValueArray addObject:appObject];
            
            // RELEASE
            [appObject release];
        }
    }
    
    /*
    NSLog(@"[self.appsArray count]:%d",[self.appsArray count] );
    for (int k =0; k < [self.appsArray count]; k++) {
        NSLog(@"--------------------------------\n\n");
        NSLog(@"%d.) app name: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] name]);
        //NSLog(@"%d.) app imgURLString: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] imgURLString]);
        //NSLog(@"%d.) app summary: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] summary]);
        NSLog(@"%d.) app title: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] title]);
        NSLog(@"%d.) app link: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] linkURLString]);
        NSLog(@"%d.) app id: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] idString]);
        NSLog(@"%d.) app artist: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] artist]);
        NSLog(@"%d.) app category: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] category]);
        NSLog(@"%d.) app relaseDate: %@",k, [(AppObject*)[self.appsArray objectAtIndex:k] dateLabel]);
    }
     */
    
    return [returnValueArray autorelease];
}

//---------------------------------------
#pragma mark - Singleton Methods
//---------------------------------------
+(AppViewerModel *) sharedInstance{
    @synchronized([AppViewerModel class])
	{
		if (!_sharedInstance)
            _sharedInstance = [[self alloc] init];
        
		return _sharedInstance;
	}
    return nil;
}

/*
 +(AppViewerModel *)sharedInstance{
 static AppViewerModel *_instance = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 _instance = [AppViewerModel new];
 });
 return _instance;
 }
 */


@end

//
//  WebServiceUtil.m
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//
//

#import "WebServiceUtil.h"
#import "SBjson.h"

@implementation WebServiceUtil

+ (NSDictionary *)getiTunesAppsService:(NSString *)server_uri{
    NSDictionary *returnDictionary = nil;
    
    NSString *urlAsString = server_uri;
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    //--------------------
    // SYNCHRONOUS
    //--------------------
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = nil;
    
    data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];    
    
    if ([data length] > 0  && error == nil){

        //--------------------------
        // USE NSJSONSerialization
        //--------------------------
        NSError *jerror = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jerror];
        if (jerror) {
            NSLog(@"Error!!! PARSING WITH NSJSONSerialization");
        }
        
        //--------------------------
        // USE SBJSON if NSJSONSerialization is not available
        //--------------------------
        if (jsonObject == nil) {
            NSLog(@"JSON IS NIL, SBJson to Parse Data");
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            NSError *parsingErr = nil;
            NSString *resultsVal = [[NSString alloc] initWithData:data
                                                         encoding:NSUTF8StringEncoding];
            jsonObject = [jsonParser objectWithString:resultsVal error:&parsingErr];
            
            if (parsingErr) {
                NSLog(@":::   ERROR!!!    parsingErr: %@ ", error.description);
            }
            
            [jsonParser release];
        }
        
        if([jsonObject isKindOfClass:[NSDictionary class]]){
            returnDictionary = jsonObject;
            NSLog(@"jsonObject: is DICTIONARY TYPE");
            //NSLog(@"jsonObject: is DICTIONARY TYPE: %@", jsonObject);
        }else if([jsonObject isKindOfClass:[NSArray class]]) {
             NSLog(@"jsonObject: ARRAY TYPE");
             //NSLog(@"ARRAY TYPE: %@",jsonObject);
        }
    }
    else if ([data length] == 0 && error == nil){
        NSLog(@"Error!!! Nothing was downloaded.");
    }
    else if (error != nil){
        NSLog(@"Error!!! happened = %@", error);
    }
    
    return returnDictionary ;
}

@end

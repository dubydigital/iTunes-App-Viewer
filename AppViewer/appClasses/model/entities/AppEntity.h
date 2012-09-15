//
//  AppEntity.h
//  AppViewer
//
//  Created by Mark Dubouzet on 9/10/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AppEntity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imgURLString;
@property (nonatomic, retain) NSString * imgDetailURLString;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * linkURLString;
@property (nonatomic, retain) NSString * idString;
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * dateLabel;
@property (nonatomic, retain) NSNumber * price;

@end

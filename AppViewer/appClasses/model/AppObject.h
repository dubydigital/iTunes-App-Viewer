//
//  AppObject.h
//  AppViewer
//
//  Created by mark dubouzet on 9/9/12.
//
//

#import <Foundation/Foundation.h>

@interface AppObject : NSObject{
    NSString * name;
    NSString * imgURLString;
    NSString * imgDetailURLString;
    NSString * summary;
    NSString * title;
    NSString * linkURLString;
    NSString * idString;
    NSString * artist;
    NSString * category;
    NSString * dateLabel;
    float price;
    
    UIImage * thumbImage;
}

@property(nonatomic,retain)UIImage * thumbImage;
@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * imgURLString;
@property(nonatomic,retain)NSString * imgDetailURLString;
@property(nonatomic,retain)NSString * summary;
@property(nonatomic,retain)NSString * title;
@property(nonatomic,retain)NSString * linkURLString;
@property(nonatomic,retain)NSString * idString;
@property(nonatomic,retain)NSString * artist;
@property(nonatomic,retain)NSString * category;
@property(nonatomic,retain)NSString * dateLabel;
@property float price;

@end

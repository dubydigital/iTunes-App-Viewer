

#import "AppObject.h"

@protocol IconDownloaderDelegate;

@interface IconDownloader : NSObject
{
    AppObject *appObject;
    NSIndexPath *indexPath;
    id <IconDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
}

@property (nonatomic, retain) AppObject *appObject;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, assign) id <IconDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol IconDownloaderDelegate

- (void)appImageDidLoad:(NSIndexPath *)indexPath;

@end
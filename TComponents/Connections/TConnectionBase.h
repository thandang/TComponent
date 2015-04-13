//
//  TConnectionBase.h
//  TComponents
//
//  Created by Dang Thanh Than on 4/13/15.
//  Copyright (c) 2015 Than Dang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^AOProgressBlock)(float progress);
typedef void (^AOCompleteBlock)(id data, BOOL success);
typedef void (^AOHTTPCompleteBlock)(id data, BOOL success, NSInteger errorCode, BOOL isUpdate, NSString *version, NSString *message);

@interface TConnectionBase : NSOperation<NSURLSessionDelegate, NSURLSessionDownloadDelegate, NSURLSessionTaskDelegate> {
    NSURLSession                *_session;
    NSURLSessionDownloadTask    *_downloadTask;
    NSURLSessionDataTask        *_dataTask;
    NSURLRequest                *_request;
    REQUEST_TYPE                _requestType;
}

@property (strong) AOProgressBlock  progressAction;
@property (strong) AOCompleteBlock  completeAction;
@property (strong) AOHTTPCompleteBlock  httpCompleteAction;
@property (nonatomic, strong) NSData    *requestPostData;

- (void) connect:(NSURLRequest *) request requestType:(REQUEST_TYPE) requestType_;
- (void) download:(NSURLRequest *)request storeLocal:(NSString *) localFolder;
- (void) enqueueOperation;
- (void) cancelData;
- (void) cancelDowload;

@end

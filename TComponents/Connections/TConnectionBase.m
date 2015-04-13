//
//  TConnectionBase.m
//  TComponents
//
//  Created by Dang Thanh Than on 4/13/15.
//  Copyright (c) 2015 Than Dang. All rights reserved.
//

#import "TConnectionBase.h"

@interface TConnectionBase ()

- (NSURLSession *) backgroundSession;
- (NSURLSession *) foregroundSession;
@end

@implementation TConnectionBase



#pragma mark - NSOpertaion
- (void) start {
    if (!self.isCancelled) {
        if (_requestType == DOWNLOAD) {
            if (_downloadTask) return;
            if (!_session) _session = [self backgroundSession];
            _downloadTask = [_session downloadTaskWithRequest:_request];
            [_downloadTask resume];
        } else {
            if (!_session) {
                _session = [self foregroundSession];
            }
            
            //for GET
            if (_requestType == HTTPREQUEST_GET) {
                _dataTask = [_session dataTaskWithRequest:_request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                    if (self.httpCompleteAction) {
                        BOOL success = NO;
                        NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)response;
                        NSDictionary *allHeaderField = [realResponse allHeaderFields];
                        BOOL isUpdate = NO;
//                        NSString *version = [AOUtils currentVersionNumber];
//                        NSString *message = NSLocalizedString(@"update_available", nil);
//                        if (allHeaderField) {
//                            if (![[allHeaderField objectForKey:kX_App_Upgrade] isKindOfClass:[NSNull class]]) {
//                                isUpdate = [[allHeaderField objectForKey:kX_App_Upgrade] boolValue];
//                            }
//                            if (![[allHeaderField objectForKey:kX_App_Version] isKindOfClass:[NSNull class]]) {
//                                version = [allHeaderField objectForKey:kX_App_Version];
//                            }
//                            if ([allHeaderField objectForKey:kX_App_Message] && ![[allHeaderField objectForKey:kX_App_Message] isKindOfClass:[NSNull class]]) {
//                                message = [allHeaderField objectForKey:kX_App_Message];
//                            }
//                        }
                        NSInteger errorCode = [realResponse statusCode];
                        if (!error) {
                            if (errorCode == 200) {
                                success = YES;
//                                self.httpCompleteAction(data, success, errorCode, isUpdate, version, message);
                            } else if (errorCode == 401) {
                                success = NO;
//                                NSString *forceBackToLogin = kForceBackLogin;
//                                self.httpCompleteAction(forceBackToLogin, success, errorCode, isUpdate, version, message);
                            } else {
//                                self.httpCompleteAction(data, success, errorCode, isUpdate, version, message);
                            }
                        } else {
//                            self.httpCompleteAction(error, success, errorCode, isUpdate, version, message);
                        }
                    }
                }];
            } else if(_requestType == HTTPREQUEST_POST) { //for POST
                _dataTask = [_session uploadTaskWithRequest:_request fromData:self.requestPostData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (self.httpCompleteAction) {
                        BOOL success = NO;
                        NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)response;
                        NSDictionary *allHeaderField = [realResponse allHeaderFields];
                        BOOL isUpdate = NO;
//                        NSString *version = [AOUtils currentVersionNumber];
//                        NSString *message = NSLocalizedString(@"update_available", nil);
//                        if (allHeaderField) {
//                            if (![[allHeaderField objectForKey:kX_App_Upgrade] isKindOfClass:[NSNull class]]) {
//                                isUpdate = [[allHeaderField objectForKey:kX_App_Upgrade] boolValue];
//                            }
//                            if (![[allHeaderField objectForKey:kX_App_Version] isKindOfClass:[NSNull class]]) {
//                                version = [allHeaderField objectForKey:kX_App_Version];
//                            }
//                            if ([allHeaderField objectForKey:kX_App_Message] && ![[allHeaderField objectForKey:kX_App_Message] isKindOfClass:[NSNull class]]) {
//                                message = [allHeaderField objectForKey:kX_App_Message];
//                            }
//                        }
                        NSInteger errorCode = [realResponse statusCode];
                        if (!error) {
                            if (errorCode == 200) {
                                success = YES;
//                                self.httpCompleteAction(data, success, errorCode, isUpdate, version, message);
                            } else if ([(NSHTTPURLResponse*)response statusCode] == 401) {
                                success = NO;
//                                NSString *forceBackToLogin = kForceBackLogin;
//                                self.httpCompleteAction(forceBackToLogin, success, errorCode, isUpdate, version, message);
                            } else {
//                                self.httpCompleteAction(data, success, errorCode, isUpdate, version, message);
                            }
                        } else {
//                            self.httpCompleteAction(error, success, errorCode, isUpdate, version, message);
                        }
                    }
                }];
            } else { //PUT
                _dataTask = [_session uploadTaskWithRequest:_request fromData:self.requestPostData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    if (self.httpCompleteAction) {
                        BOOL success = NO;
                        NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)response;
                        NSDictionary *allHeaderField = [realResponse allHeaderFields];
                        BOOL isUpdate = NO;
//                        NSString *version = [AOUtils currentVersionNumber];
//                        NSString *message = NSLocalizedString(@"update_available", nil);
//                        if (allHeaderField) {
//                            if (![[allHeaderField objectForKey:kX_App_Upgrade] isKindOfClass:[NSNull class]]) {
//                                isUpdate = [[allHeaderField objectForKey:kX_App_Upgrade] boolValue];
//                            }
//                            if (![[allHeaderField objectForKey:kX_App_Version] isKindOfClass:[NSNull class]]) {
//                                version = [allHeaderField objectForKey:kX_App_Version];
//                            }
//                            if ([allHeaderField objectForKey:kX_App_Message] && ![[allHeaderField objectForKey:kX_App_Message] isKindOfClass:[NSNull class]]) {
//                                message = [allHeaderField objectForKey:kX_App_Message];
//                            }
//                        }
                        NSInteger errorCode = [realResponse statusCode];
                        if (!error) {
                            if (errorCode == 200) {
                                success = YES;
//                                self.httpCompleteAction(data, success, errorCode, isUpdate, version, message);
                            } else if ([(NSHTTPURLResponse*)response statusCode] == 401) {
                                success = NO;
//                                NSString *forceBackToLogin = kForceBackLogin;
//                                self.httpCompleteAction(forceBackToLogin, success, errorCode, isUpdate, version, message);
                            } else {
//                                self.httpCompleteAction(data, success, errorCode, isUpdate, version, message);
                            }
                        } else {
//                            self.httpCompleteAction(error, success, errorCode, isUpdate, version, message);
                        }
                    }
                }];
            }
            
            [_dataTask resume];
        }
    }
}


- (void) cancelData {
    if (_dataTask) {
        if ([_dataTask state] == NSURLSessionTaskStateRunning) {
            [_dataTask cancel];
        }
        _dataTask = nil;
    }
}

- (void) cancelDowload {
    if (_downloadTask) {
        if ([_downloadTask state] == NSURLSessionTaskStateRunning) {
            [_downloadTask cancel];
        }
        _downloadTask = nil;
    }
}



#pragma mark - NSURLSessionDownloadTask Delegate
/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:POSPHOTO_FOLDER isDirectory:nil]) {
        [fileManager createDirectoryAtPath:POSPHOTO_FOLDER withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = [urls objectAtIndex:0];
    
    NSURL *originalUrl = [[downloadTask originalRequest] URL];
    NSString *strUrl = [originalUrl absoluteString];
    NSArray *arrLast = [strUrl componentsSeparatedByString:@"/"];
    NSString *tmpFileName = [arrLast lastObject];
    NSArray *arrUrl = [tmpFileName componentsSeparatedByString:@"?"];
    NSMutableString *finalStr = [[NSMutableString alloc] init];
    if ([arrUrl count] > 1) {
        [finalStr appendFormat:@"%@", [arrUrl lastObject]];
    }
    
    NSArray *arrContentAndType = [[originalUrl lastPathComponent] componentsSeparatedByString:@"."];
    if ([arrContentAndType count] > 1) {
        [finalStr appendFormat:@".%@", [arrContentAndType lastObject]];
    } else {
        [finalStr appendFormat:@"%@", [arrContentAndType firstObject]];
    }
    
    
    NSURL *destinationUrl = [documentsDirectory URLByAppendingPathComponent:[NSString stringWithFormat:@"PosPhotos/%@", finalStr]];
    NSError *error;
    
    [fileManager removeItemAtURL:destinationUrl error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationUrl error:&error];
    if (self.completeAction) { //handle delegate instead of block
        if (error) {
            self.completeAction(error, success);
        } else {
            self.completeAction(destinationUrl, success);
        }
        
    }
}

/* Sent periodically to notify the delegate of download progress. */
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if (totalBytesWritten == NSURLSessionTransferSizeUnknown) {
        DEBUG_LOG(@"unknow session");
    } else {
        if (downloadTask.taskIdentifier == _downloadTask.taskIdentifier && self.progressAction) { //handle delegate instead of block
            float progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
            DEBUG_LOG(@"written: %f - total: %f", (double)bytesWritten, (double)totalBytesWritten);
            self.progressAction(progress);
        }
    }
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    //handle for resume here
    DEBUG_LOG(@"resum download");
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"### handler 2");
    
}

#pragma mark - NSURLSessionTaskDelegate
- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    _downloadTask = nil;
    if (error) {
        if (self.completeAction) {
            self.completeAction(error, NO);
        }
        if (self.httpCompleteAction) {
            NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaderField = [realResponse allHeaderFields];
            BOOL isUpdate = NO;
            NSString *version = [AOUtils currentVersionNumber];
            NSString *message = NSLocalizedString(@"update_available", nil);
            if (allHeaderField) {
                if (![[allHeaderField objectForKey:kX_App_Upgrade] isKindOfClass:[NSNull class]]) {
                    isUpdate = [[allHeaderField objectForKey:kX_App_Upgrade] boolValue];
                }
                if (![[allHeaderField objectForKey:kX_App_Version] isKindOfClass:[NSNull class]]) {
                    version = [allHeaderField objectForKey:kX_App_Version];
                }
                if ([allHeaderField objectForKey:kX_App_Message] && ![[allHeaderField objectForKey:kX_App_Message] isKindOfClass:[NSNull class]]) {
                    message = [allHeaderField objectForKey:kX_App_Message];
                }
            }
            self.httpCompleteAction(error, NO, error.code, isUpdate, version, message);
        }
        [AOUtils hideWaitingView];
    }
    _dataTask = nil;
}

#pragma mark - NSURLSessionDelegate
- (void) URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    [_session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        if ([downloadTasks count] == 0) {
            if ([kAppDelegate backgroundSessionCompletionHandler]) {
                void (^completionHandler)() = [kAppDelegate backgroundSessionCompletionHandler];
                [kAppDelegate setBackgroundSessionCompletionHandler:nil];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    completionHandler();
                    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
                    localNotification.fireDate = [NSDate date];
                    localNotification.timeZone = [NSTimeZone defaultTimeZone];
                    localNotification.repeatInterval = 0;
                    localNotification.alertBody = NSLocalizedString(@"file_downloaded", nil);
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
                }];
            }
        }
        
    }];
    
}

//For API GET/POST
#pragma mark - NSURLSessionDataTask
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler 1");
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    if (self.httpCompleteAction) {
        NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)dataTask.response;
        NSDictionary *allHeaderField = [realResponse allHeaderFields];
        BOOL isUpdate = NO;
        NSString *version = [AOUtils currentVersionNumber];
        NSString *message = NSLocalizedString(@"update_available", nil);
        if (allHeaderField) {
            if (![[allHeaderField objectForKey:kX_App_Upgrade] isKindOfClass:[NSNull class]]) {
                isUpdate = [[allHeaderField objectForKey:kX_App_Upgrade] boolValue];
            }
            if (![[allHeaderField objectForKey:kX_App_Version] isKindOfClass:[NSNull class]]) {
                version = [allHeaderField objectForKey:kX_App_Version];
            }
            if ([allHeaderField objectForKey:kX_App_Message] && ![[allHeaderField objectForKey:kX_App_Message] isKindOfClass:[NSNull class]]) {
                message = [allHeaderField objectForKey:kX_App_Message];
            }
        }
        self.httpCompleteAction(data, YES, 200, isUpdate, version, message);
    }
}





#pragma mark - Private method
- (NSOperationQueue *)operationQueue {
    static NSOperationQueue *operationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationQueue = [NSOperationQueue new];
        [operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    });
    return operationQueue;
}

- (void) enqueueOperation {
    [[self operationQueue] addOperation:self];
}

- (NSURLSession *) backgroundSession {
    static NSURLSession *session_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = nil;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"AO.backgroundSession"];
        } else {
            configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:@"AO.backgroundSession"];
        }
        [configuration setNetworkServiceType:NSURLNetworkServiceTypeBackground];
        [configuration setAllowsCellularAccess:YES];
        //        [configuration setTimeoutIntervalForRequest:kTIME_OUT_REQUEST_DOWNLOAD];
        //        [configuration setTimeoutIntervalForResource:kMinimumBackgroundTimeRemaining_download];
        [configuration setHTTPMaximumConnectionsPerHost:5];
        session_ = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        
    });
    return session_;
}

- (NSURLSession *) foregroundSession {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        [configuration setAllowsCellularAccess:YES];
//        [configuration setTimeoutIntervalForRequest:kTIME_OUT_REQUEST];
//        [configuration setTimeoutIntervalForResource:kMinimumBackgroundTimeRemaining];
        [configuration setHTTPMaximumConnectionsPerHost:1];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    });
    return session;
}

@end

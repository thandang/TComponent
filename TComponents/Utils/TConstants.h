//
//  TConstants.h
//  TComponents
//
//  Created by Dang Thanh Than on 4/13/15.
//  Copyright (c) 2015 Than Dang. All rights reserved.
//


/************** Enum **************/
typedef enum {
    HTTPREQUEST_GET = 0,
    HTTPREQUEST_POST = 1,
    DOWNLOAD,
    HTTPREQUEST_PUT
} REQUEST_TYPE;


/************** Key **************/
#define POSPHOTO_FOLDER [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"PosPhotos"]

/************** URL **************/


/************** iOS Platform **************/
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define ISCONNECTINGNETWORK	(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable)||([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus]!=NotReachable))

/************** Colours ****************/
#define kCOLOR_CELL_EVEN [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]
#define kCOLOR_CELL_ODD    [UIColor whiteColor]
#define kCOLOR_HEADER   [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1]


#define kCOLOR_CANCELED     [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1]
#define kCOLOR_COMPLETED    [UIColor colorWithRed:68/255.0 green:157/255.0 blue:68/255.0 alpha:1]
#define kCOLOR_CONFIRMED    [UIColor colorWithRed:49/255.0 green:112/255.0 blue:143/255.0 alpha:1]

#define kCOLOR_SHADOW    [UIColor colorWithRed:86/255.0 green:119/255.0 blue:252/255.0 alpha:1]

#define kCOLOR_BUTTON_DETAIL    [UIColor colorWithRed:173/255.0 green:224/255.0 blue:65/255.0 alpha:1]
#define kCOLOR_BUTTON_DETAIL_SELECTED    [UIColor colorWithRed:99/255.0 green:184/255.0 blue:148/255.0 alpha:1]


#define kCOLOR_BACKGROUND   [UIColor colorWithRed:85/255.0 green:124/255.0 blue:219/255.0 alpha:1]
#define kCOLOR_BACKGROUND_FAIER   [UIColor colorWithRed:85/255.0 green:124/255.0 blue:219/255.0 alpha:0.3]

#define kCOLOR_AP_LIGHTGREY_5   [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]

#define kCOLOR_AP_TEXT   [UIColor colorWithRed:62/255.0 green:62/255.0 blue:62/255.0 alpha:1]
#define kCOLOR_AP_DARK_20   [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1]
#define kCOLOR_AP_DARK_40   [UIColor colorWithRed:175/255.0 green:175/255.0 blue:175/255.0 alpha:1]

#define kCOLOR_TINT_PROGRESS_BAR   [UIColor colorWithRed:25/255.0 green:148/255.0 blue:251/255.0 alpha:1]

#define kCOLOR_DOT_NORMAL   [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]//[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]
#define kCOLOR_DOT_BORDER   [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1]
#define kCOLOR_DOT_PRESSED   [UIColor lightGrayColor]
#define kCOLOR_CLEAR    [UIColor    clearColor]
#define kColorCellOdd [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0]
#define kColorCellEven  [UIColor whiteColor]
#define kColorHeaderCol [UIColor colorWithRed:222/255.0 green:233/255.0 blue:250/255.0 alpha:1]

/*************** Math ***************/
#define d2r (M_PI / 180.0)


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define kDisableLog         false
#ifdef DEBUG
#define DEBUG_LOG(fmt, ...) if(!kDisableLog) NSLog((@"%s [Line %d]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DEBUG_LOG
#endif


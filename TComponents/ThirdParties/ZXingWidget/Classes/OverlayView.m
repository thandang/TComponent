// -*- Mode: ObjC; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-

/**
 * Copyright 2009 Jeff Verkoeyen
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "OverlayView.h"

static const CGFloat kPadding = 40.0;
static const CGFloat kLicenseButtonPadding = 10;

@interface OverlayView()
@property (nonatomic,assign) UIButton *cancelButton;
@property (nonatomic,assign) UIButton *licenseButton;
@property (nonatomic,retain) UILabel *instructionsLabel;
@property (nonatomic, retain) UILabel   *lblDes;
@end


@implementation OverlayView

@synthesize delegate, oneDMode;
@synthesize points = _points;
@synthesize cancelButton;
@synthesize licenseButton;
@synthesize cropRect;
@synthesize instructionsLabel;
@synthesize displayedMessage;
@synthesize cancelButtonTitle;
@synthesize cancelEnabled;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled {
  return [self initWithFrame:theFrame cancelEnabled:isCancelEnabled oneDMode:isOneDModeEnabled showLicense:YES];
}

- (id) initWithFrame:(CGRect)theFrame cancelEnabled:(BOOL)isCancelEnabled oneDMode:(BOOL)isOneDModeEnabled showLicense:(BOOL)showLicenseButton {
  self = [super initWithFrame:theFrame];
  if( self ) {

    CGFloat rectSize = self.frame.size.width - kPadding * 2;
    if (!oneDMode) {
      cropRect = CGRectMake(kPadding, (self.frame.size.height - rectSize) / 2, rectSize, rectSize);
    } else {
      CGFloat rectSize2 = self.frame.size.height - kPadding * 2;
      cropRect = CGRectMake(kPadding, kPadding, rectSize, rectSize2);		
    }

    self.backgroundColor = [UIColor clearColor];
    self.oneDMode = isOneDModeEnabled;

    self.cancelEnabled = isCancelEnabled;

    if (self.cancelEnabled) {
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.backgroundColor = [UIColor lightGrayColor];
        butt.layer.borderWidth = 0.5;
        butt.layer.borderColor = [UIColor grayColor];
        butt.layer.cornerRadius = 4;
        self.cancelButton = butt;
        if ([self.cancelButtonTitle length] > 0 ) {
            [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        } else {
            [cancelButton setTitle:NSLocalizedStringWithDefaultValue(@"OverlayView cancel button title", nil, [NSBundle mainBundle], @"Cancel", @"Cancel") forState:UIControlStateNormal];
        }
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
    }
  }
  return self;
}

- (void)cancel:(id)sender {
	// call delegate to cancel this scanner
	if (delegate != nil) {
		[delegate cancelled];
	}
}

- (void)showLicenseAlert:(id)sender {
    NSString *title =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert title", nil, [NSBundle mainBundle], @"License", @"License");

    NSString *message =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert message", nil, [NSBundle mainBundle], @"Scanning functionality provided by ZXing library, licensed under Apache 2.0 license.", @"Scanning functionality provided by ZXing library, licensed under Apache 2.0 license.");

    NSString *cancelTitle =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert cancel title", nil, [NSBundle mainBundle], @"OK", @"OK");

    NSString *viewTitle =
        NSLocalizedStringWithDefaultValue(@"OverlayView license alert view title", nil, [NSBundle mainBundle], @"View License", @"View License");

    UIAlertView *av =
        [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:viewTitle, nil];

    [av show];
    [self retain]; // For the delegate callback ...
    [av release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == [alertView firstOtherButtonIndex]) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apache.org/licenses/LICENSE-2.0.html"]];
  }
  [self release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	[_points release];
  [instructionsLabel release];
  [displayedMessage release];
  [cancelButtonTitle release],
	[super dealloc];
}


- (void)drawRect:(CGRect)rect inContext:(CGContextRef)context {
    //instead draw 4 line, we will draw 8 line
	CGContextBeginPath(context);
    
    //first line
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width/5, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
    //second line
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height/5);
    
    //third line
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width * 4/5, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    //fourth line
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height/5);
    
    //fifth line
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height * 4 / 5);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    //sixth line
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width * 4/5, rect.origin.y + rect.size.height);
    
    //seventh line
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width/5, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
    //eighth line
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height * 4/5);
    
	CGContextStrokePath(context);
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    center.x = cropRect.size.width/2;
    center.y = cropRect.size.height/2;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 90;
    switch(rotation) {
    case 0:
        point.x = x;
        point.y = y;
        break;
    case 90:
        point.x = -y;
        point.y = x;
        break;
    case 180:
        point.x = -x;
        point.y = -y;
        break;
    case 270:
        point.x = y;
        point.y = -x;
        break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}

#define kTextMargin 10

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
  if (displayedMessage == nil) {
//    self.displayedMessage = NSLocalizedStringWithDefaultValue(@"OverlayView displayed message", nil, [NSBundle mainBundle], @"Place a barcode inside the viewfinder rectangle to scan it.", @"Place a barcode inside the viewfinder rectangle to scan it.");
//      self.displayedMessage = NSLocalizedStringWithDefaultValue(@"OverlayView displayed message", nil, [NSBundle mainBundle], @"scan_text", @"");
  }
    
	CGContextRef c = UIGraphicsGetCurrentContext();
    
    
    [[UIColor clearColor] setFill];
    UIRectFill(rect);
    
    CGRect fullScreen = [UIScreen mainScreen].bounds;
    
    CGRect sampleRect = CGRectMake(0.0, 0.0, fullScreen.size.width, cropRect.origin.y - 3);
    CGRect holdRect = CGRectIntersection(sampleRect, rect);
    [[UIColor whiteColor] setFill];
    UIRectFill(holdRect);
    
    CGRect sampleRect2 = CGRectMake(0.0, cropRect.origin.y - 3, cropRect.origin.x - 3, rect.size.height - cropRect.origin.y);
    UIRectFill(sampleRect2);
    
    CGRect sampleRect3 = CGRectMake(0.0, cropRect.size.height + cropRect.origin.y + 3, rect.size.width - 3, rect.size.height - cropRect.size.height);
    UIRectFill(sampleRect3);
    
    CGRect sampleRect4 = CGRectMake(cropRect.size.width + cropRect.origin.x + 3, cropRect.origin.y - 3, rect.size.width - (cropRect.size.width + cropRect.origin.x), rect.size.height - cropRect.origin.y);
    UIRectFill(sampleRect4);
    
    
    //draw line body
    CGContextBeginPath(c);
    CGFloat redColor[4] = {1.0f, 0.0f, 0.0f, 0.4f};
    CGContextSetStrokeColor(c, redColor);
    CGContextSetLineWidth(c, 8.0f);
    CGContextSetFillColor(c, redColor);
    CGContextMoveToPoint(c, cropRect.origin.x + 25, cropRect.origin.y + cropRect.size.height/2);
    CGContextAddLineToPoint(c, cropRect.origin.x + (cropRect.size.width - 25), cropRect.origin.y + cropRect.size.height/2);
    CGContextStrokePath(c);
    
    
	CGFloat white[4] = {0.0f, 0.0f, 0.0f, 1.0f};
    CGContextSetLineWidth(c, 7.0f);
	CGContextSetStrokeColor(c, white);
	CGContextSetFillColor(c, white);
	[self drawRect:cropRect inContext:c];
	
	CGContextSaveGState(c);

	CGContextRestoreGState(c);
	int offset = rect.size.width / 2;
	if (oneDMode) {
		CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, red);
		CGContextSetFillColor(c, red);
		CGContextBeginPath(c);
		//		CGContextMoveToPoint(c, rect.origin.x + kPadding, rect.origin.y + offset);
		//		CGContextAddLineToPoint(c, rect.origin.x + rect.size.width - kPadding, rect.origin.y + offset);
		CGContextMoveToPoint(c, rect.origin.x + offset, rect.origin.y + kPadding);
		CGContextAddLineToPoint(c, rect.origin.x + offset, rect.origin.y + rect.size.height - kPadding);
		CGContextStrokePath(c);
	}
    
	if( nil != _points ) {
		CGFloat blue[4] = {0.0f, 1.0f, 0.0f, 1.0f};
		CGContextSetStrokeColor(c, blue);
		CGContextSetFillColor(c, blue);
		if (oneDMode) {
			CGPoint val1 = [self map:[[_points objectAtIndex:0] CGPointValue]];
			CGPoint val2 = [self map:[[_points objectAtIndex:1] CGPointValue]];
			CGContextMoveToPoint(c, offset, val1.x);
			CGContextAddLineToPoint(c, offset, val2.x);
			CGContextStrokePath(c);
		}
		else {
			CGRect smallSquare = CGRectMake(0, 0, 10, 10);
			for( NSValue* value in _points ) {
				CGPoint point = [self map:[value CGPointValue]];
				smallSquare.origin = CGPointMake(
                                         cropRect.origin.x + point.x - smallSquare.size.width / 2,
                                         cropRect.origin.y + point.y - smallSquare.size.height / 2);
				[self drawRect:smallSquare inContext:c];
			}
		}
	}
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) setPoints:(NSMutableArray*)pnts {
    [pnts retain];
    [_points release];
    _points = pnts;
	
    if (pnts != nil) {
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    }
    [self setNeedsDisplay];
}

- (void) setPoint:(CGPoint)point {
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    if (_points.count > 3) {
        [_points removeObjectAtIndex:0];
    }
    [_points addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}


- (void)layoutSubviews {
  [super layoutSubviews];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    float logoOrg = 10.0;
    float cancelOrinPlus = 55.0;
    
    if (screenSize.height > 480) {
        cancelOrinPlus = 65.0;
    }

    if (!_lblDes) {
        UILabel *lblText = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 150)/2, (cropRect.origin.y - 50) / 2 + 20, 150.0, 50)];
        lblText.font = [UIFont systemFontOfSize:16.0];
        lblText.textColor = [UIColor blackColor];
        lblText.textAlignment = UITextAlignmentCenter;
        lblText.numberOfLines = 2;
        lblText.text = self.displayedMessage;
        [self addSubview:lblText];
        _lblDes = [lblText retain];
        [lblText release];
    }
    
    
  if (cancelButton) {
    if (oneDMode) {
      [cancelButton setTransform:CGAffineTransformMakeRotation(M_PI/2)];
        [cancelButton setFrame:CGRectMake(20, 195, 45, 130)];
    } else {
      CGSize theSize = CGSizeMake(100, 50);
      CGRect rect = self.frame;
      CGRect theRect = CGRectMake((rect.size.width - theSize.width) / 2, cropRect.origin.y + cropRect.size.height + cancelOrinPlus, theSize.width, theSize.height);
      [cancelButton setFrame:theRect];
    }
      [self bringSubviewToFront:cancelButton];
  }
    
}

@end

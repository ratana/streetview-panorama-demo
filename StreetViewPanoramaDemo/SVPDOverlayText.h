//
//  SVPDOverlayText.h
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVPDOverlayItem.h"

@interface SVPDOverlayText : NSObject <SVPDOverlayItem>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property float bearing;
@property float pitch;

- (id) initWithText: (NSString*) text color:(UIColor *)color font:(UIFont *) font bearing:(float)bearing pitch:(float)pitch;

@end

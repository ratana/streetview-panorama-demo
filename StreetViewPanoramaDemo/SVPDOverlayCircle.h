//
//  SVPDOverlayCircle.h
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVPDOverlayItem.h"

@interface SVPDOverlayCircle : NSObject <SVPDOverlayItem>

@property (nonatomic, strong) UIColor *color;
@property float bearing;
@property float pitch;
@property float radius; // as a percent of min(width, height)

- (id) initWithColor:(UIColor *)color bearing:(float)bearing pitch:(float)pitch radius:(float) radius;

@end

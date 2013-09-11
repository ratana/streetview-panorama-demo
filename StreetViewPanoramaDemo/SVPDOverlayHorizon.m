//
//  SVPDOverlayHorizon.m
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import "SVPDOverlayHorizon.h"

#define kHorizonSegments 8
#define kHorizonLineWidth 4.0

@implementation SVPDOverlayHorizon {
    UIBezierPath *bezierPath_;
    UIColor *horizonColor_;
    BOOL horizonVisible_;
}

- (id) init {
    self = [super init];
    if (self) {
        bezierPath_ = [UIBezierPath bezierPath];
        bezierPath_.lineWidth = kHorizonLineWidth;
        horizonColor_ = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.65];
        horizonVisible_ = NO;
    }
    return self;
}

- (void) updateWithPanoramaView: (GMSPanoramaView *) panoramaView {
    [bezierPath_ removeAllPoints];
    
    // build a path based what points are visible
    BOOL contiguousPath = NO;
    BOOL firstPointVisible = NO;
    horizonVisible_ = NO;
    CGPoint firstPoint;
    for (int i = 0; i < kHorizonSegments; i++) {
        float bearing = 360/kHorizonSegments * i;
        GMSOrientation orientation = {bearing, 0};
        CGPoint screenLocation = [panoramaView pointForOrientation:orientation];
        if (!isnan(screenLocation.x) && !isnan(screenLocation.y)) {
            if (contiguousPath) {
                [bezierPath_ addLineToPoint:screenLocation];
            } else {
                [bezierPath_ moveToPoint:screenLocation];
            }
            
            // edge case: make sure to connect the first and last points of the horizon if both are visible
            if (i == 0) {
                firstPointVisible = YES;
                firstPoint = screenLocation;
            }
            if (i == (kHorizonSegments-1) && firstPointVisible) {
                [bezierPath_ addLineToPoint:firstPoint];
            }
            contiguousPath = YES;
            horizonVisible_ = YES;
        } else {
            contiguousPath = NO;
        }
    }
}

- (void) draw: (CGContextRef) context inRect:(CGRect)rect {
    if (horizonVisible_) {
        CGContextSetStrokeColorWithColor(context, horizonColor_.CGColor);
        [bezierPath_ stroke];
    }
}

@end
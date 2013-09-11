//
//  SVPDPanoramaOverlayView.m
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import "SVPDPanoramaOverlayView.h"
#import "SVPDOverlayItem.h"
#import "SVPDOverlayText.h"
#import "SVPDOverlayHorizon.h"
#import "SVPDOverlayPath.h"
#import "SVPDOverlayCircle.h"

@implementation SVPDPanoramaOverlayView {
    NSMutableArray *overlayItems_;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize {
    // add a sun path, horizon line, and direction markings to a list of items to draw
    overlayItems_ = [NSMutableArray array];
    
    // sun path
    [overlayItems_ addObject:[[SVPDOverlayPath alloc] init]];
    
    // horizon
    [overlayItems_ addObject:[[SVPDOverlayHorizon alloc] init]];
    
    // directions
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:NSLocalizedString(@"direction_north", nil) color:[UIColor redColor] font:[UIFont boldSystemFontOfSize:36] bearing:0 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:NSLocalizedString(@"direction_south", nil) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24] bearing:180 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:NSLocalizedString(@"direction_west", nil) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24] bearing:270 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:NSLocalizedString(@"direction_east", nil) color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:24] bearing:90 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:@"45\u00b0" color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:16] bearing:45 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:@"135\u00b0" color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:16] bearing:135 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:@"225\u00b0" color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:16] bearing:215 pitch:0]];
    [overlayItems_ addObject:[[SVPDOverlayText alloc] initWithText:@"315\u00b0" color:[UIColor whiteColor] font:[UIFont boldSystemFontOfSize:16] bearing:315 pitch:0]];
    
    // hours
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:116.5 pitch:2.8 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:108.9 pitch:14.3 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:101.7 pitch:26.3 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:98.4 pitch:38.6 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:86.1 pitch:51 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:74.4 pitch:63.3 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:51.2 pitch:74.5 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:350.8 pitch:79.4 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:301 pitch:71.9 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:282.2 pitch:60.3 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:271.7 pitch:48 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:263.7 pitch:35.5 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:256.6 pitch:23.3 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:249.3 pitch:11.4 radius: 0.02]];
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor yellowColor] bearing:241.4 pitch:0.1 radius: 0.02]];
    
    // sun
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor colorWithRed:1 green:0.8 blue:0 alpha:1] bearing:280.5 pitch:58.7 radius:0.07]];
    
    // sunrise
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor colorWithRed:1 green:0.6 blue:0 alpha:1] bearing:119.2 pitch:-0.8 radius: 0.03]];
    
    // sunset
    [overlayItems_ addObject:[[SVPDOverlayCircle alloc] initWithColor:[UIColor redColor] bearing:240.7 pitch:-0.8 radius:0.03]];
}

- (void) updateWithPanoramaView: (GMSPanoramaView*) panoramaView {
    for (id<SVPDOverlayItem> item in overlayItems_) {
        [item updateWithPanoramaView:panoramaView];
    }
}

- (void)drawRect: (CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (id<SVPDOverlayItem> item in overlayItems_) {
        [item draw:context inRect:rect];
    }
}
@end
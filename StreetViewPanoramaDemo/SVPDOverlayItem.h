//
//  SVPDOverlayItem.h
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GMSPanoramaView.h>

@protocol SVPDOverlayItem <NSObject>

- (void) updateWithPanoramaView: (GMSPanoramaView*) panoramaView;
- (void) draw: (CGContextRef) context inRect:(CGRect)rect;

@end

//
//  SVPDOverlayText.m
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import "SVPDOverlayText.h"
#import <GoogleMaps/GMSOrientation.h>
#import <GoogleMaps/GMSPanoramaView.h>

@implementation SVPDOverlayText {
    CGPoint screenLocation_;
}

- (id) initWithText: (NSString*) text color:(UIColor *)color font:(UIFont *) font bearing:(float)bearing pitch:(float)pitch {
    self = [super init];
    if (self) {
        self.text = text;
        self.bearing = bearing;
        self.pitch = pitch;
        self.color = color;
        self.font = font;
    }
    return self;
}

- (void) updateWithPanoramaView: (GMSPanoramaView *) panoramaView {
    // map to a screen location given the orientation and the current PanoramaView
    GMSOrientation orientation = {self.bearing, self.pitch};
    screenLocation_ = [panoramaView pointForOrientation:orientation];
}

- (void) draw: (CGContextRef) context inRect:(CGRect)rect {
    // screenLocation will be NAN per the pointForCoordinate: contract if not visible via the camera
    // NOTE: can also optimize by choosing not to draw items within the rect, as pointForOrientation: will return points outside of the screen bounds
    if (!isnan(screenLocation_.x) && !isnan(screenLocation_.y)) {
        CGContextSetFillColorWithColor(context, self.color.CGColor);
        
        // draw text centered horizontally and vertically around the point
        CGSize stringSize = [self.text sizeWithFont:self.font];
        [self.text drawAtPoint:CGPointMake(screenLocation_.x-stringSize.width/2, screenLocation_.y-stringSize.height/2) withFont: self.font];
    }
}

@end

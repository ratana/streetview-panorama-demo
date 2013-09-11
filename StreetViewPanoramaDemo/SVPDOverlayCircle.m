//
//  SVPDOverlayCircle.m
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import "SVPDOverlayCircle.h"

@implementation SVPDOverlayCircle {
    CGPoint screenLocation_;
}

- (id) initWithColor:(UIColor *)color bearing:(float)bearing pitch:(float)pitch radius:(float) radius {
    self = [super init];
    if (self) {
        self.bearing = bearing;
        self.pitch = pitch;
        self.color = color;
        self.radius = radius;
    }
    return self;
}

- (void) updateWithPanoramaView: (GMSPanoramaView *) panoramaView {
    // map to a screen location given the orientation and the current PanoramaView
    GMSOrientation orientation = {self.bearing, self.pitch};
    screenLocation_ = [panoramaView pointForOrientation:orientation];
}

- (void) draw: (CGContextRef) context inRect:(CGRect)rect {
    if (!isnan(screenLocation_.x) && !isnan(screenLocation_.y)) {
        CGContextSetFillColorWithColor(context, self.color.CGColor);
        // draw a circle with a radius relative to the aspect of the screen
        float pixelRadius = fmin(rect.size.width, rect.size.height) * self.radius;
        CGContextFillEllipseInRect(context, CGRectMake(screenLocation_.x-pixelRadius, screenLocation_.y-pixelRadius, pixelRadius * 2, pixelRadius * 2));
    }
}

@end

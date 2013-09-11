//
//  SVPDPanoramaOverlayView.h
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GMSPanoramaView.h>

@interface SVPDPanoramaOverlayView : UIView
- (void) updateWithPanoramaView: (GMSPanoramaView*) panoramaView;
@end

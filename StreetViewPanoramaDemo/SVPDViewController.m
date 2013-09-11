//
//  SVPDViewController.m
//  StreetViewPanoramaDemo
//
//  Created by Adam Ratana on 9/8/13.
//  Copyright (c) 2013 Adam Ratana. All rights reserved.
//

#import "SVPDViewController.h"
#import "SVPDPanoramaOverlayView.h"
#import <GoogleMaps/GoogleMaps.h>

#define kInitialHeading 260
#define kInitialPitch 37
#define kDefaultFOV 90
#define kOverlayFrameInterval 2
#define kInitialZoom 1

static CLLocationCoordinate2D kPanoramaNear = {-33.874437, 151.207459};

@implementation SVPDViewController {
    SVPDPanoramaOverlayView *panoramaOverlayView_;
    GMSPanoramaView *panoramaView_;
    CADisplayLink *displayLink_;
    BOOL panoramaConfigured_;
    BOOL overlayUpdateNeeded_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // programatically create our views
    CGRect applicationFrame = [[UIScreen mainScreen] bounds];
    
    // the top level view containing our panorama and panorama overlay
    UIView* topView = [[UIView alloc] initWithFrame:applicationFrame];
    topView.backgroundColor = [UIColor clearColor];
    topView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // initialize the panorama view
    panoramaView_ = [GMSPanoramaView panoramaWithFrame:applicationFrame nearCoordinate:kPanoramaNear];
    panoramaView_.backgroundColor = [UIColor grayColor];
    panoramaView_.delegate = self;
    panoramaView_.navigationLinksHidden = YES;
    panoramaView_.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // our overlay view which will be synched to the panorama
    panoramaOverlayView_ = [[SVPDPanoramaOverlayView alloc] initWithFrame:applicationFrame];
    panoramaOverlayView_.backgroundColor = [UIColor clearColor];
    panoramaOverlayView_.userInteractionEnabled = NO;
    panoramaOverlayView_.clearsContextBeforeDrawing = YES;
    panoramaOverlayView_.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    self.view = topView;
    [self.view addSubview:panoramaView_];
    [self.view addSubview:panoramaOverlayView_];
}

- (void) viewWillAppear:(BOOL)animated {
    // create a display link which will sync a method call with the view refresh
    displayLink_ = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkEvent:)];

    // set the frame interval; a value of 2 means we are firing every other frame, approx 30fps, tune to taste
    displayLink_.frameInterval = kOverlayFrameInterval;
    
    [displayLink_ addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) viewWillDisappear:(BOOL)animated {
    [displayLink_ invalidate];
}

- (void) displayLinkEvent:(CADisplayLink*)sender {
    // only request a sync when something has changed
    if (overlayUpdateNeeded_) {
        [panoramaOverlayView_ setNeedsDisplay];
        overlayUpdateNeeded_ = NO;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (panoramaConfigured_) {
        // refresh camera as it seems that FOV changes when the view is rotated - TODO: eliminate the need for this
        panoramaView_.camera = [GMSPanoramaCamera cameraWithOrientation:panoramaView_.camera.orientation zoom:panoramaView_.camera.zoom+0.0001 FOV:panoramaView_.camera.FOV];
    }
}

#pragma mark - GMSPanoramaDelegate
- (void)panoramaView:(GMSPanoramaView *)panoramaView didMoveCamera:(GMSPanoramaCamera *)camera {
    // camera moved, so we need to update our overlay
    [panoramaOverlayView_ updateWithPanoramaView:panoramaView];
    
    // make sure when the next displayLink event fires that we redraw the overlay
    overlayUpdateNeeded_ = YES;
}

- (void)panoramaView:(GMSPanoramaView *)view didMoveToPanorama:(GMSPanorama *)panorama {
    if (!panoramaConfigured_) {
        // create our intial camera with our default FOV
        // since 1.4.1 the FOV is accessible so we can create some cool fisheye effects or remove distortion with a smaller FOV
        panoramaView_.camera = [GMSPanoramaCamera cameraWithHeading:kInitialHeading
                                        pitch:kInitialPitch zoom:kInitialZoom FOV:kDefaultFOV];
        panoramaConfigured_ = YES;
    }
}
@end
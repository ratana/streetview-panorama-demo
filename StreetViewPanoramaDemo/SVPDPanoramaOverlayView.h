#import <UIKit/UIKit.h>
#import <GoogleMaps/GMSPanoramaView.h>

@interface SVPDPanoramaOverlayView : UIView
- (void) updateWithPanoramaView: (GMSPanoramaView*) panoramaView;
@end

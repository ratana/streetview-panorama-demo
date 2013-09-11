#import <Foundation/Foundation.h>
#import <GoogleMaps/GMSPanoramaView.h>

@protocol SVPDOverlayItem <NSObject>

- (void) updateWithPanoramaView: (GMSPanoramaView*) panoramaView;
- (void) draw: (CGContextRef) context inRect:(CGRect)rect;

@end

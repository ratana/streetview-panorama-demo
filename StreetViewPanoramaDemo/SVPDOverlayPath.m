#import "SVPDOverlayPath.h"

#define kPathLineWidth 5

@implementation SVPDOverlayPath {
    UIBezierPath *bezierPath_;
    UIColor *pathColor_;
    BOOL pathVisible_;
}

const static int kNumPathPoints = 31;
const static float pathPoints_[kNumPathPoints][2] = {
    {119.2,-0.8}, // Sunrise
    {116.5, 2.8}, // 6am
    {112.6, 8.4},
    {108.9, 14.3}, // 7am
    {105.2, 20.2},
    {101.7, 26.3}, // 8am
    {98.1, 32.4},
    {94.4, 38.6}, // 9am
    {90.5, 44.8},
    {86.1, 51}, // 10am
    {80.9, 57.2},
    {74.4, 63.3}, // 11am
    {65.4, 69.1},
    {51.2, 74.5}, // 12pm
    {26.8, 78.4},
    {350.8, 79.4}, // 1pm
    {319.5, 76.7},
    {301, 71.9}, // 2pm
    {289.8, 66.3},
    {282.2, 60.3}, // 3pm
    {276.4, 54.2},
    {271.7, 48}, // 4pm
    {267.6, 41.8},
    {263.7, 35.5},// 5pm
    {260.1, 29.4},
    {256.6, 23.3}, // 6pm
    {253, 17.3},
    {249.3, 11.4}, // 7pm
    {245.5, 5.6},
    {241.4, 0.1}, // 8pm
    {240.7, -0.8} // Sunset
};

-(id) init {
    self = [super init];
    if (self) {
        pathColor_ = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.65];
        bezierPath_ = [UIBezierPath bezierPath];
        bezierPath_.lineWidth = kPathLineWidth;
        pathVisible_ = NO;
    }
    return self;
}

- (void) updateWithPanoramaView: (GMSPanoramaView *) panoramaView {
    // build a path based on which points are visible
    [bezierPath_ removeAllPoints];    
    BOOL contiguousPath = NO;
    pathVisible_ = NO;
    
    for (int i = 0; i < kNumPathPoints; i++) {
        GMSOrientation orientation = {pathPoints_[i][0], pathPoints_[i][1]};
        CGPoint screenLocation = [panoramaView pointForOrientation:orientation];
        if (!isnan(screenLocation.x) && !isnan(screenLocation.y)) {
            if (contiguousPath) {
                [bezierPath_ addLineToPoint:screenLocation];
            } else {
                [bezierPath_ moveToPoint:screenLocation];
            }
            
            pathVisible_ = YES;
            contiguousPath = YES;
        } else {
            contiguousPath = NO;
        }
    }
}

- (void) draw: (CGContextRef) context inRect:(CGRect)rect {
    if (pathVisible_) {
        CGContextSetStrokeColorWithColor(context, pathColor_.CGColor);
        [bezierPath_ stroke];
    }
}
@end
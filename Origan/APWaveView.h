 

#import <UIKit/UIKit.h>

@interface APWaveView : UIView

@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign)CGFloat hY;

- (void)wave;
- (void)stop;

@end

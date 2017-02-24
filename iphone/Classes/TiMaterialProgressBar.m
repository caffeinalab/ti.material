//
//  TiMaterialProgressbar.m
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import "TiMaterialProgressBar.h"


@interface TiMaterialProgressBar ()

@end

@implementation TiMaterialProgressBar

float progressValue = 0.f;

#pragma mark Initializers and memory management

-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    progress = [[MDProgress alloc] initWithFrame:self.frame];
    
    [self addSubview:progress];
    [super initializeState];
}

-(void)dealloc
{
    // Release objects and memory allocated by the view
    RELEASE_TO_NIL(progress);
    [super dealloc];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundColor: [UIColor clearColor]];
    [self progressb: self.proxy];
}

-(void)configurationSet
{
    // This method is called right after all view properties have
    // been initialized from the view proxy. If the view is dependent
    // upon any properties being initialized then this is the method
    // to implement the dependent functionality.
    
    [super configurationSet];
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    // You must implement this method for your view to be sized correctly.
    // This method is called each time the frame / bounds / center changes
    // within Titanium.
    
    [TiUtils setView:progress positionRect:bounds];
}

#pragma mark Main Object

-(MDProgress*)progressb:(id)args {
    NSLog(@"Applying properties to progress");
    progressValue = [TiUtils floatValue:[self.proxy valueForKey:@"value"]];
    
    TiColor *trackColor = [TiUtils colorValue:[self.proxy valueForKey:@"trackTintColor"]];
    TiColor *color = [TiUtils colorValue:[self.proxy valueForKey:@"tintColor"]];
    
    NSInteger style = [TiUtils intValue: [self.proxy valueForKey:@"progressStyle"] def:0];
    NSInteger type  = [TiUtils intValue: [self.proxy valueForKey:@"progressType"] def:0];
    float radius = [TiUtils floatValue:[self.proxy valueForKey:@"radius"] def: -1.f];
    
    NSLog(@"Progressb style and type: %d, %d", style, type);
    
    [progress setProgressColor: [color _color]];
    [progress setTrackColor:[trackColor _color]];
    
    self.style = style;
    self.type = type;
    
    [progress setProgressStyle: self.style];
    [progress setProgressType: self.type];
    
    if (radius != -1.f) {
        [progress setCircularSize:radius];
    }
    [progress setProgress: progressValue];
    
    [self setOpacity_:[self.proxy valueForKey:@"opacity"]];
    
    return progress;
}

#pragma mark Setters

-(id)setOpacity_:(id)value {
    float f = [TiUtils floatValue:value def:1.0];
    progress.alpha = f;
}
-(id)setStyle_:(id)value {
    self.style = [TiUtils intValue:value];
    [progress setStyle:self.style];
}
-(id)setType_:(id)value {
    self.type = [TiUtils intValue:value];
    [progress setType:self.type];
}
-(id)setDeterminate_:(id)value {
    [progress setProgressType:MDProgressTypeDeterminate];
}
-(id)setIndeterminate_:(id)value {
    [progress setProgressType:MDProgressTypeIndeterminate];
}
-(id)setCircular_:(id)value {
    [progress setProgressStyle:MDProgressStyleCircular];
}
-(id)setLinear_:(id)value {
    [progress setProgressStyle:MDProgressStyleLinear];
}
-(id)setTintColor_:(id)value {
    
    TiColor *c = [TiUtils colorValue:value];
    
    [progress setProgressColor: [c _color]];
}
-(id)setTrackTintColor_:(id)value {
    
    TiColor *c = [TiUtils colorValue:value];
    
    [progress setTrackColor: [c _color]];
}
-(id)setValue_:(id)value {
    
    NSLog(@"setValue_: %@", value);
    
    progressValue = [TiUtils floatValue:value];
    [progress setProgress: progressValue];
}
-(id)setRadius_:(float)value {
    //NSLog(@"setCircularSize_: %f ", value);
    
    [progress setCircularSize: value];
}

-(id)show {
    [self addSubview:progress];
}

#pragma mark Event Listeners


@end
















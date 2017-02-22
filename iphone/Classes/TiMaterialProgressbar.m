//
//  TiMaterialProgressbar.m
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import "TiMaterialProgressbar.h"


@interface TiMaterialProgressbar ()

@end

@implementation TiMaterialProgressbar

float progress = 0;

#pragma mark Initializers and memory management

-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    //[self button];
    progress = [[MDProgress alloc] init];
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
    [self progressbar: self.proxy];
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

-(MDProgress*)progressbar:(id)args {
    [progress setProgress:[TiUtils floatValue:[self.proxy valueForKey:@"progress"]]];
    
    TiColor *trackColor = [TiUtils colorValue:[self.proxy valueForKey:@"trackColor"]];
    
    TiColor *bg = [TiUtils colorValue:[self.proxy valueForKey:@"backgroundColor"]];
//    TiColor *ripple = [TiUtils colorValue:[self.proxy valueForKey:@"rippleColor"]];
//    TiColor *color = [TiUtils colorValue:[self.proxy valueForKey:@"color"]];
//    TiColor *hintColor = [TiUtils colorValue:[self.proxy valueForKey:@"hintColor"]];
//    TiColor *errorColor = [TiUtils colorValue:[self.proxy valueForKey:@"errorColor"]];
    
    [progress setType:MDProgressTypeDeterminate];
    [progress setType:MDProgressStyleCircular];
    [progress setTrackColor:[trackColor _color]];
    
    return progress;
}

#pragma mark Setters

-(void)setDisabledColor_:(id)color
{
    if (color!=nil) {
        TiColor *selColor = [TiUtils colorValue:color];
        if (selColor!=nil) {
            //            [button setTitleColor:[selColor _color] forState:UIControlStateDisabled];
        }
    }
}

-(void)setColor_:(id)color
{
    if (color!=nil)
    {
        TiColor *c = [TiUtils colorValue:color];
        //        if (c!=nil)
        //        {
        //            [button setTitleColor:[c _color] forState:UIControlStateNormal];
        //        }
        //        else if (button.buttonType==UIButtonTypeCustom)
        //        {
        //            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        }
    }
}

-(void)setTextAlign_:(id)align
{
    
}

-(void)setBackgroundColor_:(id)value
{
    if (value!=nil)
    {
        TiColor *color = [TiUtils colorValue:value];
        //        [button setBackgroundColor:[color _color]];
    }
}

#pragma mark Event Listeners


@end

//
//  TiMaterialButtonView.m
//  ti.material
//
//  Created by Ani Sinanaj on 16/02/2017.
//
//

#import "TiMaterialButtonView.h"
#import "MDButton.h"

@interface TiMaterialButtonView () <MDButtonDelegate>

@end

@implementation TiMaterialButtonView


-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    //[self button];
    button = [[MDButton alloc] initWithFrame:self.frame];
    [self addSubview:button];
    
    [self setBackgroundColor:[UIColor clearColor]];
    button.mdButtonDelegate = self;
    
    [super initializeState];
}

-(void)dealloc
{
    // Release objects and memory allocated by the view
    RELEASE_TO_NIL(button);
    [super dealloc];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundColor: [UIColor clearColor]];
    [self button];
}

-(void)configurationSet
{
    // This method is called right after all view properties have
    // been initialized from the view proxy. If the view is dependent
    // upon any properties being initialized then this is the method
    // to implement the dependent functionality.
    
    [super configurationSet];
}

-(MDButton*)button
{
    BOOL hasImage = [self.proxy valueForKey:@"backgroundImage"]!=nil;
    MDButtonType defaultType = (hasImage==YES) ? MDButtonTypeRaised : MDButtonTypeFlat;
    style = [TiUtils intValue:[self.proxy valueForKey:@"style"] def:defaultType];
    
    TiColor *bg = [TiUtils colorValue:[self.proxy valueForKey:@"backgroundColor"]];
    TiColor *ripple = [TiUtils colorValue:[self.proxy valueForKey:@"rippleColor"]];
    TiColor *color = [TiUtils colorValue:[self.proxy valueForKey:@"color"]];
    
    [button setMdButtonType:style];
    [button
        setTitle:[TiUtils stringValue:[self.proxy valueForKey:@"title"]]
        forState:UIControlStateNormal];
    
    [button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [button setBackgroundColor: [bg _color]];
    [button setRippleColor: [ripple _color]];
    [button setTitleColor:[color _color] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(controlAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
    button.exclusiveTouch = YES;
    
    return button;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    // You must implement this method for your view to be sized correctly.
    // This method is called each time the frame / bounds / center changes
    // within Titanium.
    
    [TiUtils setView:button positionRect:bounds];
}

- (void)controlAction:(id)sender forEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    NSString *fireEvent;
    NSString * fireActionEvent = nil;
    switch (touch.phase) {
        case UITouchPhaseBegan:
            if (touchStarted) {
                return;
            }
            touchStarted = YES;
            fireEvent = @"touchstart";
            break;
        case UITouchPhaseMoved:
            fireEvent = @"touchmove";
            break;
        case UITouchPhaseEnded:
            touchStarted = NO;
            fireEvent = @"touchend";
            if (button.highlighted) {
                fireActionEvent = [touch tapCount] == 1 ? @"click" : ([touch tapCount] == 2 ? @"dblclick" : nil);
            }
            break;
        case UITouchPhaseCancelled:
            touchStarted = NO;
            fireEvent = @"touchcancel";
            break;
        default:
            return;
    }
    
    //[self setHighlighting:button.highlighted];
    NSMutableDictionary *evt = [NSMutableDictionary dictionaryWithDictionary:[TiUtils touchPropertiesToDictionary:touch andView:self]];
    if ((fireActionEvent != nil) && [self.proxy _hasListeners:fireActionEvent]) {
        [self.proxy fireEvent:fireActionEvent withObject:evt];
    }
    if ([self.proxy _hasListeners:fireEvent]) {
        [self.proxy fireEvent:fireEvent withObject:evt];
    }
}

-(void)rotationStarted:(id)sender {
    NSLog(@"Rotation started");
    
    NSMutableDictionary *evt = nil;
    
    NSString *fireEvent = @"rotationStarted";
    if ([self.proxy _hasListeners:fireEvent]) {
        [self.proxy fireEvent:fireEvent withObject:evt];
    }
}

-(void)rotationCompleted:(id)sender{
    NSLog(@"Rotation completed");
    
    NSMutableDictionary *evt = nil;
    
    NSString *fireEvent = @"rotationCompleted";
    if ([self.proxy _hasListeners:fireEvent]) {
        [self.proxy fireEvent:fireEvent withObject:evt];
    }
}

@end

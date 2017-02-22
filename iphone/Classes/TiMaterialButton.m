//
//  TiMaterialButtonView.m
//  ti.material
//
//  Created by Ani Sinanaj on 16/02/2017.
//
//

#import "TiMaterialButton.h"
#import "MDButton.h"

@interface TiMaterialButton () <MDButtonDelegate>

@end

@implementation TiMaterialButton

#pragma mark Initializers and memory management

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

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    // You must implement this method for your view to be sized correctly.
    // This method is called each time the frame / bounds / center changes
    // within Titanium.
    
    [TiUtils setView:button positionRect:bounds];
}

#pragma mark Main Object

-(MDButton*)button
{
    BOOL hasImage = [self.proxy valueForKey:@"backgroundImage"]!=nil;
    MDButtonType defaultType = (hasImage==YES) ? MDButtonTypeRaised : MDButtonTypeFlat;
    style = [TiUtils intValue:[self.proxy valueForKey:@"style"] def:defaultType];
    
    TiColor *bg = [TiUtils colorValue:[self.proxy valueForKey:@"backgroundColor"]];
    TiColor *ripple = [TiUtils colorValue:[self.proxy valueForKey:@"rippleColor"]];
    TiColor *color = [TiUtils colorValue:[self.proxy valueForKey:@"color"]];
    WebFont *f = [TiUtils fontValue:[self.proxy valueForKey:@"font"] def:nil];    
    
    [button setMdButtonType:style];
    [button
     setTitle:[TiUtils stringValue:[self.proxy valueForKey:@"title"]]
     forState:UIControlStateNormal];
    
    [button setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [button setBackgroundColor: [bg _color]];
    [button setRippleColor: [ripple _color]];
    [button setTitleColor:[color _color] forState:UIControlStateNormal];
    [[button titleLabel] setFont:[f font]];
    [button addTarget:self action:@selector(controlAction:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
    button.exclusiveTouch = YES;
    
    return button;
}

#pragma mark Setters

-(void)setFont_:(id)font
{
    if (font!=nil)
    {
        WebFont *f = [TiUtils fontValue:font def:nil];
        [[[self button] titleLabel] setFont:[f font]];
    }
}

-(void)setDisabledColor_:(id)color
{
    if (color!=nil) {
        TiColor *selColor = [TiUtils colorValue:color];
        if (selColor!=nil) {
            [button setTitleColor:[selColor _color] forState:UIControlStateDisabled];
        }
    }
}

-(void)setColor_:(id)color
{
    if (color!=nil)
    {
        TiColor *c = [TiUtils colorValue:color];
        if (c!=nil)
        {
            [button setTitleColor:[c _color] forState:UIControlStateNormal];
        }
        else if (button.buttonType==UIButtonTypeCustom)
        {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

-(void)setTextAlign_:(id)align
{
    NSTextAlignment alignment = NSTextAlignmentNatural;
    UIControlContentHorizontalAlignment horizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    if ([align isKindOfClass:[NSString class]]) {
        if ([align isEqualToString:@"left"])
        {
            alignment = NSTextAlignmentLeft;
        }
        else if ([align isEqualToString:@"right"])
        {
            alignment = NSTextAlignmentRight;
        }
        else if ([align isEqualToString:@"center"])
        {
            alignment = NSTextAlignmentCenter;
        }
    } else {
        alignment = (NSTextAlignment)[TiUtils intValue:align def:(int)NSTextAlignmentNatural];
    }
    
    UIEdgeInsets inset = [button contentEdgeInsets];
    switch (alignment) {
        case NSTextAlignmentLeft:
        {
            horizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            inset.left = 10;
            inset.right = 0;
            break;
        }
        case NSTextAlignmentRight:
        {
            horizontalAlignment = UIControlContentHorizontalAlignmentRight;
            inset.right = 10;
            inset.left = 0;
            break;
        }
        default:
        {
            horizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            inset.right = 0;
            inset.left = 0;
            break;
        }
    }
    [button setContentHorizontalAlignment:horizontalAlignment];
    [button setContentEdgeInsets:inset];
}

-(void)setBackgroundColor_:(id)value
{
    if (value!=nil)
    {
        TiColor *color = [TiUtils colorValue:value];
        [button setBackgroundColor:[color _color]];
    }
}

#pragma mark Event Listeners

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
    
    NSMutableDictionary *evt = [TiUtils dictionaryWithCode:1 message:@"Rotation started"];
    
    NSString *fireEvent = @"rotationStarted";
    //if ([self.proxy _hasListeners:fireEvent]) {
        [self.proxy fireEvent:fireEvent withObject:evt];
    //}
}

-(void)rotationCompleted:(id)sender{
    NSLog(@"Rotation completed");
    
    NSMutableDictionary *evt = [TiUtils dictionaryWithCode:1 message:@"Rotation completed"];
    
    NSString *fireEvent = @"rotationCompleted";
    //if ([self.proxy _hasListeners:fireEvent]) {
        [self.proxy fireEvent:fireEvent withObject:evt];
    //}
}

@end

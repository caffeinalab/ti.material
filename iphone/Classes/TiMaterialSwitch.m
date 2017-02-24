//
//  TiMaterialSwitch.m
//  ti.material
//
//  Created by Ani Sinanaj on 22/02/2017.
//
//

#import "TiMaterialSwitch.h"

@interface TiMaterialSwitch ()

@end

@implementation TiMaterialSwitch

#pragma mark Initializers and memory management

-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    switchUI = [[MDSwitch alloc] init];
    
    [self addSubview:switchUI];
    [super initializeState];
}

-(void)dealloc
{
    // Release objects and memory allocated by the view
    [switchUI removeTarget:self action:@selector(updateState:) forControlEvents:UIControlEventValueChanged];
    RELEASE_TO_NIL(switchUI);
    [super dealloc];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundColor: [UIColor clearColor]];
    [self switchUICreate: self.proxy];
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
    
    [TiUtils setView:switchUI positionRect:bounds];
}

#pragma mark Main Object

-(MDSwitch*)switchUICreate:(id)args {
    
    TiColor *trackOn  = [TiUtils colorValue:[self.proxy valueForKey:@"trackOnColor"]];
    TiColor *trackOff = [TiUtils colorValue:[self.proxy valueForKey:@"trackOffColor"]];
    TiColor *thumbOn  = [TiUtils colorValue:[self.proxy valueForKey:@"thumbOnColor"]];
    TiColor *thumbOff = [TiUtils colorValue:[self.proxy valueForKey:@"thumbOffColor"]];
    
    [switchUI setOn:[TiUtils boolValue:[self.proxy valueForKey:@"value"]]];
    
    [switchUI setThumbOn:[thumbOn _color]];
    [switchUI setTrackOn:[trackOn _color]];
    [switchUI setThumbOff:[thumbOff _color]];
    [switchUI setTrackOff:[trackOff _color]];
    
    [self setOnLabel:[TiUtils stringValue:[self.proxy valueForKey:@"onLabel"]]];
    [self setOffLabel:[TiUtils stringValue:[self.proxy valueForKey:@"onLabel"]]];
    
    [switchUI addTarget:self action:@selector(updateState:) forControlEvents:UIControlEventValueChanged];
    
    return switchUI;
}

#pragma mark Setters

-(void)setTrackOnColor_:(id)value
{
    TiColor *c = [TiUtils colorValue:value];
    [switchUI setTrackOn:[c _color]];
}
-(void)setTrackOffColor_:(id)value
{
    TiColor *c = [TiUtils colorValue:value];
    [switchUI setTrackOff:[c _color]];
}
-(void)setThumbOnColor_:(id)value
{
    TiColor *c = [TiUtils colorValue:value];
    [switchUI setThumbOn:[c _color]];
}
-(void)setThumbOffColor_:(id)value
{
    TiColor *c = [TiUtils colorValue:value];
    [switchUI setThumbOff:[c _color]];
}

#pragma mark Event Listeners

- (void)updateState:(id)sender {
    
    NSNumber * newValue = [NSNumber numberWithBool:switchUI.isOn];
    id current = [self.proxy valueForUndefinedKey:@"value"];
    [self.proxy replaceValue:newValue forKey:@"value" notification:NO];
    
    //No need to setValue, because it's already been set.
    if ([self.proxy _hasListeners:@"change"] && (current != newValue) && ![current isEqual:newValue])
    {
        [self.proxy fireEvent:@"change"
                   withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
    }
}

@end

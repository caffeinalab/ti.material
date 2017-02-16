//
//  Toast.m
//  ti.material
//
//  Created by Ani Sinanaj on 10/02/2017.
//
//

#import "TiMaterialToastProxy.h"
#import "MDToast.h"
#import "TiUtils.h"
#import "TiBase.h"

@implementation TiMaterialToastProxy

MDToast *toast;

-(id)init
{
    toast = [[MDToast alloc] initWithText:@"" duration:kMDToastDurationShort];
    return self;
}

#pragma mark Cleanup

-(void)_destroy
{
    // release any resources that have been retained by the module
    
    RELEASE_TO_NIL(toast);
    [super _destroy];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
    // optionally release any resources that can be dynamically
    // reloaded once memory is available - such as caches
    [super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
    if (count == 1 && [type isEqualToString:@"my_event"])
    {
        // the first (of potentially many) listener is being added
        // for event named 'my_event'
    }
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
    if (count == 0 && [type isEqualToString:@"my_event"])
    {
        // the last listener called for event named 'my_event' has
        // been removed, we can optionally clean up any resources
        // since no body is listening at this point for that event
    }
}

#pragma mark Public methods

-(id)setText:(id)args
{
    NSLog(@"%@", args);
    if (nil == toast) return nil;
    
    NSString *text = [TiUtils stringValue: args];
    [toast setText:text];
}

-(id)setDuration:(id)args
{
    NSLog(@"%@", args);
    if (nil == toast) return nil;
    
    NSTimeInterval duration = [TiUtils intValue:args] / 1000;
    [toast setDuration: duration];
}

-(id)setFont:(id)args
{
    NSLog(@"Feature not implemented yet.");
    if (nil == toast) return nil;
}

-(id)show:(id)args
{
    [toast show];
}

#pragma mark Shortcut method for testing

-(id)createToast:(id)args
{
    NSLog(@"%@", args);
    
    NSString *message = [TiUtils stringValue:[[args objectAtIndex:0] valueForKey:@"message"]];
    //TiColor *color = [TiUtils colorValue:[[args objectAtIndex:0] valueForKey:@"color"]];
    
    toast = [[MDToast alloc] initWithText:message duration:kMDToastDurationShort];
    //toast.backgroundColor = color;
    toast.textFont = [UIFont systemFontOfSize:14];
    [toast setGravity:MDGravityCenterVertical | MDGravityCenterHorizontal];
    [toast show];
}

@end

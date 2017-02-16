//
//  TiMaterialButtonProxy.m
//  ti.material
//
//  Created by Ani Sinanaj on 16/02/2017.
//
//

#import "TiMaterialButtonProxy.h"
#import "MDTimePickerDialog.h"
#import "NSDate+MDExtension.h"
#import "TiUtils.h"
#import "KrollObject.h"
#import "KrollBridge.h"
#import "KrollObject.h"

@implementation TiMaterialButtonProxy

-(id)init
{
    [super init];
    return self;
}

#pragma mark Cleanup

-(void)_destroy
{
    // release any resources that have been retained by the module
    
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

-(id)show:(id)args
{
    
}

@end

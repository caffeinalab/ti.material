/**
 * ti.material
 *
 * Created by Ani Sinanaj
 * Copyright (c) 2017 Caffeina. All rights reserved.
 */

#import "TiMaterialModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiMaterialModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"e8750b5f-d1cf-4c47-bd1d-8406a3b2e929";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.material";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
    
    MDTextFieldViewStateNormal = 0;
    MDTextFieldViewStateHighlighted = 1;
    MDTextFieldViewStateError = 2;
    MDTextFieldViewStateDisabled = 3;

    MDButtonTypeRaised = 0;
    MDButtonTypeFlat = 1;
    MDButtonTypeFloatingAction = 2;
    MDButtonTypeFloatingActionRotation = 3;
    
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
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

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)MDTextFieldViewStateNormal {
	return MDTextFieldViewStateNormal;
}
-(id)MDTextFieldViewStateHighlighted {
    return MDTextFieldViewStateHighlighted;
}
-(id)MDTextFieldViewStateError {
    return MDTextFieldViewStateError;
}
-(id)MDTextFieldViewStateDisabled {
    return MDTextFieldViewStateDisabled;
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end

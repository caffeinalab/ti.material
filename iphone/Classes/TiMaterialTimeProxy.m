//
//  TiMaterialTimeProxy.m
//  ti.material
//
//  Created by Ani Sinanaj on 10/02/2017.
//
//

#import "TiMaterialTimeProxy.h"
#import "MDTimePickerDialog.h"
#import "NSDate+MDExtension.h"
#import "TiUtils.h"
#import "KrollObject.h"
#import "KrollBridge.h"
#import "KrollObject.h"

@interface TiMaterialTimeProxy () <MDTimePickerDialogDelegate>
    @property(nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation TiMaterialTimeProxy

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
    MDTimePickerDialog *timePicker = [[MDTimePickerDialog alloc] init];
//    if (self.lightThemeSwitch.on) {
//        timePicker.theme = MDTimePickerThemeLight;
//    } else {
//        timePicker.theme = MDTimePickerThemeDark;
//    }
    timePicker.theme = MDTimePickerThemeLight;
    timePicker.delegate = self;
    [timePicker show];
}

- (void)timePickerDialog:(MDTimePickerDialog *)timePickerDialog
           didSelectHour:(NSInteger)hour
               andMinute:(NSInteger)minute {
    
    NSDictionary *d = @{
                        @"hour": [NSNumber numberWithUnsignedInteger: hour],
                        @"minute": [NSNumber numberWithUnsignedInteger: minute ]};
    NSLog(@"%@",d);
    if ([self _hasListeners:@"change"]) {
        [self fireEvent:@"change" withObject: d];
    }
}

#pragma mark Shortcut method for testing

-(id)createToast:(id)args
{
    NSLog(@"%@", args);
    
    MDTimePickerDialog *timePicker = [[MDTimePickerDialog alloc] init];
//    if (self.lightThemeSwitch.on) {
//        timePicker.theme = MDTimePickerThemeLight;
//    } else {
        timePicker.theme = MDTimePickerThemeDark;
//    }
//    timePicker.delegate = self;
    [timePicker show];
}


@end

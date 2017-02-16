//
//  Calendar.m
//  ti.material
//
//  Created by Ani Sinanaj on 10/02/2017.
//
//

#import "TiMaterialDatepickerProxy.h"
#import "MDCalendar.h"
#import "MDDatePickerDialog.h"
#import "NSDate+MDExtension.h"

@interface TiMaterialDatepickerProxy () <MDDatePickerDialogDelegate>

@end


@implementation TiMaterialDatepickerProxy

NSDate *minDate;
NSDate *selectedDate;

-(id)init
{
    [super init];
    return self;
}

#pragma mark Cleanup

-(void)_destroy
{
    // release any resources that have been retained by the module

    RELEASE_TO_NIL(minDate);
    RELEASE_TO_NIL(selectedDate);
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

-(id)setMinDate:(id)args
{
    NSLog(@"%@", args);
    ENSURE_STRING(args);

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    minDate = [df dateFromString: args];
}

-(id)setSelectedDate:(id)args
{
    NSLog(@"%@", args);
    ENSURE_STRING(args);

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    selectedDate = [df dateFromString: args];
}

-(NSDate *)today
{
    NSDate *d = [NSDate date];
    return d;
}

-(void)datePickerDialogDidSelectDate:(NSDate*) date
{
    NSLog(@"Selected date %@", date);
    
    NSDictionary *d = @{
                        @"date": date
    };
    
    if ([self _hasListeners:@"change"]) {
        [self fireEvent:@"change" withObject:d];
    }
}

-(id)show:(id)args
{
    MDDatePickerDialog *datePicker = [[MDDatePickerDialog alloc] init];
    
    if (minDate) {
        datePicker.minimumDate = minDate;
    }
    
    if (selectedDate) {
        datePicker.selectedDate = selectedDate;
    } else {
        datePicker.selectedDate = [self today];
    }
    
    datePicker.delegate = self;

    [datePicker show];
}

#pragma mark Shortcut method for testing

-(id)createCalendar:(id)args
{
    NSLog(@"%@", args);
    NSDictionary *dict = [args objectAtIndex:0];

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = 1980;
    dateComponents.month = 1;
    dateComponents.day = 5;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];

    RELEASE_TO_NIL(dateComponents)

    MDDatePickerDialog *datePicker = [[MDDatePickerDialog alloc] init];
    datePicker.minimumDate = date;
    datePicker.selectedDate = date;
    //_datePicker.delegate = self;
    [datePicker show];

}

@end

//
//  TiMaterialTextField.m
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import "MDTextField.h"
#import "TiMaterialTextField.h"

@interface TiMaterialTextField () <MDTextFieldDelegate>

@end

@implementation TiMaterialTextField {
    NSArray *inputAccessoryViews;
    CGFloat inputAccessoryViewHeight;
}

#pragma mark Initializers and memory management

-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    
    activeField = [[MDTextField alloc] initWithFrame:self.frame];
    [self addSubview:activeField];
    
    activeField.delegate = self;
    
    [super initializeState];
}

-(void)dealloc
{
    // Release objects and memory allocated by the view
    RELEASE_TO_NIL(activeField);
    [super dealloc];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundColor: [UIColor clearColor]];
    [self textField: self.proxy];
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
    
    [TiUtils setView:activeField positionRect:bounds];
}

#pragma mark Main Object

-(MDTextField*)textField:(id)args {
    TiColor *bg = [TiUtils colorValue:[self.proxy valueForKey:@"backgroundColor"]];
    TiColor *ripple = [TiUtils colorValue:[self.proxy valueForKey:@"rippleColor"]];
    TiColor *color = [TiUtils colorValue:[self.proxy valueForKey:@"color"]];
    TiColor *hintColor = [TiUtils colorValue:[self.proxy valueForKey:@"hintColor"]];
    TiColor *errorColor = [TiUtils colorValue:[self.proxy valueForKey:@"errorColor"]];
    
    NSMutableArray *data = [self.proxy mutableArrayValueForKey:@"data"];
    
    if (!activeField) {
        activeField = [[MDTextField alloc] initWithFrame:self.frame];
    }
    activeField.dividerAnimation = true;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:tap];

    
    [self setFullWidth_:[TiUtils boolValue:[self.proxy valueForKey:@"fullWidth"]]];
    [self setHint_:[TiUtils stringValue:[self.proxy valueForKey:@"hint"]]];
    [self setLabel_:[TiUtils stringValue:[self.proxy valueForKey:@"label"]]];
    [self setText_:[TiUtils stringValue:[self.proxy valueForKey:@"text"]]];
    
//    [self setEnabled_:[TiUtils boolValue:[self.proxy valueForKey:@"enabled"] /*def:YES*/]];
//    [self setHasError_:[TiUtils boolValue:[self.proxy valueForKey:@"hasError"] /*def:NO*/]];
    
    if(data) {
        [self setSuggestions_:data];
    }
    
    [activeField setHintColor:[hintColor _color]];
    [activeField setTextColor:[color _color]];
    [activeField setBackgroundColor:[bg _color]];
    [activeField setErrorColor:[errorColor _color]];
    [activeField setSingleLine:YES];

    [activeField setLabelsFont:[[TiUtils fontValue:[self.proxy valueForKey:@"labelFont"]] font]];
    [activeField setInputTextFont:[[TiUtils fontValue:[self.proxy valueForKey:@"textFont"]] font]];

    [activeField setErrorMessage:[TiUtils stringValue:[self.proxy valueForKey:@"errorMessage"]]];
    [activeField setFloatingLabel:[TiUtils boolValue:[self.proxy valueForKey:@"floatingLabel"] /*def:YES*/]];
    [activeField setMaxCharacterCount:[TiUtils intValue:[self.proxy valueForKey:@"maxCharacterCount"]]];
    
    activeField.exclusiveTouch = YES;
    
    return activeField;
}

#pragma mark Setters

-(void)setSuggestions_:(id)data {
    ENSURE_ARRAY(data);
    
    [activeField setSuggestionsDictionary: data];
}

-(void)setFullWidth_:(id)full {
    [activeField setFullWidth: [TiUtils boolValue:full /*def:NO*/]];
}
-(void)setHint_:(id)arg {
    [activeField setHint: [TiUtils stringValue:arg]];
}
-(void)setLabel_:(id)arg {
    [activeField setLabel: [TiUtils stringValue:arg]];
}
-(void)setText_:(id)arg {
    //[self.proxy setValue:arg forKey:@"text"];
    [activeField setText: [TiUtils stringValue:arg]];
}
-(void)setEnabled_:(id)enabled {
    [activeField setEnabled: [TiUtils boolValue:enabled /*def:YES*/]];
}
-(void)setHasError_:(id)arg {
    [activeField setHasError: [TiUtils boolValue:arg /*def:NO*/]];
}
-(void)setHasFocus_:(id)args {
    [self doneTyping];
}

-(id)getText_ {
    NSLog(activeField.text);
}

#pragma mark Event Listeners

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWasShown:)
     name:UIKeyboardDidShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillBeHidden:)
     name:UIKeyboardWillHideNotification
     object:nil];
}

- (void)unregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize =
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat kbHeight = kbSize.height + inputAccessoryViewHeight;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbHeight;
    CGPoint p = CGPointMake(0, activeField.frame.origin.y +
                            activeField.frame.size.height);
    
    
    [self.proxy fireEvent:@"keyboardShown"];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    [self.proxy fireEvent:@"keyboardHidden"];
}

- (void)textFieldDidChange:(MDTextField *)textField {
    NSDictionary *evt = @{
                            @"value" : [TiUtils stringValue:textField.text]
                            };
    [self.proxy fireEvent:@"change" withObject:evt];
}

- (void)dismissKeyboard {
    [activeField endEditing:YES];
    [self endEditing:YES];
}

- (BOOL)textFieldShouldBeginEditing:(MDTextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(MDTextField *)textField {
    //activeField = textField;
}

- (void)textFieldDidEndEditing:(MDTextField *)textField {
    //activeField = nil;
    
}

- (void)doneTyping {
    [activeField resignFirstResponder];
}


@end

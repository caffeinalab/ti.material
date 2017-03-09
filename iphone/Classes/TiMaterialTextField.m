//
//  TiMaterialTextField.m
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import "MDTextField.h"
#import "TiMaterialTextField.h"
#import "TiMaterialTextFieldProxy.h"
#import "TiApp.h"

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
    NSMutableArray *data = [self.proxy mutableArrayValueForKey:@"data"];
    
    if (!activeField) {
        activeField = [[MDTextField alloc] initWithFrame:self.frame];
    }

    activeField.dividerAnimation = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:tap];
    
    [self setHint_:[TiUtils stringValue:[self.proxy valueForKey:@"hint"]]];
    [self setLabel_:[TiUtils stringValue:[self.proxy valueForKey:@"label"]]];
    [self setValue_:[TiUtils stringValue:[self.proxy valueForKey:@"value"]]];
    
    [self setBackgroundColor_:[self.proxy valueForKey:@"backgroundColor"]];
    [self setColor_:[self.proxy valueForKey:@"color"]];
    [self setHintTextColor_:[self.proxy valueForKey:@"hintTextColor"]];
    [self setErrorColor_:[self.proxy valueForKey:@"errorColor"]];
    
    [self setEnabled_:[self.proxy valueForKey:@"enabled"]];
    [self setHasError_:[self.proxy valueForKey:@"hasError"]];
    
    if(data) {
        [self setData_:data];
    }
    
    [self setSingleLine_:[self.proxy valueForKey:@"singleLine"]];
    [self setFloatingLabel_:[self.proxy valueForKey:@"floatingLabel"]];
    [self setMaxLength_:[self.proxy valueForKey:@"maxLength"]];
    
    [self setFont_:[self.proxy valueForKey:@"font"]];
    [self setLabelFont_:[self.proxy valueForKey:@"labelFont"]];
    
    [self setErrorMessage_:[self.proxy valueForKey:@"errorMessage"]];
    
    [self setFullWidth_:[self.proxy valueForKey:@"fullWidth"]];
    
    activeField.exclusiveTouch = YES;
    return activeField;
}

#pragma mark Setters
-(void)setHintTextColor_:(id)value {
    TiColor *color = [TiUtils colorValue:value];
    [activeField setHintColor:[color _color]];
    
}
-(void)setColor_:(id)value {
    TiColor *color = [TiUtils colorValue:value];
    [activeField setTextColor:[color _color]];
    
}
-(void)setBackgroundColor_:(id)value {
    TiColor *color = [TiUtils colorValue:value];
    [activeField setBackgroundColor:[color _color]];
    self.backgroundColor = [color _color];
}
-(void)setErrorColor_:(id)value {
    TiColor *color = [TiUtils colorValue:value];
    [activeField setErrorColor:[color _color]];
    
}

-(void)setData_:(id)data {
    ENSURE_ARRAY(data);
    
    [activeField setSuggestionsDictionary: data];
}

-(void)setFullWidth_:(id)full {
    [activeField setFullWidth: [TiUtils boolValue:full def:NO]];
}
-(void)setHint_:(id)arg {
    [activeField setHint: [TiUtils stringValue:arg]];
}
-(void)setLabel_:(id)arg {
    [activeField setLabel: [TiUtils stringValue:arg]];
}
-(void)setText_:(id)arg {
    //[self.proxy setValue:arg forKey:@"text"];
    if (arg != nil) {
        [activeField setText: [TiUtils stringValue:arg]];
    }
}
-(void)setEnabled_:(id)enabled {
    [activeField setEnabled: [TiUtils boolValue:enabled def:YES]];
}
-(void)setHasError_:(id)arg {
    [activeField setHasError: [TiUtils boolValue:arg def:NO]];
}
-(void)setFocus_:(id)args {
    [self doneTyping];
}
-(void)setBlur_:(id)args {
    [self doneTyping];
}
-(void)setSingleLine_:(id)args {
    [activeField setSingleLine: [TiUtils boolValue:args def:YES]];
}
-(void)setFloatingLabel_:(id)args {
    [activeField setFloatingLabel: [TiUtils boolValue:args def:YES]];
}
-(void)setMaxLength_:(id)args {
    [activeField setMaxCharacterCount: [TiUtils floatValue:args]];
}
-(void)setFont_:(id)args {
    WebFont *f = [TiUtils fontValue:args];
    [activeField setInputTextFont: [f font]];
}
-(void)setLabelFont_:(id)args {
    WebFont *f = [TiUtils fontValue:args];
    [activeField setLabelsFont: [f font]];
}
-(void)setErrorMessage_:(id)args {
    [activeField setErrorMessage:[TiUtils stringValue:args]];
}

-(void)setReturnKeyType_:(id)value
{
    [activeField setReturnKeyType:[TiUtils intValue:value]];
}

-(void)setKeyboardType_:(id)value
{
    [activeField setKeyboardType:[TiUtils intValue:value]];
}

-(void)setAutoComplete_:(id)value
{
    [activeField setAutoComplete:[TiUtils boolValue:value]];
}


#pragma mark Responder methods
//These used to be blur/focus, but that's moved to the proxy only.
//The reason for that is so checking the toolbar can use UIResponder methods.

-(void)setPasswordMask_:(id)value
{
    [activeField setSecureTextEntry:[TiUtils boolValue:value]];
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
//    CGPoint p = CGPointMake(0, activeField.frame.origin.y +
//                            activeField.frame.size.height);
    
    
    [self.proxy fireEvent:@"keyboardShown"];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    
    [self.proxy fireEvent:@"keyboardHidden"];
}

- (void)textFieldDidChange:(MDTextField *)textField {
    [(TiMaterialTextFieldProxy*)[self proxy] noteValueChange:textField.text];
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
    [activeField resignFirstResponder];
}

- (void)doneTyping {
    [activeField resignFirstResponder];
}

-(void)setValue_:(id)value
{
    NSString* string = [TiUtils stringValue:value];
    if (string == nil)
    {
        return;
    }
    [activeField setText:string];
    [(TiMaterialTextFieldProxy*)[self proxy] noteValueChange:string];
}

-(UIView<UITextInputTraits>*)activeField
{
    return nil;
}

#pragma mark - Titanium Internal Use Only
-(void)updateKeyboardStatus
{
    if ( ([[[TiApp app] controller] keyboardVisible]) && ([[[TiApp app] controller] keyboardFocusedProxy] == [self proxy]) ) {
        [[[TiApp app] controller] performSelector:@selector(handleNewKeyboardStatus) withObject:nil afterDelay:0.0];
    }
}

@end

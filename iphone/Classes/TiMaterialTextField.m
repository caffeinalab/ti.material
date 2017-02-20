//
//  TiMaterialTextField.m
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import "TiMaterialTextField.h"

@implementation TiMaterialTextField
-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    //[self button];
    
    [super initializeState];
}

-(void)dealloc
{
    // Release objects and memory allocated by the view
    //RELEASE_TO_NIL(button);
    [super dealloc];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundColor: [UIColor clearColor]];
    
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
    
    //[TiUtils setView:button positionRect:bounds];
}

@end

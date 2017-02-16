//
//  TiMaterialTabBarView.m
//  ti.material
//
//  Created by Ani Sinanaj on 13/02/2017.
//
//

#import "TiMaterialTabbarView.h"
#import "MDTabBarViewController.h"
#import "MDTabBar.h"
#import "TiUIView.h"
#import "TiUtils.h"

@interface TiMaterialTabbarView () <MDTabBarViewControllerDelegate>

@end

@implementation TiMaterialTabbarView

MDTabBar *tabbar;
NSMutableArray *views;

-(void)dealloc
{
    NSLog(@"[VIEW LIFECYCLE EVENT] dealloc");
    
    // Release objects and memory allocated by the view
    RELEASE_TO_NIL(tabBarViewController);
    RELEASE_TO_NIL(tabbar);
    RELEASE_TO_NIL(square);
    
    [super dealloc];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"[VIEW LIFECYCLE EVENT] willMoveToSuperview");
}

-(void)initializeState
{
    // This method is called right after allocating the view and
    // is useful for initializing anything specific to the view
    square = [[UIView alloc] initWithFrame:[self frame]];
    tabBarViewController = [[MDTabBarViewController alloc] initWithDelegate:self];
    [super initializeState];
    
    
    NSLog(@"[VIEW LIFECYCLE EVENT] initializeState");
}

-(void)configurationSet
{
    // This method is called right after all view properties have
    // been initialized from the view proxy. If the view is dependent
    // upon any properties being initialized then this is the method
    // to implement the dependent functionality.
    
    [super configurationSet];
    
    NSLog(@"[VIEW LIFECYCLE EVENT] configurationSet");
}

-(UIView*)square
{
    // Return the square view. If this is the first time then allocate and
    // initialize it.
    //tabBarViewController = [[MDTabBarViewController alloc] initWithDelegate:self];
    //square = tabBarViewController.view;
    if (tabBarViewController == nil) {
        tabBarViewController = [[MDTabBarViewController alloc] initWithDelegate:self];
    }
    
    if (square == nil) {
        NSLog(@"[VIEW LIFECYCLE EVENT] square");
        square = [[UIView alloc] initWithFrame:[self frame]];
        [square addSubview:tabBarViewController.view];
    }
    
    return square;
}

-(void)notifyOfColorChange:(TiColor*)newColor
{
    NSLog(@"[VIEW LIFECYCLE EVENT] notifyOfColorChange");
    
    // The event listeners for a view are actually attached to the view proxy.
    // You must reference 'self.proxy' to get the proxy for this view
    
    // It is a good idea to check if there are listeners for the event that
    // is about to fired. There could be zero or multiple listeners for the
    // specified event.
    if ([self.proxy _hasListeners:@"colorChange"]) {
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                               newColor,@"color",
                               nil
                               ];
        
        [self.proxy fireEvent:@"colorChange" withObject:event];
    }
}

-(id)addViews:(id)args {
    
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    // You must implement this method for your view to be sized correctly.
    // This method is called each time the frame / bounds / center changes
    // within Titanium.
    
    NSLog(@"[VIEW LIFECYCLE EVENT] frameSizeChanged");
		  
    if (square != nil) {
        
        // You must call the special method 'setView:positionRect' against
        // the TiUtils helper class. This method will correctly layout your
        // child view within the correct layout boundaries of the new bounds
        // of your view.
        
        [TiUtils setView:square positionRect:bounds];
    }
}

-(void)setColor_:(id)color
{
    // This method is a property 'setter' for the 'color' property of the
    // view. View property methods are named using a special, required
    // convention (the underscore suffix).
    
    NSLog(@"[VIEW LIFECYCLE EVENT] Property Set: setColor_");
    
    // Use the TiUtils methods to get the values from the arguments
    TiColor *newColor = [TiUtils colorValue:color];
    UIColor *clr = [newColor _color];
    UIView *sq = [self square];
    sq.backgroundColor = clr;
    
    // Signal a property change notification to demonstrate the use
    // of the proxy for the event listeners
    [self notifyOfColorChange:newColor];
}

- (UIViewController *)tabBarViewController:
(MDTabBarViewController *)viewController viewControllerAtIndex:(NSUInteger)index {
    
    
    UIViewController *controller = [[UIViewController alloc] init];
    if ([views count] != 0 && views[index] != nil) controller.view = views[index];
    
    return controller;
}

@end

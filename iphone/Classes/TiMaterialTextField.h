//
//  TiMaterialTextField.h
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import <UIKit/UIKit.h>
#import "TiUIView.h"
#import "MDTextField.h"

@interface TiMaterialTextField : TiUIView {
    @protected
        TiUIView<TiScrolling> *	parentScrollView;
    @private
        MDTextField *activeField;
}


-(void)setValue_:(id)text;

#pragma mark - Titanium Internal Use Only
-(void)updateKeyboardStatus;

@end

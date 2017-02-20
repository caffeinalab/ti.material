//
//  TiMaterialButtonView.h
//  ti.material
//
//  Created by Ani Sinanaj on 16/02/2017.
//
//

#import "TiUIView.h"
#import "MDButton.h"
#import <UIKit/UIKit.h>

@interface TiMaterialButtonView : TiUIView {
    @private
        MDButton *button;
        int style;
        BOOL touchStarted;
}

-(MDButton*)button;

@end

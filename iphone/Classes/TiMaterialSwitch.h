//
//  TiMaterialSwitch.h
//  ti.material
//
//  Created by Ani Sinanaj on 22/02/2017.
//
//

#import <UIKit/UIKit.h>
#import "TiUIView.h"
#import "MDSwitch.h"

@interface TiMaterialSwitch : TiUIView {
    @private MDSwitch *switchUI;
}

@property (copy) NSString* onLabel;
@property (copy) NSString* offLabel;

@end

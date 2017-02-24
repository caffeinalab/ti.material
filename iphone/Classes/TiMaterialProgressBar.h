//
//  TiMaterialProgressbar.h
//  ti.material
//
//  Created by Ani Sinanaj on 20/02/2017.
//
//

#import <UIKit/UIKit.h>
#import "TiUIVIew.h"
#import "MDProgress.h"

@interface TiMaterialProgressBar : TiUIView {
    @private MDProgress *progress;
}

@property NSInteger *style;
@property NSInteger *type;

@end

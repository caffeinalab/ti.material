//
//  Toast.h
//  ti.material
//
//  Created by Ani Sinanaj on 10/02/2017.
//
//

#import <Foundation/Foundation.h>
#import "TiModule.h"
#import "TiProxy.h"

@interface TiMaterialToastProxy : TiProxy
    -(id)init;
    -(id)show:(id) args;
    -(id)setText:(id) args;
    -(id)setDuration:(id) args;
@end

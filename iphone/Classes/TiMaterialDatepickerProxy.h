//
//  Calendar.h
//  ti.material
//
//  Created by Ani Sinanaj on 10/02/2017.
//
//

#import "TiProxy.h"

@interface TiMaterialDatepickerProxy : TiProxy
    -(id)init;
    -(id)show:(id) args;
    -(NSDate *)today;
    -(id)setMinDate:(id) args;
    -(id)setSelectedDate:(id) args;
@end

//
//  SMStyle.m
//  GCDFetchFeed
//
//  Created by DaiMing on 16/1/21.
//  Copyright © 2016年 Starming. All rights reserved.
//

#import "SMStyle.h"

@implementation SMStyle
//--------------------------
//         UIFont
//--------------------------
+ (UIFont *)fontHuge {
    return [UIFont systemFontOfSize:18];
}
+ (UIFont *)fontBig {
    return [UIFont systemFontOfSize:16];
}
+ (UIFont *)fontNormal {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)fontSmall {
    return [UIFont systemFontOfSize:12];
}

//--------------------------
//         UIColor
//--------------------------
+ (UIColor *)colorGrayLight {
    return [UIColor colorWithHexString:@"cccccc"];
}
+ (UIColor *)colorGrayDark {
    return [UIColor colorWithHexString:@"666666"];
}
+ (UIColor *)colorOrangeLight {
    return [UIColor colorWithHexString:@"ff9933"];
}

//-------------------------
//         CGFloat
//--------------------------
+ (CGFloat)floatMarginMassive {
    return 20;
}
+ (CGFloat)floatMarginNormal {
    return 10;
}
+ (CGFloat)floatMarginMinor {
    return 5;
}
+ (CGFloat)floatTextIntervalHorizontal {
    return 8;
}
+ (CGFloat)floatTextIntervalVertical {
    return 10;
}
+ (CGFloat)floatIconNormal {
    return 30;
}

+ (CGFloat)floatCompatibleWithStyleName:(NSString *)styleName {
    return 0;
}
@end

//
//  GQQiziInfo.h
//  GuessQizi
//
//  Created by SuperMaxJ on 13-11-26.
//  Copyright (c) 2013年 supermaxdev. All rights reserved.
//

#import <Foundation/Foundation.h>

//棋子类别
typedef enum {
    QiziType_Bin = 0,   //兵
    QiziType_Pao,       //炮
    QiziType_Che,       //车
    QiziType_Ma,        //马
    QiziType_Xiang,     //象
    QiziType_Shi,       //仕
    QiziType_Shuai      //帅
} QiziType;

//棋子颜色
typedef enum {
    QiziColor_Hong = 0, //红色
    QiziColor_Lan       //蓝色
} QiziColor;

//棋子方向
typedef enum {
    QiziDirection_Up = UIImageOrientationUp,   //上
    QiziDirection_Down,     //下
    QiziDirection_Left,     //左
    QiziDirection_Right     //右
} QiziDirection;

typedef enum {    
    PlayingMethod_Type = 0,       //类型相同    50%
    PlayingMethod_Color,          //颜色相同    25%
    PlayingMethod_Direction,      //方向相同    10%
    PlayingMethod_None            //全不相同    15%
} PlayingMethod;

@interface GQQiziInfo : NSObject
@property (assign) QiziType         qiziType;
@property (assign) QiziColor        qiziColor;
@property (assign) QiziDirection    qiziDirection;
@property (nonatomic, strong) UIImage *qiziImg;

+ (GQQiziInfo *)generateQizi:(PlayingMethod)method
                      result:(BOOL)result
                referenceQizi:(GQQiziInfo *)referenceQizi;

+ (GQQiziInfo *)generateQizi;
@end

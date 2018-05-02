//
//  GQQiziInfo.m
//  GuessQizi
//
//  Created by SuperMaxJ on 13-11-26.
//  Copyright (c) 2013年 supermaxdev. All rights reserved.
//

#import "GQQiziInfo.h"
#define GENERATEQIZITYPE [self getRandomNumber:0 to:5]
#define GENERATEQIZICOLOR [self getRandomNumber:0 to:1]
#define GENERATEQIZIDIRECTION [self getRandomNumber:0 to:4]

@implementation GQQiziInfo
{
    PlayingMethod _method;
    BOOL _result;
    
    GQQiziInfo *_referenceQizi;
}

- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (GQQiziInfo *)generateQizi:(PlayingMethod)method
                      result:(BOOL)result
               referenceQizi:(GQQiziInfo *)referenceQizi
{
    return [[GQQiziInfo alloc] initWithQizi:method
                               result:result
                        referenceQizi:referenceQizi];
}

- (id)initWithQizi:(PlayingMethod)method
            result:(BOOL)result
     referenceQizi:(GQQiziInfo *)referenceQizi {
    self = [super init];
    
    if (self) {
        _method = method;
        _result = result;
        _referenceQizi = referenceQizi;
        [self generateQizi];
    }
    
    return self;
}

+ (GQQiziInfo *)generateQizi {
    return [[GQQiziInfo alloc] init];
}

- (id)init {
    self = [super init];
    
    if (self) {
        _qiziType = GENERATEQIZITYPE;
        _qiziColor = GENERATEQIZICOLOR;
        _qiziDirection = GENERATEQIZIDIRECTION;
        [self generateQiziImgV];
    }
    
    return self;
}

- (void)generateQiziImgV {
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"xiangqi_%d_%d", _qiziColor, _qiziType]];
    image = [UIImage imageWithCGImage:image.CGImage
                                scale:image.scale
                          orientation:(UIImageOrientation)_qiziDirection];
    _qiziImg = image;
}

- (void)generateQizi {
    switch (_method) {
        case PlayingMethod_Type:
            _qiziColor = GENERATEQIZICOLOR;
            _qiziDirection = GENERATEQIZIDIRECTION;
            
            if (_result) {
                _qiziType = _referenceQizi.qiziType;
            } else {
                do {
                    _qiziType = GENERATEQIZITYPE;
                } while (_qiziType==_referenceQizi.qiziType);
            }
            break;
            
        case PlayingMethod_Color:
            if (_result) {
                _qiziType = GENERATEQIZITYPE;
                _qiziDirection = GENERATEQIZIDIRECTION;
                _qiziColor = _referenceQizi.qiziColor;
            } else {
                do {
                    _qiziColor = GENERATEQIZICOLOR;
                } while (_qiziColor==_referenceQizi.qiziColor);
            }
            break;
            
        case PlayingMethod_Direction:
            if (_result) {
                _qiziType = GENERATEQIZITYPE;
                _qiziColor = GENERATEQIZICOLOR;
                _qiziDirection = _referenceQizi.qiziDirection;
            } else {
                do {
                    _qiziDirection = GENERATEQIZIDIRECTION;
                } while (_qiziDirection==_referenceQizi.qiziDirection);
            }
            break;
            
            //此处处理逻辑与上述逻辑完全不同，注意
        case PlayingMethod_None:
            if (_result) {
                do {
                    _qiziType = GENERATEQIZITYPE;
                } while (_qiziType==_referenceQizi.qiziType);
                
                do {
                    _qiziColor = GENERATEQIZICOLOR;
                } while (_qiziColor==_referenceQizi.qiziColor);
                
                do {
                    _qiziDirection = GENERATEQIZIDIRECTION;
                } while (_qiziDirection==_referenceQizi.qiziType);
            } else {
                int num = [self getRandomNumber:0 to:3];
                switch (num) {
                    case 0:
                        _qiziColor = _referenceQizi.qiziColor;
                        _qiziDirection = _referenceQizi.qiziDirection;
                        do {
                            _qiziType = GENERATEQIZITYPE;
                        } while (_qiziType==_referenceQizi.qiziType);
                        break;
                        
                    case 1:
                        _qiziType = _referenceQizi.qiziType;
                        _qiziDirection = _referenceQizi.qiziDirection;
                        do {
                            _qiziColor = GENERATEQIZICOLOR;
                        } while (_qiziColor==_referenceQizi.qiziColor);
                        break;
                        
                    default:
                        do {
                            _qiziType = _referenceQizi.qiziType;
                            _qiziColor = _referenceQizi.qiziColor;
                        } while (_qiziDirection==_referenceQizi.qiziDirection);
                        break;
                }
            }
            break;
            
        default:
            break;
    }
    
    [self generateQiziImgV];
}

@end

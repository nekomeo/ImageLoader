//
//  PhotoList.m
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-09.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "PhotoList.h"

@implementation PhotoList

- (instancetype)initWithPhotos:(NSMutableArray *)photos andIndex:(NSInteger)currentIndexNum
{
    if (self = [super init])
    {
        _photos = photos;
        _currentIndexNum = currentIndexNum;
    }
    return self;
}

@end

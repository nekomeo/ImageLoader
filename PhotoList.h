//
//  PhotoList.h
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-09.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoList : NSObject

@property (nonatomic) NSMutableArray *photos;
@property (nonatomic) NSInteger currentIndexNum;

- (instancetype)initWithPhotos:(NSMutableArray *)photos andIndex:(NSInteger)currentIndexNum;

@end

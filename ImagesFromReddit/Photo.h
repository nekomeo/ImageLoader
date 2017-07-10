//
//  Photo.h
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-08.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSString *commiter;
@property (nonatomic, strong) NSDate *dateUploaded;
@property (nonatomic, strong) NSString *subredditName;

- (instancetype)initWithData:(NSDictionary *)data;
- (UIImage *)downloadImage:(NSURL *)url;

- (void)downloadThumbnail;
- (void)downloadFullImage;

@end

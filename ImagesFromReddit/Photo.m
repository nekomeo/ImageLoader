//
//  Photo.m
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-08.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self)
    {// This should set all values to the values in the json object and nil for both images
        _title = data[@"title"];
        _imageURL = [NSURL URLWithString:data[@"url"]];
        _thumbnailURL = [NSURL URLWithString:data[@"thumbnail"]];
        _image = nil;
        _thumbnail = nil;
        _commiter = data[@"author"];
//        _dateUploaded = nil; // to be worked on later
        _subredditName = data[@"subreddit"];
    }
    return self;
}

- (UIImage *)downloadImage:(NSURL *)url
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    
    // Turn this image data into an image object
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    return image;
}

- (void)downloadThumbnail
{
    self.thumbnail = [self downloadImage:self.thumbnailURL];
}


- (void)downloadFullImage
{
    self.image = [self downloadImage:self.imageURL];
}

@end

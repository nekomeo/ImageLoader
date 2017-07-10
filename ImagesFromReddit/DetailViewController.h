//
//  DetailViewController.h
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-08.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "PhotoList.h"


@interface DetailViewController : UIViewController

@property (nonatomic) PhotoList *redditPhotos;

@end

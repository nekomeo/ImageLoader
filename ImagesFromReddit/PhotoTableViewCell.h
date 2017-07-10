//
//  PhotoTableViewCell.h
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-08.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

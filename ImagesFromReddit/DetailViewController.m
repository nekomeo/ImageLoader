//
//  DetailViewController.m
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-08.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (nonatomic) UIPinchGestureRecognizer *pinchedImage;
@property (nonatomic) UITapGestureRecognizer *tapImage;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    
    self.pinchedImage = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleImageView:)];
    
    [self.detailImageView addGestureRecognizer:self.pinchedImage];
    
    self.tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDifferentImage:)];
    [self.detailImageView addGestureRecognizer:self.tapImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView
{
    [self.redditPhotos.photos[self.redditPhotos.currentIndexNum] downloadFullImage];
    
    Photo *redditPhoto = self.redditPhotos.photos[self.redditPhotos.currentIndexNum];
    
    //    self.detailImageView.image = redditPhoto.image;
    
    [self.detailImageView sd_setImageWithURL:redditPhoto.imageURL placeholderImage:redditPhoto.thumbnail]; // Calls the third party library
    
    self.detailImageView.userInteractionEnabled = TRUE; // Responds to gestures
    
    self.detailTitleLabel.text = redditPhoto.title;
    
    self.detailTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailTitleLabel.numberOfLines = 0;
}

- (IBAction)scaleImageView:(UIPinchGestureRecognizer *)sender
{
    if (sender.scale > 1.0f && sender.scale <= 1.5f) //|| (sender.scale < 1.0f && sender.scale < 1.0f))
    {
        CGAffineTransform transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
        self.detailImageView.transform = transform;

        sender.scale = 1.0;
    }
}


- (IBAction)tapDifferentImage:(UITapGestureRecognizer *)sender
{
    NSUInteger touchCounter = 0;
    
    CGPoint touchPoint = [sender locationOfTouch:touchCounter inView:sender.view];
    
    if (touchPoint.x >= 330) // Go to next image if tapped within certain section of right side
    {
        self.redditPhotos.currentIndexNum++;
        [self configureView];
    }
    else if (touchPoint.x <= 70 && (self.redditPhotos.currentIndexNum != 0)) // Go to previous image if tapped within certain section of right side AND not first image.
    {
        self.redditPhotos.currentIndexNum--;
        [self configureView];
    }
}


@end

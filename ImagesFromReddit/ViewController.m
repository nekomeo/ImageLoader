//
//  ViewController.m
//  ImagesFromReddit
//
//  Created by Elle Ti on 2017-07-08.
//  Copyright © 2017 Elle Ti. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "PhotoTableViewCell.h"
#import "DetailViewController.h"
#import "PhotoList.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *redditArray;
@property (nonatomic) NSIndexPath *selectedIndexPath;

@property (nonatomic) PhotoList *photoList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Create a URL object containing the reddit url you wish to pull data from
    NSURL *url = [NSURL URLWithString:@"https://www.reddit.com/r/aww/.json"];
    // Create a NSURLReuqest object and set the URL you wish to connect to
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    // This is the settings for the session
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // This is setting up the session object
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // Establishes the session with the provided URL and pulls the data down
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error)
    {
        if (!error)
        {
            NSError *jsonError = nil;
            
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *imageArray = jsonDictionary[@"data"][@"children"];
            
            self.redditArray = [NSMutableArray array];
            
            for (NSDictionary *reddit in imageArray)
            {
                Photo *newPhoto = [[Photo alloc] initWithData:reddit[@"data"]];
                
                [newPhoto downloadThumbnail];
                
                // Add the Photos object to the redditArray
                [self.redditArray addObject:newPhoto];
            }
            
            self.photoList = [[PhotoList alloc] initWithPhotos:self.redditArray andIndex:0];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    
    [dataTask resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redditArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Photo *photo = self.redditArray[indexPath.item];
    
    cell.photo.image = photo.thumbnail;
    
    cell.captionLabel.text = photo.title;
    
    // Wraps caption in the label bounds
    cell.captionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.captionLabel.numberOfLines = 0;
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    self.selectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
//        Photo *selectedPhoto = [self.redditArray objectAtIndex:self.selectedIndexPath.row];
        
//        selectedPhoto.image = [selectedPhoto downloadImage:selectedPhoto.imageURL];
        
        self.photoList.currentIndexNum = self.selectedIndexPath.row;
        
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.redditPhotos = self.photoList;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // Deselects tableView row selected
}


@end

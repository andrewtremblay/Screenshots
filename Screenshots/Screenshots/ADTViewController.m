//
//  ADTViewController.m
//  Screenshots
//
//  Created by AndrewTremblay on 3/25/14.
//  Copyright (c) 2014 Andrew David Tremblay. All rights reserved.
//

#import "ADTViewController.h"


@interface ADTViewController ()
@end

@implementation ADTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get the assets library
    if (self.assetsLibrary == nil) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    
    __block NSMutableArray *blockSafeScreenshotPhotos = [NSMutableArray array];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         
         // Within the group enumeration block, filter to enumerate just photos.
         [group setAssetsFilter:[ALAssetsFilter allPhotos]];
         
         
         // For this example, we're only interested in the first item.
         [group enumerateAssetsUsingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop)
          {
              
              // The end of the enumeration is signaled by asset == nil.
              if (alAsset) {
                  ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                  NSDictionary *imageMetadata = [representation metadata];
                  // Do something interesting with the metadata.
                  //A screenshot metadata will not have EXIF data (for lens and camera stuff)
                  //other saved images might not have EXIF data either!
                  if(![imageMetadata objectForKey:@"{Exif}"]){
                      NSLog(@"screenshot maybe! %@", imageMetadata);
                      
                      [blockSafeScreenshotPhotos addObject:alAsset];
                  }
              }
          }];
         NSLog(@"%d possible screenshots", [blockSafeScreenshotPhotos count]);
         self.screenshotPhotoAssets = [blockSafeScreenshotPhotos copy];
         [self.collectionView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
     }
                         failureBlock: ^(NSError *error)
     {
         // Typically you should handle an error more gracefully than this.
         NSLog(@"No groups");
     }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.screenshotPhotoAssets) {
        _screenshotPhotoAssets = [[NSMutableArray alloc] init];
    } else {
        [self.screenshotPhotoAssets removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock screenShotEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result) {
//            ALAssetRepresentation *representation = [result defaultRepresentation];
//            NSDictionary *imageMetadata = [representation metadata];
//            // Do something interesting with the metadata.
//            //A screenshot metadata will not have EXIF data (for lens and camera stuff)
//            //other saved images might not have EXIF data either!
//            if(![imageMetadata objectForKey:@"{Exif}"]){
//                NSLog(@"screenshot maybe! %@", imageMetadata);
//                [self.screenshotPhotoAssets addObject:result];
//            }//add em all anyway!
            [self.screenshotPhotoAssets addObject:result];

        }
    };
    
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [self.assetsGroup setAssetsFilter:onlyPhotosFilter];
    [self.assetsGroup enumerateAssetsUsingBlock:screenShotEnumerationBlock];

	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.screenshotPhotoAssets.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // load the asset for this cell
    ALAsset *asset = self.screenshotPhotoAssets[indexPath.row];
    CGImageRef thumbnailImageRef = [asset thumbnail];
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
    
    // apply the image to the cell
    UIImageView *screenshotImageView = (UIImageView *)[cell viewWithTag:100];
    screenshotImageView.image = thumbnail;
    
    return cell;
}


@end

//
//  GalleryCollectionViewController.h
//  EventVer2
//
//  Created by apple on 09/03/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryCollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray *images;
@property(nonatomic)double hallValue;
@end



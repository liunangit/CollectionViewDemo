//
//  LineLayoutViewController.h
//  CollectionViewDemo
//
//  Created by tedliu on 12-10-31.
//
//

#import <UIKit/UIKit.h>

@interface LineLayoutViewController : UICollectionViewController

@end

@interface LineCell : UICollectionViewCell

@property (strong, nonatomic) UILabel* label;

@end

@interface LineLayout : UICollectionViewFlowLayout

@end
//
//  NormalLayoutViewController.m
//  CollectionViewDemo
//
//  Created by tedliu on 12-10-31.
//
//

#import "NormalLayoutViewController.h"
#import <QuartzCore/CALayer.h>
#import "APLCollectionViewController.h"

@interface NormalLayoutViewController ()

@end

@implementation NormalLayoutViewController

-(void)viewDidLoad
{
    [self.collectionView registerClass:[NormalCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self.collectionView registerClass:[NormalHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [self.collectionView registerClass:[NormalFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NormalCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%d",indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NormalHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        header.label.text = [NSString stringWithFormat:@"Header %d", indexPath.section];
        return header;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        NormalFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
        footer.label.text = [NSString stringWithFormat:@"Footer %d", indexPath.section];
        return footer;
    }
    
    return nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

@end

@implementation NormalCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)] autorelease];
        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:50.0];
        self.label.backgroundColor = [UIColor underPageBackgroundColor];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

- (void)dealloc
{
    self.label = nil;
    [super dealloc];
}


@end

@implementation NormalHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[[UILabel alloc] initWithFrame:self.bounds] autorelease];
        self.label.font = [UIFont boldSystemFontOfSize:16];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor grayColor];
        [self addSubview:self.label];
    }
    return self;
}

- (void)dealloc
{
    self.label = nil;
    [super dealloc];
}

@end

@implementation NormalFooter

- (void)dealloc
{
    [super dealloc];
}

@end

@implementation NormalDecoration

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0x67/255.0 green:0x9f/255.0 blue:0xca/255.0 alpha:1.0];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end


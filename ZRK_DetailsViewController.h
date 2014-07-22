//
//  ZRK_DetailsViewController.h
//  AppCode
//
//  Created by Roberta on 21/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRK_WebViewController;

@interface ZRK_DetailsViewController : UIViewController

@property(nonatomic) NSMutableArray * songs;
@property (nonatomic, weak) IBOutlet UITextField *artistName;
@property (nonatomic, weak) IBOutlet UITextField *trackName;
@property (nonatomic, weak) IBOutlet UITextField *collectionName;
@property (nonatomic, weak) IBOutlet UITextField *releaseDate;
@property (nonatomic, weak) IBOutlet UITextField *trackPrice;
@property (nonatomic, weak) IBOutlet UITextField *currency;
@property (nonatomic, weak) IBOutlet UIImageView *immagine;


- (IBAction)artistPreview:(id)sender;
- (IBAction)trackPreview:(id)sender;



@end

//
//  ZRK_DetailsViewController.h
//  AppCode
//
//  Created by Roberta on 21/07/14.
//  Copyright (c) 2014 Zerokod Interactive Media Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRK_WebViewController;
/*
@class ZRK_DetailsViewController;

@protocol ZRK_DetailsViewControllerDelegate <NSObject>
- (void)addItemViewController:(ZRK_DetailsViewController *)controller didFinishEnteringItem:(NSString *)item;
@end
*/
@interface ZRK_DetailsViewController : UIViewController
{
    
    
    /*
    __weak IBOutlet UITextField *artistName;
    
    __weak IBOutlet UITextField *trackName;
    
    __weak IBOutlet UITextField *collectionName;
    
    __weak IBOutlet UITextField *releaseDate;
    
    //__weak IBOutlet UILabel *trackPrice;
    
   // __weak IBOutlet UILabel *currency;
    
    __weak IBOutlet UIImage *immagine;
    
     //NSMutableArray * songs;
    //NSMutableArray * songs2;
     */
    
}
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

//@property (nonatomic, weak) id <ZRK_DetailsViewControllerDelegate> delegate;
// nuovo elemento
//- (id) initPerNuovoElemento:(NSMutableArray*)fillarr;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

//-(void)fillScheda:(NSMutableArray*)fillarr;

@end

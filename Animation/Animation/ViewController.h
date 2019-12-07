//
//  ViewController.h
//  Animation
//
//  Created by IndiaNIC on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIImageView *imgView[20];
    
    BOOL bTap;
    BOOL bFront;
    int intCount;
    int intXCount;
    int intYCount;
    CGPoint ptPrevLoc;
    CGPoint ptLastLoc; 
    NSTimer *timerStopMove;
    NSTimer *timerTemp;
    int intTemp;
    CGPoint ptLastLocation;
    int intNoOfImages;
    int intInc;
    BOOL boolDrawPath;
    NSMutableArray *mutArrPoints;
    IBOutlet UIImageView *imgViewTemp;
}

-(IBAction)frontBack_Click:(id)sender;
-(IBAction)random_Click:(id)sender;
-(IBAction)drawpath_Click:(id)sender;

@end

//
//  ViewController.m
//  Animation
//
//  Created by IndiaNIC on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    bTap = FALSE;
    intCount = 0;
    intXCount = 0;
    intYCount = 0;
    bFront = TRUE;
    intNoOfImages = 20;
    mutArrPoints = [[NSMutableArray alloc] init];
    boolDrawPath = FALSE;
    imgViewTemp.hidden = TRUE;
    intTemp = 0;
    int aIntInc = intInc;
    intInc = 5;
    int i = 0;
    for (int aIntIndex = intNoOfImages-1; aIntIndex>=0; aIntIndex--) {
        imgView[aIntIndex] = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, aIntInc, aIntInc)];
        aIntInc += intInc;
        imgView[aIntIndex].image = [UIImage imageNamed:@"ohm.png"];
        imgView[aIntIndex].center = self.view.center;
        [self.view addSubview:imgView[aIntIndex]];
        imgView[aIntIndex].alpha = 0.05*i;
        [imgView[aIntIndex] release];
        i++;
    }
}

-(IBAction)frontBack_Click:(id)sender
{
    if (timerStopMove) 
        [timerStopMove invalidate];
    static BOOL bFirst = TRUE;
    for (int aIntIndex = 0; aIntIndex<intNoOfImages; aIntIndex++) {
        [imgView[aIntIndex] removeFromSuperview];
    }
    intInc = 5;
    if (bFirst) {
        bFirst = FALSE;
        int aIntInc = 100;
        int i = 0;
        for (int aIntIndex = intNoOfImages-1; aIntIndex>=0; aIntIndex--) {
            imgView[aIntIndex] = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, aIntInc, aIntInc)];
            aIntInc -= intInc;
            imgView[aIntIndex].image = [UIImage imageNamed:@"ohm.png"];
            [self.view addSubview:imgView[aIntIndex]];
            imgView[aIntIndex].alpha = 0.07*i;
            [imgView[aIntIndex] release];
            i++;
        }
    }
    else
    {
        bFirst = TRUE;
        int i = 0;
        int aIntInc = intInc;
        for (int aIntIndex = intNoOfImages-1; aIntIndex>=0; aIntIndex--) {
            imgView[aIntIndex] = [[UIImageView alloc] initWithFrame:CGRectMake(110, 180, aIntInc, aIntInc)];
            aIntInc += intInc;
            imgView[aIntIndex].image = [UIImage imageNamed:@"ohm.png"];
            [self.view addSubview:imgView[aIntIndex]];
            imgView[aIntIndex].alpha = 0.07*i;
            [imgView[aIntIndex]release];
            i++;
        }
    }
    for (int aIntIndex = 1; aIntIndex<intNoOfImages; aIntIndex++) {
            imgView[0].center = self.view.center;
            imgView[aIntIndex].center = imgView[0].center;
    }
}
-(IBAction)drawpath_Click:(id)sender
{
    boolDrawPath = TRUE;
    imgViewTemp.hidden = FALSE;
}
-(IBAction)random_Click:(id)sender
{
    boolDrawPath = FALSE;
    imgViewTemp.hidden = TRUE;
    if (timerStopMove)
        [timerStopMove invalidate];
    timerStopMove = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(TimerFuncRandom2) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark

// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *uiTouch = [touches anyObject];
	CGPoint aPtTouchLocation = [uiTouch locationInView:self.view];	
    if (boolDrawPath) {
        [mutArrPoints removeAllObjects];
        NSMutableDictionary *aMutDicTemp = [[NSMutableDictionary alloc] init];
        [aMutDicTemp setValue:[NSString stringWithFormat:@"%f",aPtTouchLocation.x] forKey:@"X"];
        [aMutDicTemp setValue:[NSString stringWithFormat:@"%f",aPtTouchLocation.y] forKey:@"Y"];
        [mutArrPoints addObject:aMutDicTemp];
        [aMutDicTemp release];
        ptLastLocation = aPtTouchLocation;
    }
    else
    {
        int m_iImageWidth = 100;
        int m_iImageHeight = 100;
        ptPrevLoc = aPtTouchLocation;
        ptLastLoc = aPtTouchLocation;
        if((aPtTouchLocation.x < imgView[0].frame.origin.x + m_iImageWidth/2 + 50 && aPtTouchLocation.x > imgView[0].frame.origin.x - m_iImageWidth/2 + 50)&&(aPtTouchLocation.y < imgView[0].frame.origin.y + m_iImageHeight/2 + 50 && aPtTouchLocation.y > imgView[0].frame.origin.y - m_iImageHeight/2 + 50))
        {
            intCount = 0;
            bTap = YES;
            timerStopMove = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(TimerFunc) userInfo:nil repeats:NO];
        }
        else if((aPtTouchLocation.x < imgView[intNoOfImages-1].frame.origin.x + m_iImageWidth/2 + 50 && aPtTouchLocation.x > imgView[intNoOfImages-1].frame.origin.x - m_iImageWidth/2 + 50)&&(aPtTouchLocation.y < imgView[intNoOfImages-1].frame.origin.y + m_iImageHeight/2 + 50 && aPtTouchLocation.y > imgView[intNoOfImages-1].frame.origin.y - m_iImageHeight/2 + 50))
        {
            intCount = 0;
            bTap = YES;
            timerStopMove = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(TimerFunc) userInfo:nil repeats:NO];
        }      
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *uiTouch = [touches anyObject];
    CGPoint aPtTouchLocation = [uiTouch locationInView:self.view];
    if (boolDrawPath) {
        NSMutableDictionary *aMutDicTemp = [[NSMutableDictionary alloc] init];
        [aMutDicTemp setValue:[NSString stringWithFormat:@"%f",aPtTouchLocation.x] forKey:@"X"];
        [aMutDicTemp setValue:[NSString stringWithFormat:@"%f",aPtTouchLocation.y] forKey:@"Y"];
        [mutArrPoints addObject:aMutDicTemp];
        [aMutDicTemp release];
        
        CGPoint aPtCurrLocation = [uiTouch locationInView:imgViewTemp];
        UIGraphicsBeginImageContext(imgViewTemp.frame.size);
        [imgViewTemp.image drawInRect:CGRectMake(0, 0, imgViewTemp.frame.size.width, imgViewTemp.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), ptLastLocation.x, ptLastLocation.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), aPtCurrLocation.x, aPtCurrLocation.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        imgViewTemp.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        ptLastLocation = aPtCurrLocation;
        
    }
    else
    {
        if (bTap) {
            for (int aIntIndex = intNoOfImages-1; aIntIndex>=1; aIntIndex--) {
                imgView[aIntIndex].center = imgView[aIntIndex-1].center;
            }
            
            imgView[0].center = CGPointMake(aPtTouchLocation.x, aPtTouchLocation.y);
            
            if (timerStopMove) {
                [timerStopMove invalidate];
                timerStopMove = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(TimerFunc) userInfo:nil repeats:NO];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (boolDrawPath) {
        if (timerTemp)
            [timerTemp invalidate];
        timerTemp = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(moveImage) userInfo:nil repeats:YES];
        UIGraphicsBeginImageContext(imgViewTemp.frame.size);
        [imgViewTemp.image drawInRect:CGRectMake(0, 0, imgViewTemp.frame.size.width, imgViewTemp.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);   
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), ptLastLocation.x, ptLastLocation.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), ptLastLocation.x, ptLastLocation.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        imgViewTemp.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        bTap = NO;
        intCount = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        for (int aIntIndex = 1; aIntIndex<intNoOfImages; aIntIndex++) {
            imgView[aIntIndex].center = imgView[aIntIndex-1].center;
        }    
        if (timerStopMove) 
            [timerStopMove invalidate];
        [UIView commitAnimations]; 
    }
}

-(void)moveImage
{
    NSDictionary * aDicTemp = [mutArrPoints objectAtIndex:intTemp];
    //[aMutArrPoints removeObjectAtIndex:0];
    float aFloatX = [[aDicTemp valueForKey:@"X"] floatValue];
    float aFloatY = [[aDicTemp valueForKey:@"Y"] floatValue];
    
    for (int aIntIndex = intNoOfImages-1; aIntIndex>=1; aIntIndex--) {
        imgView[aIntIndex].center = imgView[aIntIndex-1].center;
    }
    
    imgView[0].center = CGPointMake(aFloatX, aFloatY);
    
    if (timerStopMove) {
        [timerStopMove invalidate];
        timerStopMove = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(TimerFunc) userInfo:nil repeats:NO];
    }
    intTemp++;
    if (intTemp == [mutArrPoints count]) {
        intTemp = 0;
        [timerTemp invalidate];
        timerTemp = nil;
        [mutArrPoints removeAllObjects];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        for (int aIntIndex = 1; aIntIndex<intNoOfImages; aIntIndex++) {
            imgView[aIntIndex].center = imgView[aIntIndex-1].center;
        }    
        if (timerStopMove) 
            [timerStopMove invalidate];
        [UIView commitAnimations];
        imgViewTemp.image = nil;
    }
}

-(void)TimerFuncRandom
{
    int aIntRandomX = arc4random()%(int)self.view.frame.size.width; 
    int aIntRandomY = arc4random()%(int)self.view.frame.size.height; 
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    int i = 1;
    if (aIntRandomX>imgView[0].center.x) {
        i=-1;
    }
    int j = 1;
    if (aIntRandomY>imgView[0].center.y) {
        j=-1;
    }
    int k=0;
    imgView[0].center = CGPointMake(aIntRandomX, aIntRandomY);
    for (int aIntIndex = 1; aIntIndex<intNoOfImages; aIntIndex++) {
        k++;
        CGPoint aPt = imgView[0].center;
        aPt.x += 10*i*k;
        aPt.y += 10*j*k;
        imgView[aIntIndex].center = aPt;
    }
    [UIView commitAnimations];
}

-(void)TimerFuncRandom2
{
    static int iDir = 1;
    static int iDir2 = 1;
    [UIView beginAnimations:nil context:nil];
    int iFactor = arc4random()%20;
    [UIView setAnimationDuration:0.5];
    CGPoint aPt = imgView[0].center;
    aPt.x+=iFactor*iDir;
    if (aPt.x < 0) {
        aPt.x = 1;
        iDir = 1;
    }
    if (aPt.x > 320) {
        aPt.x = 319;
        iDir = -1;
    }
    aPt.y+=iFactor*iDir2;
    if (aPt.y < 0) {
        aPt.y = 1;
        iDir2 = 1;
    }
    if (aPt.y > 480) {
        aPt.y = 479;
        iDir2 = -1;
    }
    imgView[0].center = CGPointMake(aPt.x, aPt.y);
    for (int i = intNoOfImages-1; i>=1; i--) {
        imgView[i].center = imgView[i-1].center;
    }
    
    [UIView commitAnimations];
}

-(void)TimerFunc
{
    intCount = 0;

    for (int i=0; i<intNoOfImages-1; i++)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        for (int aIntIndex = 1; aIntIndex<intNoOfImages; aIntIndex++) {
            imgView[aIntIndex].center = imgView[aIntIndex-1].center;
        }
        [UIView commitAnimations];
    }
}



- (void)dealloc 
{
    [super dealloc];
    [mutArrPoints release];
    mutArrPoints = nil;
}
@end

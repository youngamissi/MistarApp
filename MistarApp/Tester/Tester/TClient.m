//
//  TClient.m
//  Tester
//
//  Created by Andrew Breckenridge on 3/19/14.
//  Copyright (c) 2014 Andrew Breckenridge. All rights reserved.
//

#import "TClient.h"

@implementation TClient

- (void)print {
    NSLog(@"yo");
}

- (NSString *)percentEscapeString:(NSString *)string
{
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)string,
                                                                                 (CFStringRef)@" ",
                                                                                 (CFStringRef)@":/?@!$&'()*+,;=",
                                                                                 kCFStringEncodingUTF8));
    return [result stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}


- (void)loginToMistarWithPin:(NSString *)pin password:(NSString *)password success:(void (^)(void))successHandler failure:(void (^)(void))failureHandler {
    
    NSURL *url = [NSURL URLWithString:@"https://mistar.oakland.k12.mi.us/novi/StudentPortal/Home/Login"];
    
    //Create and send request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *postString = [NSString stringWithFormat:@"Pin=%@&Password=%@",
                            [self percentEscapeString:pin],
                            [self percentEscapeString:password]];
    NSData * postBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postBody];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         // do whatever with the data...and errors
         if ([data length] > 0 && error == nil) {
             NSError *parseError;
             NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
             if (responseJSON) {
                 // the response was JSON and we successfully decoded it
                 
                 NSLog(@"Response was = %@", responseJSON);
                 
                 // assuming you validated that everything was successful, call the success block
                 
                 if (successHandler)
                     successHandler();
             } else {
                 // the response was not JSON, so let's see what it was so we can diagnose the issue
                 
                 NSString *loggedInPage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 NSLog(@"Response was not JSON (from login), it was = %@", loggedInPage);
                 
                 if (failureHandler)
                     failureHandler();
             }
         }
         else {
             NSLog(@"error: %@", error);
             
             if (failureHandler)
                 failureHandler();
         }
     }];
}

- (void)requestMainPage {
    
    //Now redirect to assignments page
    
    NSURL *homeURL = [NSURL URLWithString:@"https://mistar.oakland.k12.mi.us/novi/StudentPortal/Home/PortalMainPage"];
    NSMutableURLRequest *requestHome = [[NSMutableURLRequest alloc] initWithURL:homeURL];
    [requestHome setHTTPMethod:@"GET"]; // this looks like GET request, not POST
    
    [NSURLConnection sendAsynchronousRequest:requestHome queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *homeResponse, NSData *homeData, NSError *homeError)
     {
         // do whatever with the data...and errors
         if ([homeData length] > 0 && homeError == nil) {
             NSError *parseError;
             NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:homeData options:0 error:&parseError];
             if (responseJSON) {
                 // the response was JSON and we successfully decoded it
                 
                 NSLog(@"Response was = %@", responseJSON);
             } else {
                 // the response was not JSON, so let's see what it was so we can diagnose the issue
                 
                 NSString *homePage = [[NSString alloc] initWithData:homeData encoding:NSUTF8StringEncoding];
                 NSLog(@"Response was not JSON (from home), it was = %@", homePage);
             }
         }
         else {
             NSLog(@"error: %@", homeError);
         }
     }];
    
}




@end
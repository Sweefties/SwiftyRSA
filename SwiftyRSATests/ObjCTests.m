//
//  ObjCTests.m
//  SwiftyRSA
//
//  Created by Lois Di Qual on 9/29/16.
//  Copyright © 2016 Scoop. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SwiftyRSATests-Swift.h"

@import SwiftyRSA;

@interface SwiftyRSAObjcTests : XCTestCase

@end

@implementation SwiftyRSAObjcTests

/**
 * These acts essentially as smoke tests to ensure that all the following methods are available in an ObjC context.
 * The actual unit tests are done in Swift in the same target.
 */
- (void)test_smoke {
    NSData* data = [TestUtils randomData:128];
    
    PublicKey* pub;
    pub = [[PublicKey alloc] initWithData:data error:nil];
    pub = [[PublicKey alloc] initWithPemEncoded:@"test" error:nil];
    pub = [[PublicKey alloc] initWithBase64Encoded:@"test" error:nil];
    pub = [[PublicKey alloc] initWithPemNamed:@"test" in: [NSBundle bundleForClass:[TestUtils class]] error:nil];
    pub = [[PublicKey alloc] initWithDerNamed:@"test" in: [NSBundle bundleForClass:[TestUtils class]] error:nil];
    [PublicKey publicKeysWithPemEncoded:@"test"];
    
    PrivateKey* priv;
    priv = [[PrivateKey alloc] initWithData:data error:nil];
    priv = [[PrivateKey alloc] initWithPemEncoded:@"test" error:nil];
    priv = [[PrivateKey alloc] initWithPemNamed:@"test" in: [NSBundle bundleForClass:[TestUtils class]] error:nil];
    priv = [[PrivateKey alloc] initWithDerNamed:@"test" in: [NSBundle bundleForClass:[TestUtils class]] error:nil];
    priv = [[PrivateKey alloc] initWithBase64Encoded:@"test" error:nil];
    
    Signature* signature;
    signature = [[Signature alloc] initWithBase64Encoded:@"test" error:nil];
    signature = [[Signature alloc] initWithData:data];
    
    ClearMessage* clear;
    clear = [[ClearMessage alloc] initWithBase64Encoded:@"test" error:nil];
    clear = [[ClearMessage alloc] initWithData:data];
    clear = [[ClearMessage alloc] initWithString:@"test" using:NSUTF8StringEncoding error:nil];
    
    EncryptedMessage* encrypted;
    encrypted = [[EncryptedMessage alloc] initWithBase64Encoded:@"test" error:nil];
    encrypted = [[EncryptedMessage alloc] initWithData:data];
    
    {
        PublicKey* publicKey = [TestUtils publicKey:@"swiftyrsa-public" error:nil];
        PrivateKey* privateKey = [TestUtils privateKey:@"swiftyrsa-private" error:nil];
        Signature* signature = [[Signature alloc] initWithData:data];
        ClearMessage* clearMessage = [[ClearMessage alloc] initWithData:data];
        [clearMessage data];
        [clearMessage base64String];
        [clearMessage encryptedWith:publicKey padding:kSecPaddingNone error:nil];
        [clearMessage signedWith:privateKey digestType:DigestTypeSha1 error:nil];
        [clearMessage verifyWith:publicKey signature:signature digestType:DigestTypeSha1 error:nil];
    }
    
    {
        PrivateKey* privateKey = [TestUtils privateKey:@"swiftyrsa-private" error:nil];
        EncryptedMessage* encryptedMessage = [[EncryptedMessage alloc] initWithData:data];
        [encryptedMessage data];
        [encryptedMessage base64String];
        [encryptedMessage decryptedWith:privateKey padding:kSecPaddingNone error:nil];
    }
}

@end

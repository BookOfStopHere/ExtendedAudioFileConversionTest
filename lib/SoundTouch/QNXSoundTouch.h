//
//  QNXSoundTouch.h
//  QNXAudioKitDemo
//
//  Created by yang on 2018/8/6.
//  Copyright © 2018年 yang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 使用float
 *  Demo 如下：
 
 
 // Processes the sound
 static void process(SoundTouch *pSoundTouch, WavInFile *inFile, WavOutFile *outFile)
 {
 #define BUFF_SIZE           6720
     int nSamples;
     int nChannels;
     int buffSizeSamples;
     SAMPLETYPE sampleBuffer[BUFF_SIZE];
 
     if ((inFile == NULL) || (outFile == NULL)) return;  // nothing to do.
 
     nChannels = (int)inFile->getNumChannels();
     assert(nChannels > 0);
     buffSizeSamples = BUFF_SIZE / nChannels;
 
     // Process samples read from the input file
     while (inFile->eof() == 0)
     {
         int num;
 
         // Read a chunk of samples from the input file
         num = inFile->read(sampleBuffer, BUFF_SIZE);
         nSamples = num / (int)inFile->getNumChannels();
 
         // Feed the samples into SoundTouch processor
         pSoundTouch->putSamples(sampleBuffer, nSamples);
 
         // Read ready samples from SoundTouch processor & write them output file.
         // NOTES:
         // - 'receiveSamples' doesn't necessarily return any samples at all
         //   during some rounds!
         // - On the other hand, during some round 'receiveSamples' may have more
         //   ready samples than would fit into 'sampleBuffer', and for this reason
         //   the 'receiveSamples' call is iterated for as many times as it
         //   outputs samples.
         do
         {
             nSamples = pSoundTouch->receiveSamples(sampleBuffer, buffSizeSamples);
             outFile->write(sampleBuffer, nSamples * nChannels);
         } while (nSamples != 0);
     }
 
     // Now the input file is processed, yet 'flush' few last samples that are
     // hiding in the SoundTouch's internal processing pipeline.
     pSoundTouch->flush();
     do
     {
         nSamples = pSoundTouch->receiveSamples(sampleBuffer, buffSizeSamples);
         outFile->write(sampleBuffer, nSamples * nChannels);
     } while (nSamples != 0);
 }
 
 *
 */

@interface QNXSoundTouch : NSObject

/**
 * 版本
 */
@property (readonly,nonatomic, copy) NSString *version;

/**
 * 默认 1.0
 */
@property (nonatomic, assign) float rate;

/**
 * 默认 1.0 
 */
@property (nonatomic, assign) float tempo;

/**
 * 正常 1.0
 *      > 1.0 higher pitch
 *      < 1.0 lower  pitch  
 */
@property (nonatomic, assign) float pitch;

/**
 * number of channels, 1 = mono, 2 = stereo
 */
@property (nonatomic, assign) unsigned int numChannels;

/**
 * Sets sample rate.
 */
@property (nonatomic, assign) unsigned int sampleRate;

/**
 * is speech
 */
@property (nonatomic, assign) BOOL isSpeech;

- (instancetype)init;

- (void)processSamples:(const SInt16 *)samples numOfSamples:(unsigned int)num;

- (uint)receiveSamples:(SInt16 *)outBuffer maxSamples:(uint)maxSamples;

- (void)flush;

- (void)clear;

- (uint)avaliableSamples;

- (BOOL)isEmpty;

- (unsigned int)numUnprocessedSamples;

@end

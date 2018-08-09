//
//  QNXSoundTouch.m
//  QNXAudioKitDemo
//
//  Created by yang on 2018/8/6.
//  Copyright © 2018年 yang. All rights reserved.
//

#import "QNXSoundTouch.h"
#import "SoundTouch.h"
using namespace soundtouch;

@interface QNXSoundTouch ()
{
    SoundTouch *_st;
}
@end

@implementation QNXSoundTouch

- (void)dealloc
{
    if(_st)
    {
        delete _st;
        _st = NULL;
    }
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self createSoundTouch];
    }
    return self;
}

- (void)createSoundTouch
{
     _st = new SoundTouch();
//    self.rate = 1.0;
//    self.tempo = 1.0;
//    self.pitch = 1.0;
    _st->setTempoChange(0);
    _st->setPitchSemiTones(0);
    _st->setRateChange(0);
    _version = [NSString stringWithUTF8String:_st->getVersionString()];
    self.isSpeech = YES;
//    _st->setTempoChange(0);
//    _st->setPitchSemiTones(0);
//    _st->setRateChange(0.5);
//
//    _st->setSetting(SETTING_USE_QUICKSEEK, 1);
//    _st->setSetting(SETTING_USE_AA_FILTER, 1);

}


- (void)setIsSpeech:(BOOL)isSpeech
{
    _isSpeech = isSpeech;
    if(isSpeech)
    {
        _st->setSetting(SETTING_SEQUENCE_MS, 40);
        _st->setSetting(SETTING_SEEKWINDOW_MS, 15);
        _st->setSetting(SETTING_OVERLAP_MS, 8);
    }
}

- (void)processSamples:(const SInt16 *)samples numOfSamples:(unsigned int)num
{
    if(samples)
    {
        if(_st)
        {
            int s = sizeof(SAMPLETYPE);
            _st->putSamples((const SAMPLETYPE *)samples, num);
        }
    }
}

- (void)setRate:(float)rate
{
    if(_st)
    {
        _rate = rate;
        _st->setRate(rate);
    }
}

- (void)setTempo:(float)tempo
{
    if(_st)
    {
        _tempo = tempo;
        _st->setTempo(tempo);
    }
}

- (void)setPitch:(float)pitch
{
    if(_st)
    {
        _pitch = pitch;
        _st->setPitch(pitch);
        _st->setPitchOctaves(0.318);
    }
}

- (void)setNumChannels:(unsigned int)numChannels
{
    if(_st)
    {
        _numChannels = numChannels;
        _st->setChannels(numChannels);
    }
}

- (void)setSampleRate:(unsigned int)sampleRate
{
    if(_st)
    {
        _sampleRate = sampleRate;
        _st->setSampleRate(sampleRate);
    }
}

- (void)flush
{
    if(_st)
    {
        _st->flush();
    }
}

- (void)clear
{
    if(_st)
    {
        _st->clear();
    }
}

- (unsigned int)numUnprocessedSamples
{
    if(_st)
    {
        return _st->numUnprocessedSamples();
    }
    return 0;
}

- (uint)receiveSamples:(SInt16 *)outBuffer maxSamples:(uint)maxSamples;
{
    if(_st)
    {
        return _st->receiveSamples((SAMPLETYPE *)outBuffer, maxSamples);
    }
    return 0;
}

- (uint)avaliableSamples
{
    if(_st)
    {
        return _st->numSamples();
    }
    return 0;
}

- (BOOL)isEmpty
{
    if(_st)
    {
        return _st->isEmpty() != 0;
    }
    return YES;
}

@end

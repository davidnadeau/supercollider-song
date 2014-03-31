s.boot;

(
t = Task{
	var hz = 4;
	var i = 0;
	var n= 0.25;
	var chipsize = 12;
	1.do{
		x = Synth(\SinPulser);
		1.wait;
		x.free;
	};
	1.do{
		hz = 4;
		Synth(\eightbitSnare);
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};

		Synth(\eightbitSnare);
		i = 0;
		hz = hz * 2;
		//new speed
		n = 0.15;
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};

		Synth(\eightbitSnare);
		i=0;
		hz = hz * 1.5;
		//new speed
		n = 0.2;
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};
	};
	1.do{
		x = Synth.new(\ambientBackground);
		1.wait;
		x.free;
	};
	1.do{
		x =  Synth.new(\ambientBackground);
		1.wait;
		y = Synth(\SinPulser);
		1.wait;
		Synth(\eightbitSnare);
		i=0;
		hz = hz * 1.5;
		n = 0.33;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};
		x.free;
		y.free;
	};
	1.do{
		hz = 1;
		b = Buffer.read(s,"/usr/share/SuperCollider/sounds/a11wlk01-44_1.aiff");
		100.do{
			Synth.new(\granularSynth, [\sndbuf, b, \hz, hz, \dur, 1]);
			(0.25).wait;
			hz = hz * 1.2;
		};

	};

	1.do{
		x = Synth.new(\SawPulser);
		5.wait;
		x.free;
	};
	1.do{
		x = Synth.new(\moogPulser);
		y = Synth.new(\SawPulser);
		15.wait;
		x.free;
		y.free;
	};
	2.do{
		x = Synth.new(\moogPulser);
		hz = 4;
		n=0.33;
		Synth(\eightbitSnare);
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};

		Synth(\eightbitSnare);
		i = 0;
		hz = hz * 2;
		//new speed
		n = 0.15;
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};

		Synth(\eightbitSnare);
		i=0;
		hz = hz * 1.5;
		//new speed
		n = 0.2;
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};
		x.free;
	};
	20.do{
		x =  Synth.new(\ambientBackground);
		//y = Synth.new(\moogPulser);
		hz = 4;
		Synth(\eightbitSnare);
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};

		Synth(\eightbitSnare);
		i = 0;
		hz = hz * 2;
		//new speed
		n = 0.15;
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};

		Synth(\eightbitSnare);
		i=0;
		hz = hz * 1.5;
		//new speed
		n = 0.2;
		a = Scale.choose;
		chipsize.do {
			Synth(\chiptune, [\fund,a.cents[i % a.size] + 1, \hz, hz]);
			i = i + 1;
			n.wait;
		};
		x.free;
		//y.free;
	};
};
t.start;
)


(
SynthDef(\eightbitSnare, {
	var sig, freq, amp, env;

	env = EnvGen.ar(Env.perc(0.005, 0.5, 6, -8), doneAction: 2);
	sig = WhiteNoise.ar(1) * env;
	sig = FreeVerb.ar(sig, 0.4, 0.1, 0.9);


	Out.ar(0,sig * 0.7);
}).add;
Synth.new(\eightbitSnare);
)

(
SynthDef(\chiptune, {
	arg fund = 120, hz = 8;
	var env, sig, amp, freq;

	amp = LFPulse.ar(hz, 0, 0.5);
	env = EnvGen.ar(Env.perc);
	sig = Pulse.ar(fund, 0.5, amp)* env;

	sig = FreeVerb.ar(sig, 0.7, 0.8, 0.25);
	Out.ar(0, sig * 0.8);
}).add;
)


(
SynthDef(\ambientBackground, {
	var env, freq, sig;

	//env = EnvGen.ar(Env.perc, doneAction: 2);
	freq = LFNoise2.ar(1, 100, LFDNoise0.ar(1, 100, 220));
	sig = LFSaw.ar(freq, 2, 0.1);
	sig = FreeVerb.ar(sig, 0.5, 0.5, 0.4);

	freq = LFDNoise0.ar(PinkNoise.kr(10), 100, 220);
	sig = sig + SinOsc.ar(freq, 0.5 , 0.5);

	freq = LFDNoise0.ar(PinkNoise.kr(10), 100, 220);
	sig = Pulse.ar(freq, 0.5, 0.3);
	sig = FreeVerb.ar(sig, 0.9, 0.9, 0.3, 0.8);

	Out.ar(0, sig);
}).add;
)


(
SynthDef(\SawPulser, {
	var pitchRand, env, freq, sig;


	freq = LFDNoise1.kr(5, 350, 450);
	sig = Saw.ar(freq) * (HenonN.ar(5)*0.5);

	Out.ar(0, sig);
}).add;
)

(
SynthDef(\moogPulser, {
	var sig;

	sig = MoogFF.ar(
        Pulse.ar([40,121], [0.3,0.7]),
        SinOsc.kr(LFNoise0.kr(0.42).range(0.001, 2.2)).range(30, 4200),
        0.83 * 4);

	Out.ar(0,sig);
}).add;
)

(
SynthDef(\SinPulser, {
	var pitchRand, env, freq, sig;

	pitchRand = LFDNoise0.ar(1, 0, 5);
	freq = LFDNoise0.ar(pitchRand, 300, 450);
	freq = freq + LFDNoise3.ar(1, 350, 450);
	sig = SinOsc.ar(freq * 0.5);
	sig = FreeVerb.ar(sig, 0.525, 0.915, 0.5);

	Out.ar(0, sig);
}).add;
)


b = Buffer.read(s, "/home/soote/documents/school/4p98/a3/SuperCollider/vertical.wav");
(
x = SynthDef("tutorial-PlayBuf",{ arg bufnum;
	Out.ar( 0,PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum)))
}).play(s,[\bufnum, b.bufnum ]);
)


(
var winenv;

// a custom envelope
winenv = Env([0, 1, 0], [0.5, 0.5], [8, -8]);
z = Buffer.sendCollection(s, winenv.discretize, 1);

SynthDef(\granularSynth, {
	arg  sndbuf, hz = 10, dur=0.1;
    // use mouse x to control panning
    Out.ar(0,
        GrainBuf.ar(2, Impulse.kr(hz), dur, sndbuf, LFNoise1.kr.range(0.5, 2),
            LFNoise2.kr(0.1).range(0, 1), 2, 0, -1))

}).add;
)

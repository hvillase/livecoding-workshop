//=====================================================
// Live Coding: el paradigma de la programacion en vivo
// Hernani Villaseñor
// Centro Multimedia
// www.hernanivillasenor.com
//=====================================================

// Ejemplo 1: Hola Mundo !

s.boot; 
{SinOsc.ar}.play

// perfecto !! suena un tono

// Ejemplo 2: sintaxis

{SinOsc.ar(440, 0, 1)}.play;

// { } engloba una funcion
// SinOsc es un objeto
// .ar indica el audio rate
// ( ) engloba los argumentos del objeto
// 440 es el valor del argumento frecuencia
// , separa cada argumento
// 0 es el argumento de fase 
// 1 es el argumento de amplitud o mul
// .play es un mensaje

{|frec=440| SinOsc.ar(frec, 0, 1)}.play;

// || adentro se declaran los argumentos
// frec=440 argumento con un nombre y valor

{var mouse=MouseX.kr(300, 600); SinOsc.ar(mouse,0,1)}.play;

// var indica variables (locales)
// mouse es la primer variable
// MouseX es el objeto para el raton
// .kr indica el control rate
// 300 es el valor m
// 600 es el valor m
// ; indica un quiebre en el codigo

a={|frec=440| SinOsc.ar(frec,0,1)}.play;
a.set(\frec, 880);

// 'a' es una variable (global)
// a.set es una variable con el mensaje set
// \frec es la forma de llamar al argumento frec
// 880 es el nuevo valor de frec

// TODO JUNTO !!

b={|amp=1|var mouse=MouseX.kr(300,600); SinOsc.ar(mouse,0,amp)}.play;
b.set(\amp,0.5);
b.set(\amp, 0);

// Ejemplo 3: variables

(
{var sin, pulso;
sin = SinOsc.ar(300,0,0.2);
pulso = Pulse.ar (0.5,0.1,0.1);
sin * pulso}.play;
);

// variable globales

~frec = 800;
~pulso = 3;

{SinOsc.ar(~frec,0,Line.kr(0.01,0.5,10)) * Pulse.ar(~pulso,0.2,0.1)}.play;

// Ejemplo 4: argumentos

// frecuencia 400, a la mitad de su amplitud (0.5)
{SinOsc.ar(400,0,0.5)}.play;

// frecuecncia 500, el valor de phase ahora es pi radianes
{SinOsc.ar(500,pi,0.5)}.play;

// frecuencia 300, con amplitud baja (0.1)
{SinOsc.ar(300,0,0.1)}.play;

// ejemplos con scope

// vemos el resultado gren el scope
{SinOsc.ar(300,0,0.5)}.scope;

// aumenta la amplitud al sumar dos ondas
{SinOsc.ar(300,0,0.5) + SinOsc.ar(300,0,0.5)}.scope;

// se cancela la sepor la diferencia de fase
{SinOsc.ar(300,0,0.5) + SinOsc.ar(300,pi,0.5)}.scope;

// Ejemplo 05: ProxySpace

p=ProxySpace.push(s.boot);

~salida.play;

~salida={LFTri.ar(400,0,0.5)};

// intenta cambiar el valor de 400 por otra frecuencia y declara nuevamente el codigo

// Ejemplo 06: play/stop pause/resume send/release

// observa que al declarar esta lse activa un Synth en el server
~salida.play;

// observa que al declarar esta otra linea activa otro Synth en el server
~salida={LFTri.ar(Line.kr(200,500,10),0,0.5)};

// observa que al declarar esta linea desactiva una Synth en el server y el proceso se para de golpe
~salida.stop;

// al declarar esta linea comienza a sonar de nuevo el sinte
~salida.play;

//usamos pause/resume para comparar el comportamiento, la accion es abrupta
~salida.pause;
~salida.resume;

// usamos send/release para comprarar el comportamiento, observa que al activar send el sinte vuelve a inciar desde el inicio
~salida.release;
~salida.send;

// generamos un fadeTime para que los mensajes sean leidos de manera suavizada o agregar expresion
~salida.fadeTime=4;
~salida.send;
~salida.release;

// Ejemplo 7: metodos set y xset

// establecemos un fadeTime general
p.fadeTime=5;

~a.play;

// un sinte con variables y paneo
~a={|frec=200, amp=0.1,pan=0|Pan2.ar(LFTri.ar(frec,0,amp),pan,1)};

// cambiamos valor de argumento con set, es inmediato
~a.set(\frec,250);

// cambiamos valor de argumento con xset, e tiempo depende de fadeTime
~a.xset(\frec,300);
~a.xset(\frec,400, \amp, 0.2);
~a.xset(\frec,350, \amp,0.2, \pan, -1);
~a.xset(\frec,350, \amp,0.2, \pan, 1);
~a.stop;

// Ejemplo 8: control y mapeo

// establecemos un fadeTime general
p.fadeTime=5;

// creamos una variable de control
~c.kr;

// usamos LFCube para controlar la frecuencia. LF viene de Low Frequency
~c={LFCub.kr(10,0,150,200)};

// creamos nuestro sinte
~b.play;

// observa que el argumento frecuencia es sustituido por la varible de control ~c.kr
~b={Pan2.ar(SinOsc.ar(~c.kr,0,0.1),0,1)};

// creamos un sinte con el argumento frec
~d.play;
~d={|frec=200| Pan2.ar(SinOsc.ar(frec,0,0.1),0,1)};

// creamos una variable con un objeto de control
~e={MouseX.kr(200,2000)};

// con el mensaje .map anidamos el control Mouse a la frecuencia
~d.map(\frec, ~e);

// con .unmap quitamos el mapeo
~d.unmap;

// .xmap es un mapeo con crossfade que depende de fadeTime
~d.xmap(\frec, ~e);
~d.unmap;

// Ejemplo 9: valores aleatorios

~a.play;

~a={Pan2.ar(SinOsc.ar(SinOsc.kr(exprand(1.0,4.0),0,100,200) * rrand(1.0,2.0),0,0.1),0,1)};

~a.fadeTime=3;

// reconstruye los valores
~a.rebuild;

~a.stop;

// Ejemplo 10: pulsos

~a.play;

// una onda triangular multipicada por un pulso, observa que pasa si cambias el tercer argumento del pulso que es el ancho de pulso
~a={LFTri.ar(200,0,0.1) * LFPulse.ar(2,0,0.1)};

// usando dos canales
~a={LFTri.ar([150,200],0,0.1)*LFPulse.ar([2,1],0,0.1)};

// creamos argumentos
~a={|pulso1=1, pulso2=2, ancho=0.1|LFTri.ar([150,200],0,0.1)*LFPulse.ar([pulso1,pulso2],0,ancho)};

~a.set(\pulso1, 3, \pulso2, 1, \ancho, 0.4);

// pulsos con LFNoise0

~b.play;

~b={|pulso=1|Pan2.ar(SinOsc.ar(200,0,0.2)*LFNoise0.kr(pulso),0,1)};

~b.set(\pulso, 2);

// Ejemplo 11:  secuencias con Demand

// programamos una secuencia bajo demanada con Demand
~c={Demand.kr(Impulse.kr(8),0,Dseq([200,400,800,1600,750,100,1600,80,750,100],inf))};

// anidamos la secuencia con el metodo en la frecuencia
~a.play;
~a={Pan2.ar(SinOsc.ar(~c.kr,0,0.2),0,1)};

// ahora hacemos lo mismo con Duty
~d={Duty.ar(1/8,0,Dseq([300,600,900,150,1200,450,1500,900],inf))};

// sustituimos ~c.kr por ~d.kr
~a={Pan2.ar(SinOsc.ar(~d.kr,0,0.2),0,1)};

// agregamos un Dseq al primer argumento de Duty
~d={Duty.ar(Dseq([1/8,1/4,1/8,1/2,1/4],inf),0,Dseq([300,600,900,150,1200,450,1500,900,1500],inf))};

~a.release;
~a.clear;

// Ejemplo 12: reloj y cuantizacion

p.fadeTime=4;

// corremos estos sintes y observamos que pasa con la sinconizacion

~a.play;
~a={Pan2.ar(LFTri.ar(300,0,0.3) * LFPulse.kr(4,0,0.1,0.2),0,1)};

~b.play;
~b={Pan2.ar(LFTri.ar(100,0,0.3) * LFPulse.kr(2,0,0.1,0.2),0,1)};

p.clear;

// establecemos un reloj de referencia y cuantizamos a 1 segundo
p.clock= TempoClock.default; p.quant=1.0;

~a.play;
~a={Pan2.ar(LFTri.ar(200,0,0.3) * LFPulse.kr(1,0,0.1,0.2),0,1)};

~b.play;
~b={Pan2.ar(LFTri.ar(400,0,0.3) * LFPulse.kr(4,0,0.1,0.2),0,1)};

p.clear;

// Ejemplo 13: Patterns y SynthDef

p.clock= TempoClock.default; p.quant=1.0;

~a.play;

// suena un sinte preestablecido, cada 0.5 segundos, cambiemos ese valor
~a=Pbind(\dur, 0.5);

// agregamos el valor de amp
~a=Pbind(\dur, 1, \amp, 0.2);

// lo ponemos en pausa y observamos que Pattern tambien responde a este tipo de mensajes
~a.stop;

// agregamos un patron de secuencia llamado Pseq en el valor de duracion para crear ritmos
~a=Pbind(\dur, Pseq([0.25,0.5,0.5],inf), \amp, 0.1);

// lo echamos a andar nuevamente
~a.play;

// agregamos un Pseq al valor de frecuencia
~a=Pbind(\dur, Pseq([0.25,0.5,0.5],inf), \amp, 0.1, \freq, Pseq([100,200,300],inf));

// cambiamos el Pseq de la duracion por un Prand para tener un comportamiento aleatorio sobre el ritmo
~a=Pbind(\dur, Prand([0.25,0.5,0.125],inf), \amp, 0.1, \freq, Pseq([100,200,300],inf));

// agregamos el mensaje .mirror al Pseq de freq, y dejamos la duracion fija
~a=Pbind(\dur, Prand([0.25],inf), \amp, 0.1, \freq, Pseq([100,200,300].mirror,inf));

// observa que pasa su cambiamos el mensaje mirror por pyramid
~a=Pbind(\dur, Prand([0.25],inf), \amp, 0.1, \freq, Pseq([100,200,300].pyramid,inf));

// ahora una escala mayor con el mensaje .midicps
~a=Pbind(\dur, Prand([0.125],inf), \amp, 0.1, \freq, Pseq([60,62,64,65,67,69,71,72].midicps,inf));

~a.stop;

// declaramos este SynthDef
(
~sinte=SynthDef(\sinte,{|out=0|
	Out.ar(out,Pan2.ar(SinOsc.ar(200,0,0.1)*EnvGen.kr(Env.perc(0.1,0.1),doneAction:2)))
}).add
);

// lo llamamos desde un Pbind, con el argumento instrument y los hacemos sonar
~b.play;
~b=Pbind(\instrument, \sinte, \dur, Pseq([0.125, 0.5],inf));

// agregamos argumentos a nuestro SynthDef
(
~sinte=SynthDef(\sinte,{|out=0, freq=200, rel=0.1|
	Out.ar(out,Pan2.ar(SinOsc.ar(freq,0,0.1)*EnvGen.kr(Env.perc(rel,0.1),doneAction:2)))
}).add
);

//lo hacemos sonar otra vez con estos argumentos nuevos asignados a Patterns
~b=Pbind(\instrument, \sinte, \dur, 0.5, \freq, Prand([100,200,300,400,500],inf), \rel, Prand([0.1,0.2,0.3,1],inf));

~b.stop;

// Ejemplo 14: History

// comenzamos a registrar la historia
History.start;

p=ProxySpace.push(s.boot);

~h.play;
~h={LFTri.ar([400,500],0,0.2)};
~h={LFTri.ar([300,450],0,0.2)!2};
~h.release;

p.clear;
p.pop;

// finalizamos de registrar la historia
History.end;

// abrimos el documento 
History.document;

// reproducimos nuestra programacion
History.play;

// salvamos nuestra programacien un documento de SC
// la ruta cambia dependiendo de la computadora
History.saveStory("/home/hernani/Documentos/historia1.scd");

// cargamos una programacianterior
History.loadStory("/home/hernani/Documentos/historia1.scd");

// limpiamos el historial
History.clear;

// podemos usar una ventana para visualizar los datos
History.makeWin;

// Ejemplo 15: conexion en red

// enviar mensajes OSC
n=NetAddr("127.0.0.1",57120);

n.sendMsg("/impulso", 3);

// recibir mensajes OSC
(
o=OSCdef(\enviar, {|msg|
	~a.set(\imp,msg[1].postln);
}, "\impulso").fix
);

~a.play;
~a={|imp=10|SinOsc.ar(Stepper.kr(Impulse.kr(imp),0,3,11,-5)*50,0,0.5)!2};
~a.set(\imp, 2);

p.clear(10);

// salimos del ambiente Proxy
p.pop;
